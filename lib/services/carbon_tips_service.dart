import '../models/emission_models.dart';

class CarbonTipsService {
  // Get general tips
  List<String> getGeneralTips() {
    return [
      "Try to reduce car travel by walking or cycling for short journeys.",
      "Switch off lights and appliances when not in use to save electricity.",
      "Consider eating more plant-based meals to reduce your carbon footprint.",
      "Take shorter showers to reduce water heating energy.",
      "Use reusable bags, bottles, and containers to reduce waste.",
      "Plan your errands efficiently to minimize travel distance.",
      "Consider using public transport for your daily commute.",
      "Reduce food waste by planning meals and storing food properly.",
      "Buy local and seasonal food to reduce transportation emissions.",
      "Set your thermostat a few degrees lower in winter and higher in summer.",
    ];
  }

  // Get category-specific tips
  List<String> getCategoryTips(EmissionCategory category) {
    switch (category) {
      case EmissionCategory.transportation:
        return [
          "Consider carpooling or using ride-sharing services.",
          "Maintain your vehicle properly for better fuel efficiency.",
          "Combine multiple errands into one trip.",
          "Consider a hybrid or electric vehicle for your next car.",
          "Use video conferencing instead of traveling for meetings when possible.",
        ];
      case EmissionCategory.energy:
        return [
          "Switch to LED light bulbs to reduce electricity usage.",
          "Use a programmable thermostat to optimize heating and cooling.",
          "Add insulation to your home to reduce energy needs.",
          "Consider installing solar panels if suitable for your location.",
          "Wash clothes in cold water and hang them to dry when possible.",
        ];
      case EmissionCategory.food:
        return [
          "Try to have one meat-free day per week.",
          "Buy local and seasonal produce to reduce transportation emissions.",
          "Reduce food waste by planning meals carefully.",
          "Compost food scraps instead of sending them to landfill.",
          "Choose organic foods when possible to reduce chemical use.",
        ];
      case EmissionCategory.waste:
        return [
          "Recycle paper, plastic, glass, and metal properly.",
          "Use reusable shopping bags instead of plastic bags.",
          "Buy products with minimal packaging.",
          "Donate or sell items instead of throwing them away.",
          "Compost food and yard waste.",
        ];
      case EmissionCategory.consumption:
        return [
          "Buy quality items that will last longer.",
          "Repair items instead of replacing them when possible.",
          "Buy second-hand items when appropriate.",
          "Choose products with sustainable or recycled materials.",
          "Consider the environmental impact of online shopping and deliveries.",
        ];
      default:
        return getGeneralTips();
    }
  }

  // Get personalized tips based on carbon data
  List<String> getPersonalizedTips(Map<String, dynamic> carbonData) {
    List<String> tips = [];
    
    // High usage tips
    if (carbonData['co2_percentage'] > 80) {
      tips.add("Your carbon usage is high today. Try to identify your biggest sources of emissions.");
      tips.add("Consider offsetting some of your carbon emissions through verified carbon offset programs.");
    }
    
    // Trend-based tips
    if (carbonData['trend_comparison'].contains('Worse')) {
      tips.add("Your emissions are higher than yesterday. Try to identify what changed in your routine.");
    } else if (carbonData['trend_comparison'].contains('Better')) {
      tips.add("Great job! Your emissions are lower than yesterday. Keep up the good work!");
    }
    
    // Add general tips if needed
    if (tips.isEmpty) {
      tips.add("Keep tracking your emissions to build awareness of your carbon footprint.");
    }
    
    return tips;
  }

  // Generate a chatbot response based on user input and carbon data
  String generateResponse(String userMessage, Map<String, dynamic> carbonData) {
    userMessage = userMessage.toLowerCase();
    
    // Check for specific questions or commands
    if (userMessage.contains('tip') || userMessage.contains('advice')) {
      final tips = getGeneralTips();
      return tips[DateTime.now().millisecond % tips.length];
    }
    
    if (userMessage.contains('my carbon') || userMessage.contains('my footprint')) {
      return "Your carbon footprint today is ${carbonData['total_today'].toStringAsFixed(1)} kg CO₂, "
          "which is ${carbonData['co2_percentage'].toStringAsFixed(1)}% of your daily target. "
          "${carbonData['trend_comparison']}.";
    }
    
    if (userMessage.contains('how to reduce') || userMessage.contains('lower my')) {
      if (userMessage.contains('transport') || userMessage.contains('car') || userMessage.contains('travel')) {
        final tips = getCategoryTips(EmissionCategory.transportation);
        return tips[DateTime.now().millisecond % tips.length];
      }
      
      if (userMessage.contains('energy') || userMessage.contains('electricity') || userMessage.contains('power')) {
        final tips = getCategoryTips(EmissionCategory.energy);
        return tips[DateTime.now().millisecond % tips.length];
      }
      
      if (userMessage.contains('food') || userMessage.contains('eat') || userMessage.contains('meal')) {
        final tips = getCategoryTips(EmissionCategory.food);
        return tips[DateTime.now().millisecond % tips.length];
      }
      
      // Default reduction tip
      final tips = getGeneralTips();
      return "To reduce your carbon footprint: " + tips[DateTime.now().millisecond % tips.length];
    }
    
    // Check greeting patterns
    if (userMessage.contains('hello') || userMessage.contains('hi') || userMessage.contains('hey')) {
      return "Hello! I'm your carbon assistant. I can help you track and reduce your carbon footprint. How can I help you today?";
    }
    
    // Check for thank you
    if (userMessage.contains('thank') || userMessage.contains('thanks')) {
      return "You're welcome! I'm here to help you reduce your carbon footprint.";
    }
    
    // Default responses
    List<String> defaultResponses = [
      "I'm here to help you reduce your carbon footprint. You can ask me about your emissions or for tips on how to reduce them.",
      "Would you like to know more about your carbon footprint today or get some tips to reduce it?",
      "I can provide tips on reducing emissions from transportation, energy use, food choices, and more. What would you like to know about?",
      "Remember, small changes in your daily habits can make a big difference to your carbon footprint over time.",
    ];
    
    return defaultResponses[DateTime.now().millisecond % defaultResponses.length];
  }
}