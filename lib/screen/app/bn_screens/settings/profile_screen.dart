import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/prefs/shared_pref_controller.dart';
import 'package:smart_store/utils/helpers.dart';
import 'package:smart_store/widget/app_elevated_botton.dart';
import 'package:smart_store/widget/app_text_field.dart';
import 'package:smart_store/widget/profile_text_field.dart';
import 'package:smart_store/widget/verify_code.dart';

import '../../../../api/auth_api_controller.dart';
import '../../../../get/cities_getx_controller.dart';
import '../../../../models/api_response.dart';
import '../../../../models/cities.dart';
import '../../../../models/user.dart';
import '../../../auth/verification_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with Helpers {
  late TextEditingController _nameTextEditingController;
  late TextEditingController _emailTextEditingController1;
  late TextEditingController _mobileTextEditingController;
  late TextEditingController _mobileEditingController;
  late TextEditingController _verify1TextController;
  late TextEditingController _verify2TextController;
  late TextEditingController _verify3TextController;
  late TextEditingController _verify4TextController;
  int? _selectedCountryId;
  String _gender = 'M';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put<CitiesGetxController>(CitiesGetxController());
    _nameTextEditingController = TextEditingController(text: SharedPrefController().getValueFor(PrefKeys.name.name));
    _emailTextEditingController1 = TextEditingController(text: 'Flutter@email.com');
    _mobileTextEditingController = TextEditingController(text: SharedPrefController().getValueFor(PrefKeys.mobile.name).toString());
    _mobileEditingController = TextEditingController();
    _verify1TextController = TextEditingController();
    _verify2TextController = TextEditingController();
    _verify3TextController = TextEditingController();
    _verify4TextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _emailTextEditingController1.dispose();
    _mobileTextEditingController.dispose();
    _mobileEditingController.dispose();
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
      backgroundColor: Color(0XFFFAFAFA),
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        child: Column(
          children: [
            Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Edit Profile',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 10.h,
            ),
            CircleAvatar(
              radius: 50.r,
              backgroundImage: AssetImage('images/profile2.png'),
            ),
            SizedBox(
              height: 20.h,
            ),
            ProfileTextField(controller: _nameTextEditingController),
            SizedBox(
              height: 15.h,
            ),
            ProfileTextField(controller: _emailTextEditingController1),
            SizedBox(
              height: 20.h,
            ),
            ProfileTextField(
              controller: _mobileTextEditingController,
              enabeld: false,
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                  onPressed: () {
                    _showCodeVerifyBottomSheet();
                  },
                  child: Text(
                    'Change your Number?',
                    style: GoogleFonts.nunitoSans(
                        color: Color(0XFFFF7750), fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(height: 15.h,),
            GetBuilder<CitiesGetxController>(
                builder: (controller) {
                  List<Cities> city= controller.citiesItems;
                  return DropdownButton(
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
                  );
                },),
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
            Spacer(),
            AppElevatedBotton(
                title: 'Save Changes',
                onPressed: () {
                  _reset();
               /*   showSnackBar(context,
                      message: 'Changes Successfully', erorr: false);
                  Navigator.pop(context);*/
                })
          ],
        ),
      ),
    );
  }

  void _showCodeVerifyBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.r),
                topLeft: Radius.circular(20.r))),
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return BottomSheet (
              onClosing: () {},
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState){
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Text('Change Mobile Number',
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 15.h,
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              'Enter Your New Mobile Number',
                              style: GoogleFonts.nunitoSans(),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          AppTextField(
                              hint: 'Number',
                              prefixIcon: Icons.phone,
                              keyboardType: TextInputType.phone,
                              controller: _mobileTextEditingController),
                          SizedBox(height: 20.h,),
                          AppElevatedBotton(title: 'Verify', onPressed: (){
                            _peformVerify();
                          }),
                          SizedBox(height: 10.h,),
                        ],
                      ),
                    );
                  },
                );
              });
        });
  }
  void _peformVerify() {
    if(checkData()) {
      _verify();
    }
  }
  bool checkData() {
    if(_mobileEditingController.text.isNotEmpty){
      return true;
    }
    Navigator.pop(context);
    showSnackBar(context, message: 'enter your new mobile number!');
    return false;
  }
  void _verify() {
    Navigator.pop(context);
    _showVerifyBottomSheet();
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
                                VerifyCode(verify1TextController: _verify1TextController),
                                const Spacer(),
                                VerifyCode(verify1TextController: _verify2TextController),
                                const Spacer(),
                                VerifyCode(verify1TextController: _verify3TextController),
                                const Spacer(),
                                VerifyCode(verify1TextController: _verify4TextController),

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
    // showSnackBar(context, message:  'Enter your veriy code',erorr: true);

    return false;

  }

  _reset() async{
    // Navigator.pop(context);
    // showSnackBar(context, message: 'Change Mobile Number Successfully',erorr: false);
    ApiResponseT apiResponse = await AuthApiController().updateProfile(user: user);
    if(apiResponse.status){
      // Navigator.push(context,MaterialPageRoute(builder: (context) => VerificationScreen(mobile: user.mobile),));
      Navigator.pop(context);
      showSnackBar(context, message: apiResponse.message);
    }
    showSnackBar(context, message: apiResponse.message, erorr: !apiResponse.status);

  }
  User get user {
    User user = User();
    user.name = _nameTextEditingController.text;
    user.mobile = _mobileTextEditingController.text;
    user.gender = _gender;
    user.cityId = _selectedCountryId.toString();
    return user;
  }

}
