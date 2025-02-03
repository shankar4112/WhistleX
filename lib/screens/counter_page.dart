import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _whistleCount = 0;
  int _targetValue = 10; // Default target value
  String _resultText = ''; // Text to display when target is reached

  // Function to increment the whistle count
  void _incrementCounter() {
    setState(() {
      _whistleCount++;
    });

    // Check if the target value is reached
    if (_whistleCount >= _targetValue) {
      setState(() {
        _resultText = 'Steam'; // Display "Steam" when target is reached
      });
    }
  }

  // Function to update target value based on user input
  void _updateTargetValue(String value) {
    setState(() {
      _targetValue = int.tryParse(value) ?? 0; // Update target value
      _resultText = ''; // Reset result text if target value is changed
      _whistleCount = 0; // Reset whistle count when target value is changed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whistle Counter'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Target input field
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Set Target Value',
                  border: OutlineInputBorder(),
                ),
                onChanged: _updateTargetValue,
              ),
              SizedBox(height: 20),

              // Display whistle count
              Text(
                'Whistles Detected: $_whistleCount',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),

              // Display target value
              Text(
                'Target: $_targetValue',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),

              // Display result text if target is reached
              Text(
                _resultText,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              SizedBox(height: 20),

              // Button to increment the whistle count
              ElevatedButton(
                onPressed: _incrementCounter,
                child: Text('Increment Whistle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
