import 'package:shared_preferences/shared_preferences.dart';
import '../models/emission_models.dart';

class CarbonCalculationService {
  // Calculate transportation emissions
  double calculateTransportEmissions(String transportType, double distance) {
    switch (transportType) {
      case 'car':
        return distance * EmissionFactors.car;
      case 'bus':
        return distance * EmissionFactors.bus;
      case 'train':
        return distance * EmissionFactors.train;
      case 'plane':
        return distance * EmissionFactors.plane;
      default:
        return 0;
    }
  }
  
  // Calculate energy emissions
  double calculateEnergyEmissions(double kwhUsed) {
    return kwhUsed * EmissionFactors.electricity;
  }
  
  // Calculate food emissions
  double calculateFoodEmissions(String mealType, int meals) {
    switch (mealType) {
      case 'meat':
        return meals * EmissionFactors.meatMeal;
      case 'vegetarian':
        return meals * EmissionFactors.vegetarianMeal;
      case 'vegan':
        return meals * EmissionFactors.veganMeal;
      default:
        return 0;
    }
  }
  
  // Log an emission activity
  Future<void> logEmission(EmissionCategory category, double amount) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Get total emissions for today
    final DateTime now = DateTime.now();
    final String today = "${now.year}-${now.month}-${now.day}";
    
    // Store in SharedPreferences with date
    double currentTotal = prefs.getDouble('emissions_$today') ?? 0;
    await prefs.setDouble('emissions_$today', currentTotal + amount);
    
    // Update total time emitted
    int secondsEmitted = prefs.getInt('seconds_emitted_$today') ?? 0;
    await prefs.setInt('seconds_emitted_$today', secondsEmitted + 1800); // Add 30 min default
    
    // Calculate percentage compared to target (e.g., 10kg CO2 target per day)
    const double dailyTarget = 10.0;
    double percentageOfTarget = ((currentTotal + amount) / dailyTarget) * 100;
    await prefs.setDouble('co2_percentage', percentageOfTarget);
    
    // Format time for display
    int hours = (secondsEmitted + 1800) ~/ 3600;
    int minutes = ((secondsEmitted + 1800) % 3600) ~/ 60;
    await prefs.setString('time_emitted', "${hours}h ${minutes}m");
    
    // Compare with yesterday
    final String yesterday = "${now.year}-${now.month}-${now.day - 1}";
    double yesterdayTotal = prefs.getDouble('emissions_$yesterday') ?? 0;
    
    String trend;
    if (currentTotal + amount < yesterdayTotal) {
      trend = "Better than yesterday";
    } else if (currentTotal + amount > yesterdayTotal) {
      trend = "Worse than yesterday";
    } else {
      trend = "Same as yesterday";
    }
    await prefs.setString('trend_comparison', trend);
  }
  
  // Get carbon data for UI display and chatbot context
  Future<Map<String, dynamic>> getCarbonData() async {
    final prefs = await SharedPreferences.getInstance();
    final DateTime now = DateTime.now();
    final String today = "${now.year}-${now.month}-${now.day}";
    
    return {
      'co2_percentage': prefs.getDouble('co2_percentage') ?? 0.0,
      'time_emitted': prefs.getString('time_emitted') ?? "0h 0m",
      'trend_comparison': prefs.getString('trend_comparison') ?? "No data",
      'total_today': prefs.getDouble('emissions_$today') ?? 0.0,
    };
  }
}