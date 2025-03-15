import 'package:flutter/material.dart';
import 'package:releaf/screens/emission_entry_screen.dart';
import 'package:releaf/services/carbon_calculation_service.dart';

class CarbonStatsWidget extends StatefulWidget {
  @override
  _CarbonStatsWidgetState createState() => _CarbonStatsWidgetState();
}

class _CarbonStatsWidgetState extends State<CarbonStatsWidget> {
  final CarbonCalculationService _calculator = CarbonCalculationService();
  Map<String, dynamic> _carbonData = {
    'co2_percentage': 0.0,
    'time_emitted': "0h 0m",
    'trend_comparison': "No data",
    'total_today': 0.0,
  };

  @override
  void initState() {
    super.initState();
    _loadCarbonData();
  }

  Future<void> _loadCarbonData() async {
    try {
      final data = await _calculator.getCarbonData();
      if (mounted) {
        setState(() {
          _carbonData = data;
        });
      }
    } catch (e) {
      debugPrint("Error loading carbon data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Your CO₂ Footprint',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          // Circular progress indicator
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 160,
                height: 160,
                child: CircularProgressIndicator(
                  value: (_carbonData['co2_percentage'] / 100).clamp(0.0, 1.0),
                  strokeWidth: 12,
                  backgroundColor: Colors.grey.shade700,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _carbonData['co2_percentage'] < 50
                        ? Colors.green
                        : _carbonData['co2_percentage'] < 75
                            ? Colors.yellow
                            : Colors.orange,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${_carbonData['co2_percentage'].toStringAsFixed(1)}%',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${_carbonData['total_today'].toStringAsFixed(1)} kg CO₂',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            _carbonData['time_emitted'],
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          const Text(
            'Time emitted today',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),

          const SizedBox(height: 16),

          _buildTrendComparison(),

          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EmissionEntryScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Log New Activity'),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendComparison() {
    String trendText = _carbonData['trend_comparison'] ?? "No data";
    bool isImproving = trendText.contains('Better');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isImproving ? Icons.arrow_downward : Icons.arrow_upward,
          color: isImproving ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Text(
          trendText,
          style: TextStyle(
            color: isImproving ? Colors.green : Colors.red,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
