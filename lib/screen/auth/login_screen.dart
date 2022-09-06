import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/api/auth_api_controller.dart';
import 'package:smart_store/models/api_response.dart';
import 'package:smart_store/utils/helpers.dart';
import 'package:smart_store/widget/app_elevated_botton.dart';
import 'package:smart_store/widget/app_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  late TextEditingController _mobileTextController;
  late TextEditingController _passwordTextController;
  bool _obscur = true;
  int _cuonter = 0;
  String _box = 'English';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mobileTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _mobileTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('LOGIN'),
        actions: [
          PopupMenuButton<String>(
              icon: const Icon(Icons.language),
              onSelected: (String value) {
                if (_box != value) {
                  setState(() {
                    _box = value;
                    _cuonter = 0;
                  });
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text(
                      'English',
                      style: GoogleFonts.nunitoSans(),
                    ),
                    value: 'en',
                    height: 20,
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    child: Text(
                      'العربية',
                      style: GoogleFonts.nunitoSans(),
                    ),
                    value: 'ar',
                    height: 20,
                  ),
                ];
              }),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello There',
              style: GoogleFonts.nunitoSans(
                  fontSize: 16.sp, color: Colors.black45),
            ),
            Text(
              'Welcome Back',
              style: GoogleFonts.nunitoSans(
                  fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30.h,
            ),
            AppTextField(
                hint: 'mobile ',
                prefixIcon: Icons.phone,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: false),
                controller: _mobileTextController),
            SizedBox(
              height: 20.h,
            ),
            AppTextField(
              hint: 'Password',
              prefixIcon: Icons.lock,
              keyboardType: TextInputType.text,
              controller: _passwordTextController,
              opsecure: _obscur,
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
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forget_password_screen');
                  },
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0XFFFF7750)),
                  )),
            ),
            const Spacer(),
            AppElevatedBotton(title: 'Login', onPressed: () => _performLogin()),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don’t have an account? Please',
                  style: GoogleFonts.nunitoSans(fontSize: 14),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup_screen');
                  },
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0XFFFF7750),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _performLogin() {
    if (_checkData()) {
      _login();
    }
  }

  bool _checkData() {
    if (_mobileTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'Enter required data', erorr: true);
    return false;
  }

  void _login() async {
    //TODO: Call login api request
    ApiResponse apiResponse = await AuthApiController().login(
        mobile: _mobileTextController.text,
        password: _passwordTextController.text);
    if (apiResponse.success) {
      Navigator.pushReplacementNamed(context, '/bottom_nav_screen');
    }
    showSnackBar(context,
        message: apiResponse.message, erorr: !apiResponse.success);
  }
}
