import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final double fontSize;
  final Color textColor;
  final Color hintTextColor;
  final Color borderColor;
  final Function(String) onChanged;
  final TextEditingController? controller;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double width; // Custom width
  final double height; // Custom height

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    this.fontSize = 16,
    this.textColor = Colors.black87,
    this.hintTextColor = Colors.grey,
    this.borderColor = Colors.grey,
    required this.onChanged,
    this.controller,
    this.borderRadius = 30,
    this.margin = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.width = double.infinity, // Default width to infinity
    this.height = 50.0, // Default height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width, // Custom width
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: GoogleFonts.inter(
          fontSize: fontSize,
          color: textColor,
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          labelStyle: GoogleFonts.inter(
            color: hintTextColor,
          ),
          hintStyle: GoogleFonts.inter(
            color: hintTextColor,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
        ),
      ),
    );
  }
}
