import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
   AppTextField({
    required this.hint,
    required this.prefixIcon,
    required this.keyboardType,
    required this.controller,
    this.suffixIcon,
    this.focudedBorderColor = Colors.grey,
    this.opsecure = false,
    this.format,
    Key? key,
  }) : super(key: key);
  final String hint;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Color focudedBorderColor;
  final bool opsecure;
  final Widget? suffixIcon;
  List<TextInputFormatter>? format = [];

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: opsecure,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: format,
      style: GoogleFonts.nunitoSans(),
      // maxLines: 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0XFFF9F3EE),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
        hintText: hint,
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

  OutlineInputBorder buildOutlineInputBorder({Color color = Colors.grey}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: color));
  }
}
