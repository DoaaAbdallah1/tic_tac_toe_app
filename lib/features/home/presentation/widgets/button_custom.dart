import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;
  const ButtonCustom({super.key, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.all(30)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        ),
      ),
      child: Image.asset(imagePath, width: 100, height: 100),
    );
  }
}
