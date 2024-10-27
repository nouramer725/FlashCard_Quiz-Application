import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Center(
          child: Row(
            children: [
              Text(
                'FlashCard'.tr(), // Key for 'QUIZ'
                style: TextStyle(
                  color: Colors.red[300],
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'quiz'.tr(), // Key for 'QUIZ'
                style: TextStyle(
                  color: Colors.red[300],
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
