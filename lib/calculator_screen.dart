import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController aController = TextEditingController();
  final TextEditingController bController = TextEditingController();

  String result = '';

  void calculate(String op) {
    final a = double.tryParse(aController.text.trim());
    final b = double.tryParse(bController.text.trim());

    if (a == null || b == null) {
      setState(() => result = 'Enter two valid numbers.');
      return;
    }

    double value;
    switch (op) {
      case '+':
        value = a + b;
        break;
      case '-':
        value = a - b;
        break;
      case '*':
        value = a * b;
        break;
      default:
        if (b == 0) {
          setState(() => result = 'Cannot divide by zero.');
          return;
        }
        value = a / b;
    }

    setState(() => result = 'Result: $value');
  }

  @override
  void dispose() {
    aController.dispose();
    bController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: aController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'First number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Second number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (final op in ['+', '-', '*', '/'])
                  ElevatedButton(
                    onPressed: () => calculate(op),
                    child: Text(op),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              result,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
