import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({super.key, required this.onPressed});
final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.purple[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: onPressed,
      child:  Text(
        'Start Quiz'.tr(),
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
      ),
    );
  }
}
