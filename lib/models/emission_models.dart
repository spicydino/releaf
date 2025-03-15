enum EmissionCategory {
  transportation,
  energy,
  food,
  consumption,
  waste
}

class EmissionFactors {
  // Transportation (in kg CO2 per km)
  static const double car = 0.171;
  static const double bus = 0.105;
  static const double train = 0.041;
  static const double plane = 0.255;
  
  // Energy (in kg CO2 per kWh)
  static const double electricity = 0.475;
  static const double naturalGas = 0.202;
  
  // Food (in kg CO2 per meal)
  static const double meatMeal = 3.0;
  static const double vegetarianMeal = 1.5;
  static const double veganMeal = 0.5;
}