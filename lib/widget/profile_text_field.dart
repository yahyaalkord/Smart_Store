import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    this.lable,
    this.suffixIcon,
    this.opsecure = false,
    required this.controller,
    this.enabeld = true,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final bool enabeld;
  final bool opsecure;
  final Widget? lable;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: opsecure,
      enabled: enabeld,
      controller: controller,
      style: GoogleFonts.nunitoSans(),
      // maxLines: 1,
      decoration: InputDecoration(
        label: lable,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Color(0XFFFFFFFF),
        helperMaxLines: 1,
        hintStyle: GoogleFonts.nunitoSans(fontSize: 16.sp),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: Colors.transparent,
            )
        ),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: Colors.transparent,
            )
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: Colors.transparent,
            )
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: Colors.transparent,
            )
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: Colors.transparent,
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: Colors.transparent,
            )
        ),
      ),
    );
  }
}