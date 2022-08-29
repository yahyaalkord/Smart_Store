import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({
    required this.title,
    required this.info,
    Key? key,
  }) : super(key: key);
  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 20.h),
      child: Row(
        children: [
          Text(title,style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
          Spacer(),
          Text(info),

        ],
      ),
    );
  }
}