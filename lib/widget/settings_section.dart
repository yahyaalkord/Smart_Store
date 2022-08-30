import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsSections extends StatelessWidget {
  const SettingsSections({
    required this.title,
    required this.icon,
    required this.icon1,
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final IconData icon1;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 90.h,
        child: Row(
          children: [
            Icon(icon1,size: 30,color:  Color(0XFFFF7750)),
            SizedBox(
              width: 10.w,
            ),
            Text(
              title,
              style: GoogleFonts.nunitoSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            IconButton(onPressed: onPressed, icon: Icon(icon,color:  Color(0XFFFF7750)),),

          ],
        ),
      ),
    );
  }
}