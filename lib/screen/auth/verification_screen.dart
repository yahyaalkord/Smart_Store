import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/api/auth_api_controller.dart';
import 'package:smart_store/models/api_response.dart';
import 'package:smart_store/prefs/shared_pref_controller.dart';
import 'package:smart_store/utils/helpers.dart';
import 'package:smart_store/widget/app_elevated_botton.dart';
import 'package:smart_store/widget/app_text_field.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key,required this.mobile}) : super(key: key);

  final String mobile;
  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> with Helpers {
  late TextEditingController _verify1TextController;
  late TextEditingController _verify2TextController;
  late TextEditingController _verify3TextController;
  late TextEditingController _verify4TextController;
  late TextEditingController _testTextController;
  late TextEditingController _test1TextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _verify1TextController = TextEditingController();
    _verify2TextController = TextEditingController();
    _verify3TextController = TextEditingController();
    _verify4TextController = TextEditingController();
    _testTextController = TextEditingController();
    _test1TextController = TextEditingController();
  }

  @override
  void dispose() {
    _verify1TextController.dispose();
    _verify2TextController.dispose();
    _verify3TextController.dispose();
    _verify4TextController.dispose();
    _testTextController.dispose();
    _test1TextController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // title: Text('Verification'),
        title: Text(widget.mobile),

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VerificationTextFeild(
                    verify1TextController: _verify1TextController,
                    first: true,
                  ),
                  VerificationTextFeild(
                      verify1TextController: _verify2TextController),
                  VerificationTextFeild(
                      verify1TextController: _verify3TextController),
                  VerificationTextFeild(
                    verify1TextController: _verify4TextController,
                    last: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            AppElevatedBotton(
                title: 'Verify Now',
                onPressed: () {
                  _performlogin();
                }),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }

  void _performlogin() {
    if (_checkVeriyData()) {
      _login();
    }
  }

  bool _checkVeriyData() {
    if (_verify1TextController.text.isNotEmpty &&
        _verify2TextController.text.isNotEmpty &&
        _verify3TextController.text.isNotEmpty &&
        _verify4TextController.text.isNotEmpty) {
      showSnackBar(context, message: 'Register Successfully');


      return true;
    }
    showSnackBar(context, message: 'Enter your veriy code', erorr: true);

    return false;
  }

  _login() async {

    print( SharedPrefController().getValueFor(PrefKeys.mobile.name));
    String code=_verify1TextController.text+_verify2TextController.text+_verify3TextController.text+_verify4TextController.text;
    ApiResponse apiResponse =
        await AuthApiController().activate(code:code,mobile:widget.mobile);
    if(apiResponse.success){
      Navigator.pushReplacementNamed(context, '/login_screen');
    }
    showSnackBar(context, message: apiResponse.message, erorr: !apiResponse.success);
  }
}

class VerificationTextFeild extends StatelessWidget {
  VerificationTextFeild({
    this.first = false,
    this.last = false,
    Key? key,
    required TextEditingController verify1TextController,
  })  : _verify1TextController = verify1TextController,
        super(key: key);

  final TextEditingController _verify1TextController;
  bool first;
  bool last;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w,
      child: TextField(
        onChanged: (value) {
          if (value.isNotEmpty && !last) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && !first) {
            FocusScope.of(context).previousFocus();
          }
        },
        textAlign: TextAlign.center,
        controller: _verify1TextController,
        maxLength: 1,
        keyboardType: const TextInputType.numberWithOptions(
            decimal: false, signed: false),
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: const Color(0XFFF9F3EE),
          helperMaxLines: 1,
          hintStyle: GoogleFonts.nunitoSans(fontSize: 16.sp),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(
                color: Colors.transparent,
              )),
        ),
      ),
    );
  }
}
