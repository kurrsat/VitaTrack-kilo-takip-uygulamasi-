import 'package:flutter/material.dart';

/// Welcome step - introduction to the app
class WelcomeStep extends StatelessWidget {
  const WelcomeStep({super.key, required this.onNext});

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.water_drop,
            size: 100,
            color: Colors.blue,
          ),
          const SizedBox(height: 32),
          const Text(
            'Su Hatirlatici\'ya Hos Geldin',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Yasam tarzina uygun akilli hatirlatmalarla '
            'saglikli kal ve su ic',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Basla'),
            ),
          ),
        ],
      ),
    );
  }
}
