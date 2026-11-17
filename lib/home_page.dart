import 'package:flutter/material.dart';

import 'demo_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Text(
          'Welcome, ${DemoAuth.currentUsername ?? ''}!',
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
