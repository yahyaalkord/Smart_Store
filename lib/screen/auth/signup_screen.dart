import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/api/auth_api_controller.dart';
import 'package:smart_store/get/cities_getx_controller.dart';
import 'package:smart_store/models/api_response.dart';
import 'package:smart_store/models/cities.dart';
import 'package:smart_store/screen/auth/verification_screen.dart';
import 'package:smart_store/utils/helpers.dart';
import 'package:smart_store/widget/app_elevated_botton.dart';
import 'package:smart_store/widget/app_text_field.dart';

import '../../model/country.dart';
import '../../models/user.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with Helpers{
  CitiesGetxController citiesGetxController = Get.put<CitiesGetxController>(CitiesGetxController());

  // CitiesGetxController _citiesGetxController = CitiesGetxController.to;
  late TextEditingController _nameTextController;
  late TextEditingController _mobileTextController;
  late TextEditingController _passwordTextController;
  bool _obscur = true;
  int? _selectedCountryId;
  String _gender = 'M';

  /*final List<Country> _country = <Country>[
    const Country(id: 1, title: 'North'),
    const Country(id: 2, title: 'Gaza'),
    const Country(id: 3, title: 'Central Region'),
    const Country(id: 4, title: 'Khan Younes'),
    const Country(id: 5, title: 'Rafah'),
  ];*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put<CitiesGetxController>(CitiesGetxController());
    _nameTextController = TextEditingController();
    _mobileTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameTextController.dispose();
    _mobileTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Sing Up'),
      ),
      body: GetBuilder<CitiesGetxController>(
        builder: (controller){
          List<Cities> city= controller.citiesItems;
          return Padding(
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
                    hint: 'Name',
                    prefixIcon: Icons.person,
                    keyboardType: TextInputType.text,
                    controller: _nameTextController),
                SizedBox(
                  height: 20.h,
                ),
                AppTextField(
                    hint: 'mobile ',
                    prefixIcon: Icons.phone_android_outlined,
                    keyboardType: TextInputType.numberWithOptions(signed: false,decimal: false),
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
                DropdownButton(
                  hint: const Text('Select your Country'),
                  style: GoogleFonts.montserrat(color: Colors.black),
                  onTap: () {
                  },
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // itemHeight: 65,
                  dropdownColor: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                  elevation: 5,
                  underline: const Divider(
                    color: Colors.black,
                    thickness: 1,
                    height: 0,
                  ),
                  isExpanded: true,
                  value: _selectedCountryId,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedCountryId = value;
                    });
                  },
                  items: city.map((country) {
                    return DropdownMenuItem(
                      value: country.id,
                      child: Text(country.nameEn),
                    );
                  },
                  ).toList(),
                ),
                SizedBox(height: 20.h,),
                Text('Gender',style: GoogleFonts.nunitoSans(fontSize: 16,fontWeight: FontWeight.bold),),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                          title: const Text('Male'),
                          value: 'M',
                          groupValue: _gender,
                          onChanged: (String? value) {
                            setState(() => _gender = value!);
                          }),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                          title: const Text('Female'),
                          value: 'F',
                          groupValue: _gender,
                          onChanged: (String? value) {
                            setState(() => _gender = value!);
                          }),
                    ),
                  ],
                ),
                const Spacer(),
                AppElevatedBotton(title: 'Continue', onPressed: () => _performRegister()),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You have an account? Please',
                      style: GoogleFonts.nunitoSans(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login_screen');
                      },
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFFFF7750),
                        ),
                      ),
                    ),
                  ],
                )

              ],
            ),
          );
        },
      )
    );
  }

  void _performRegister() {
    if (_checkData()) {
      _register();
    }
  }

  bool _checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty &&
        _mobileTextController.text.isNotEmpty ){

      return true;
    }
    showSnackBar(context, message: 'Check your required  Data',erorr: true);
    return false;
  }
  void _register() async{

    ApiResponse apiResponse = await AuthApiController().register(user);
    if(apiResponse.success){
      Navigator.push(context,MaterialPageRoute(builder: (context) => VerificationScreen(mobile: user.mobile),));
    }
    showSnackBar(context, message: apiResponse.message, erorr: !apiResponse.success);
  }
  User get user {
    User user = User();
    user.name = _nameTextController.text;
    user.mobile = _mobileTextController.text;
    user.gender = _gender;
    user.cityId = _selectedCountryId.toString();
    user.password = _passwordTextController.text;
    return user;
  }
}
