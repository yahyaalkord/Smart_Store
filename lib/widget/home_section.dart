import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({
    required this.titel,
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  final String titel;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          titel,
          style: GoogleFonts.nunitoSans(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onPressed,
          child: Text(
            'SeeAll',
            style: GoogleFonts.nunitoSans(fontWeight: FontWeight.normal,fontSize: 14,color: Color(0XFF3E3E3E)),
          ),
        ),
      ],
    );
  }
}