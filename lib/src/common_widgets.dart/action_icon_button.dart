import 'package:flutter/material.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';

class ActionIconButton extends StatelessWidget {
 

  final IconData icon;
  final VoidCallback onPressed;

  const ActionIconButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p12),
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }
}