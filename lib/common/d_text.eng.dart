import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DText$eng extends StatelessWidget {
  const DText$eng({
    super.key,
    required this.text,
    this.bold = false,
    this.fontSize = 12,
  });

  final String text;
  final bool bold;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dotGothic16(
        fontWeight: bold ? FontWeight.w600 : FontWeight.w500,
        fontSize: fontSize,
      ),
    );
  }
}
