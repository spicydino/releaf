import 'package:flutter/material.dart';
import '../models/emission_models.dart';
import '../services/carbon_calculation_service.dart';

class EmissionEntryScreen extends StatefulWidget {
  @override
  _EmissionEntryScreenState createState() => _EmissionEntryScreenState();
}

class _EmissionEntryScreenState extends State<EmissionEntryScreen> {
  final CarbonCalculationService _calculator = CarbonCalculationService();
  final _formKey = GlobalKey<FormState>();

  EmissionCategory _selectedCategory = EmissionCategory.transportation;
  String _transportType = 'car';
  double _distance = 0;
  double _kwhUsed = 0;
  String _mealType = 'meat';
  int _mealCount = 1;

  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _kwhController = TextEditingController();
  final TextEditingController _mealCountController = TextEditingController(text: '1');

  @override
  void dispose() {
    _distanceController.dispose();
    _kwhController.dispose();
    _mealCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Carbon Activity'),
        backgroundColor: Colors.green.shade800,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<EmissionCategory>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(labelText: 'Activity Category'),
                  items: EmissionCategory.values.map((category) {
                    return DropdownMenuItem<EmissionCategory>(
                      value: category,
                      child: Text(category.toString().split('.').last),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),

                if (_selectedCategory == EmissionCategory.transportation) _buildTransportFields(),
                if (_selectedCategory == EmissionCategory.energy) _buildEnergyFields(),
                if (_selectedCategory == EmissionCategory.food) _buildFoodFields(),

                const SizedBox(height: 30),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submitEmission();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: const Text('Log Activity'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransportFields() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: _transportType,
          decoration: const InputDecoration(labelText: 'Transport Type'),
          items: ['car', 'bus', 'train', 'plane'].map((type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(type),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _transportType = value!;
            });
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _distanceController,
          decoration: const InputDecoration(labelText: 'Distance (km)'),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter distance';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildEnergyFields() {
    return TextFormField(
      controller: _kwhController,
      decoration: const InputDecoration(labelText: 'Electricity Used (kWh)'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter kWh used';
        }
        return null;
      },
    );
  }

  Widget _buildFoodFields() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: _mealType,
          decoration: const InputDecoration(labelText: 'Meal Type'),
          items: ['meat', 'vegetarian', 'vegan'].map((type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(type),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _mealType = value!;
            });
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _mealCountController,
          decoration: const InputDecoration(labelText: 'Number of Meals'),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter number of meals';
            }
            return null;
          },
        ),
      ],
    );
  }

  void _submitEmission() async {
    double emissions = 0;

    switch (_selectedCategory) {
      case EmissionCategory.transportation:
        _distance = double.tryParse(_distanceController.text) ?? 0;
        emissions = _calculator.calculateTransportEmissions(_transportType, _distance);
        break;
      case EmissionCategory.energy:
        _kwhUsed = double.tryParse(_kwhController.text) ?? 0;
        emissions = _calculator.calculateEnergyEmissions(_kwhUsed);
        break;
      case EmissionCategory.food:
        _mealCount = int.tryParse(_mealCountController.text) ?? 1;
        emissions = _calculator.calculateFoodEmissions(_mealType, _mealCount);
        break;
      default:
        emissions = 0;
    }

    await _calculator.logEmission(_selectedCategory, emissions);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logged ${emissions.toStringAsFixed(2)} kg CO₂')),
    );

    Navigator.pop(context);
  }
}
