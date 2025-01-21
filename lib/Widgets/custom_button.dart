import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ButtonType { elevated, outlined, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // Nullable
  final Color backgroundColor;
  final Color textColor;
  final double textSize;
  final ButtonType buttonType;
  final double borderWidth;
  final Color borderColor;
  final double buttonWidth;
  final double buttonHeight;
  final double borderRadius;
  final Widget? prefixIcon; // Added for optional icons

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed, // Make this nullable
    required this.backgroundColor,
    required this.textColor,
    required this.textSize,
    required this.buttonType,
    required this.borderWidth,
    required this.borderColor,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.borderRadius,
    this.prefixIcon, // Initialize as optional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = buttonType == ButtonType.elevated
        ? ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      textStyle: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),
    )
        : OutlinedButton.styleFrom(
      side: BorderSide(width: borderWidth, color: borderColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      textStyle: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),
    );

    final Widget buttonChild = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          prefixIcon!,
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(color: textColor, fontSize: textSize, fontWeight: FontWeight.bold),
        ),
      ],
    );

    return SizedBox(
      width: buttonWidth,  // Use SizedBox to apply custom width
      height: buttonHeight,  // Use SizedBox to apply custom height
      child: buttonType == ButtonType.elevated
          ? ElevatedButton(
        style: buttonStyle,
        onPressed: onPressed ?? () {}, // Provide a default function
        child: buttonChild,
      )
          : OutlinedButton(
        style: buttonStyle,
        onPressed: onPressed ?? () {}, // Provide a default function
        child: buttonChild,
      ),
    );
  }
}
