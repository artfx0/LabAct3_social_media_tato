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
    final aText = aController.text.trim();
    final bText = bController.text.trim();

    if (aText.isEmpty || bText.isEmpty) {
      setState(() => result = 'Enter both numbers.');
      return;
    }

    final a = double.tryParse(aText);
    final b = double.tryParse(bText);

    if (a == null || b == null) {
      setState(() => result = 'Enter valid numbers.');
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

    setState(() => result = value.toString());
  }

  void clear() {
    aController.clear();
    bController.clear();
    setState(() => result = '');
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
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'First number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
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
            const SizedBox(height: 16),
            OutlinedButton(onPressed: clear, child: const Text('Clear')),
            const SizedBox(height: 24),
            Text(
              result,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
