import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppElevatedBotton extends StatelessWidget {
  const AppElevatedBotton({
    required this.title,
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  final void Function() onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize:  Size(double.infinity, 63.h),
        primary: Color(0XFFFF7750),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        )
      ),
      onPressed: onPressed,
      child:  Text(
        title,style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold,fontSize: 16),
      ),
    );
  }
}