import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DText extends StatelessWidget {
  DText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dotGothic16(),
    );
  }
}
