import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/utils/helpers.dart';
import 'package:smart_store/widget/app_elevated_botton.dart';
import 'package:smart_store/widget/app_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> with Helpers{
  late TextEditingController _forgetTextController;
  late TextEditingController _verify1TextController;
  late TextEditingController _verify2TextController;
  late TextEditingController _verify3TextController;
  late TextEditingController _verify4TextController;
  bool _navigator = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _forgetTextController = TextEditingController();
    _verify1TextController = TextEditingController();
    _verify2TextController = TextEditingController();
    _verify3TextController = TextEditingController();
    _verify4TextController = TextEditingController();
  }

  @override
  void dispose() {
    _forgetTextController.dispose();
    _verify1TextController.dispose();
    _verify2TextController.dispose();
    _verify3TextController.dispose();
    _verify4TextController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Forget Password'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
        child: Column(
          children: [
            Text(
              'Forgot Password',
              style: GoogleFonts.nunitoSans(
                  fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              'Don’t worry, Nova have simple step to create'
                  'your new password',
              style: GoogleFonts.nunitoSans(
                  fontSize: 16.sp, color: Colors.black45),
            ),
            SizedBox(
              height: 30.h,
            ),
            AppTextField(
                hint: 'enter your mobile ',
                prefixIcon: Icons.phone_android,
                keyboardType: TextInputType.numberWithOptions(signed: false,decimal: false),
                controller: _forgetTextController),
            const Spacer(),
            AppElevatedBotton(
                title: 'Confirm', onPressed: () {
              _performForget();

            })
          ],
        ),
      ),
    );
  }

  void _performForget() {
    if (_checkData()) {
      _showForgetBottomSheet();
    }
  }

  bool _checkData() {
    if (_forgetTextController.text.isNotEmpty) {
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Enter your mobile ',
          style: GoogleFonts.nunito(),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
    return false;
  }

  void _showForgetBottomSheet()  {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.r),
                topLeft: Radius.circular(20.r))),
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            'Thank You!',
                            style: GoogleFonts.nunitoSans(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'We will sent 4 digits verification code to '
                                '(${_forgetTextController.text}) please take a'
                                'look and verify it',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 50.h,),
                          AppElevatedBotton(title: 'Verify Now', onPressed: () {
                            _showVerifyBottomSheet();
                          }),
                          SizedBox(height: 30.h,),
                        ],
                      ),
                    );
                  },
                );
              });
        });
  }

  void _showVerifyBottomSheet()  {
     showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.r),
                topLeft: Radius.circular(20.r))),
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            'Enter Your Code',
                            style: GoogleFonts.nunitoSans(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'Enter the 4 digits code that you recived on'
                                'your mobile',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: 250.w,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 50.w,
                                  child: TextField(
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

                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 50.w,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: _verify2TextController,
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

                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 50.w,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: _verify3TextController,
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
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 50.w,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    controller: _verify4TextController,
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

                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: 100.h,),
                          AppElevatedBotton(title: 'Verify Now', onPressed: () {
                             _performReset();

                          } ),
                          SizedBox(height: 30.h,),
                        ],
                      ),
                    );
                  },
                );
              });
        });
  }

  void _performReset() {
    if (_checkVeriyData()) {
      _reset();
    }
  }

  bool _checkVeriyData() {
    if (_verify1TextController.text.isNotEmpty &&
        _verify2TextController.text.isNotEmpty &&
        _verify3TextController.text.isNotEmpty &&
        _verify4TextController.text.isNotEmpty){
      return true;
    }
    showSnackBar(context, message:  'Enter your veriy code',erorr: true);

    return false;

  }

  _reset() {
    Navigator.pushReplacementNamed(context, '/reset_password_screen');

  }

}
