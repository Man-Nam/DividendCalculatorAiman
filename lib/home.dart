// lib/home.dart
import 'package:flutter/material.dart';
import 'package:individualassignmentmobile/about.dart'; // Make sure this path is correct

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controllers for the first two general number input fields
  final TextEditingController _investedFundController = TextEditingController();
  final TextEditingController _annualDividendRateController = TextEditingController();

  // Variable to store the selected month from the dropdown
  int? _selectedMonth;
  // Variables to store and display calculation results
  String _errorMessage = '';

  @override
  void dispose() {
    // Dispose controllers to free up memory when the widget is removed
    _investedFundController.dispose();
    _annualDividendRateController.dispose();
    super.dispose();
  }

  void _calculateDividends() {
    setState(() {
      _errorMessage = ''; // Clear previous error message
    });

    try {
      double investedFund = double.parse(_investedFundController.text);
      double annualRate = double.parse(_annualDividendRateController.text);

      if (_selectedMonth == null) {
        setState(() {
          _errorMessage = 'Please select the number of months.';
        });
        return;
      }

      int numberOfMonths = _selectedMonth!;

      // Convert annual rate from percentage to decimal (e.g., 5.5% -> 0.055)
      // Monthly Dividend = (Rate / 12) × Invested Fund
      // Total Dividend = Monthly Dividend × Number of Months
      double rateDecimal = annualRate / 100.0;
      double monthlyDividendValue = (rateDecimal / 12.0) * investedFund;
      double totalDividendValue = monthlyDividendValue * numberOfMonths;

      _showResultsDialog(monthlyDividendValue, totalDividendValue);

    } on FormatException {
      setState(() {
        _errorMessage = 'Invalid input: Please enter valid numbers for fund and rate.';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred: ${e.toString()}';
      });
    }
  }

  void _showResultsDialog(double monthly, double total) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Calculation Results'),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Make column take minimum space
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Monthly Dividend: RM ${monthly.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
              ),
              const SizedBox(height: 10),
              Text(
                'Total Dividend: RM ${total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, color: Colors.green),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            // Input Field 1: Invested Fund Amount
            TextField(
              controller: _investedFundController,
              keyboardType: TextInputType.number, // Suggest numeric keyboard
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Invested Fund Amount',
                hintText: 'e.g., 10000',
              ),
            ),
            const SizedBox(height: 15), // Spacing between input fields

            // Input Field 2: Annual Dividend Rate (%)
            TextField(
              controller: _annualDividendRateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Annual Dividend Rate (%)',
                hintText: 'e.g., 5.5',
              ),
            ),
            const SizedBox(height: 15), // Spacing between input fields

            // Dropdown for the 3rd input (1 to 12)
            DropdownButtonFormField<int>(
              value: _selectedMonth, // Current selected value
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Number of Months Invested (1-12)',
              ),
              // Generate list of DropdownMenuItem from 1 to 12
              items: List.generate(12, (index) {
                final monthNumber = index + 1; // Numbers 1 to 12
                return DropdownMenuItem<int>(
                  value: monthNumber,
                  child: Text('$monthNumber'),
                );
              }),
              onChanged: (int? newValue) {
                // Update the state with the new selected value
                setState(() {
                  _selectedMonth = newValue;
                });
              },
            ),

            const SizedBox(height: 30),

            // Calculate Button
            ElevatedButton(
              onPressed: _calculateDividends, // Call the calculation function
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Calculate Dividend'),
            ),
            const SizedBox(height: 20),

            // Display Error Message
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),

          ],
        ),
      ),
      // Drawer for sidebar navigation (unchanged)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Dividend Calculator',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            //ListTile for Home
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Close the drawer
                Navigator.pop(context);
              },
            ),
            //ListTile for About
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                // Close the drawer before navigating
                Navigator.pop(context);
                // Navigate to the AboutScreen, replacing the current route
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}