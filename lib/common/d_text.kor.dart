import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DText$Kor extends StatelessWidget {
  const DText$Kor({
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
      style: GoogleFonts.notoSansNKo(
        fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
        fontSize: fontSize,
      ),
    );
  }
}
