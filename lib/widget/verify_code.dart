import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({
    Key? key,

    required TextEditingController verify1TextController,
  }) : _verify1TextController = verify1TextController, super(key: key);

  final TextEditingController _verify1TextController;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w,
      child: TextField(
        onChanged: (value) {
          if(value.isNotEmpty){
            FocusScope.of(context).nextFocus();
          }else if(value.isEmpty){
            FocusScope.of(context).previousFocus();
          }
        },
        textAlign: TextAlign.center,
        controller: _verify1TextController,
        maxLength: 1,
        keyboardType: const TextInputType
            .numberWithOptions(
            decimal: false, signed: false),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0XFFF9F3EE),
          helperMaxLines: 1,
          hintStyle: GoogleFonts.nunitoSans(
              fontSize: 16.sp),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  20.r),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )
          ),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  20.r),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  20.r),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  20.r),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  20.r),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  20.r),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )
          ),
        ),

      ),

    );
  }
}