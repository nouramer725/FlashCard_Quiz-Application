import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key, required this.result, required this.total});

  final int result;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'result Label'.tr(), // Using .tr() for localization
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 20),
            Text(
              '$result / $total',
              style: const TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            MaterialButton(
              color: Colors.purple[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                for (int i = 0; i < 3; i++) {
                  Navigator.pop(context);
                }
              },
              child: Text(
                'back To Home'.tr(), // Using .tr() for localization
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
