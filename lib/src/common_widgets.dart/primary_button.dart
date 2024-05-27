import 'package:flutter/material.dart';
import 'package:rossoneri_store/src/constants/app_colors.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.text,
      this.isLoading = false,
      this.onPressed,
      this.backgroundColor = ColorApp.rosso,
      this.foregroundColor = Colors.white});
  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(Sizes.p12),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        foregroundColor: MaterialStateProperty.all<Color>(foregroundColor),
      ),
      onPressed: onPressed,
      child: Text(
        //isLoginForm ? 'Sign In' : 'Sign Up',
        text,
        style:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: Sizes.p20),
      ),
    );
  }
}
