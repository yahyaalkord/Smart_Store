import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/utils/helpers.dart';
import 'package:smart_store/widget/app_elevated_botton.dart';
import 'package:smart_store/widget/profile_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> with Helpers{
  bool _obscur = true;
  late TextEditingController _changePasEditingController;
  late TextEditingController _changePasEditingController1;
  late TextEditingController _changePasEditingController2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _changePasEditingController = TextEditingController();
    _changePasEditingController1 = TextEditingController();
    _changePasEditingController2 = TextEditingController();
  }

  @override
  void dispose() {
    _changePasEditingController.dispose();
    _changePasEditingController1.dispose();
    _changePasEditingController2.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Change Password',
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.bold, fontSize: 22.sp),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            ProfileTextField(
              controller: _changePasEditingController,
              opsecure: _obscur,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() => _obscur = !_obscur);
                },
                icon: Icon(
                  _obscur ? Icons.visibility : Icons.visibility_off,
                ),
              ),
              lable: Text('current password',),
            ),
            SizedBox(height: 20.h,),
            ProfileTextField(
              controller: _changePasEditingController1,
              opsecure: _obscur,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() => _obscur = !_obscur);
                },
                icon: Icon(
                  _obscur ? Icons.visibility : Icons.visibility_off,
                ),
              ),
              lable: Text('New password',),
            ),
            SizedBox(height: 20.h,),
            ProfileTextField(
              controller: _changePasEditingController2,
              opsecure: _obscur,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() => _obscur = !_obscur);
                },
                icon: Icon(
                  _obscur ? Icons.visibility : Icons.visibility_off,
                ),
              ),
              lable: Text('password confirmation',),
            ),
            Spacer(),
            AppElevatedBotton(title: 'Confirm', onPressed: () {
              _performChangePassword();
            })

          ],
        ),
      ),
    );
  }

  void _performChangePassword() {
    if (_checkData()) {
      _changePassword();
    }

  }
  bool _checkData() {
    if (_changePasEditingController.text.isNotEmpty &&
        _changePasEditingController1.text.isNotEmpty &&
        _changePasEditingController2.text.isNotEmpty) {
      if( _changePasEditingController1.text == _changePasEditingController2.text){
        return true;
      }
    }
    showSnackBar(context, message: 'check your required data!');
    return false;
  }

  void _changePassword() {
    Navigator.pop(context);
    showSnackBar(context, message: 'Change Password Successfully',erorr: false);
  }
}
