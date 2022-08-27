import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/utils/helpers.dart';
import 'package:smart_store/widget/app_elevated_botton.dart';
import 'package:smart_store/widget/app_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> with Helpers{
  late TextEditingController _resetTextController;
  late TextEditingController _reset1TextController;
  bool _obscur = true;
  bool _obscur1 = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _resetTextController = TextEditingController();
    _reset1TextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _resetTextController.dispose();
    _reset1TextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Rest Password'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reset Password',
              style: GoogleFonts.nunitoSans(
                  fontSize: 22.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Set the new password for your account and'
              'you can access all the features.',
              style: GoogleFonts.nunitoSans(
                  fontSize: 16.sp, color: Colors.black45),
            ),
            SizedBox(
              height: 30.h,
            ),
            AppTextField(
              opsecure: _obscur,
              hint: 'Enter new password',
              prefixIcon: Icons.lock,
              keyboardType: TextInputType.text,
              controller: _resetTextController,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() => _obscur = !_obscur);
                },
                icon: Icon(
                  _obscur ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            AppTextField(
              opsecure: _obscur1,
              hint: 'Repeat password',
              prefixIcon: Icons.lock,
              keyboardType: TextInputType.text,
              controller: _reset1TextController,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() => _obscur1 = !_obscur1);
                },
                icon: Icon(
                  _obscur1 ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            Spacer(),
            AppElevatedBotton(title: 'Confirm', onPressed: () =>_performOk()),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }

  void _performOk() {
    if (_checkData()) {
      _ok();
    }
  }

  bool _checkData() {
    if (_resetTextController.text.isNotEmpty &&
        _reset1TextController.text.isNotEmpty &&
        _resetTextController.text== _reset1TextController.text ? true : false) {
    return true;
    }
    showSnackBar(context, message: 'Check your required  Data',erorr: true);
    return false;
  }

  void _ok() {
    Future.delayed(Duration(seconds: 1),(){

    showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('images/Fill.png'),
                  Center(child: Icon(Icons.done,color: Color(0XFF31D1DA),size: 50.sp,))
                ],
              ),
              AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)
                ),
                title: Text(
                  'Change Password Success!',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
                content: Text(
                  'you can login to your account',
                  style: GoogleFonts.nunitoSans(fontSize: 14),
                ),
              ),
            ],
          );
        });
    });
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, '/login_screen');
    });
  }
}
