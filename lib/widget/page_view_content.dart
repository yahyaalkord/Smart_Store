import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PageViewContent extends StatelessWidget {
  const PageViewContent({
    required this.text,
    required this.image,
    required this.subText,
    Key? key,
  }) : super(key: key);
  final String image;
  final String text;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 400.h,
            child: Image.asset('images/$image.png')),
        SizedBox(height: 10.h,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            children: [
              Text(
                text,
                style: GoogleFonts.nunitoSans(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 20.h,),
              Text(
                subText,
                style: GoogleFonts.nunitoSans(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}