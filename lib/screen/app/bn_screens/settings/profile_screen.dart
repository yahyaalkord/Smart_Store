import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/utils/helpers.dart';
import 'package:smart_store/widget/app_elevated_botton.dart';
import 'package:smart_store/widget/app_text_field.dart';
import 'package:smart_store/widget/profile_text_field.dart';
import 'package:smart_store/widget/verify_code.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with Helpers {
  late TextEditingController _textEditingController;
  late TextEditingController _textEditingController1;
  late TextEditingController _textEditingController2;
  late TextEditingController _mobileEditingController;
  late TextEditingController _verify1TextController;
  late TextEditingController _verify2TextController;
  late TextEditingController _verify3TextController;
  late TextEditingController _verify4TextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController(text: 'Yahya Alkord');
    _textEditingController1 = TextEditingController(text: 'Flutter@email.com');
    _textEditingController2 = TextEditingController(text: '+970595430134');
    _mobileEditingController = TextEditingController();
    _verify1TextController = TextEditingController();
    _verify2TextController = TextEditingController();
    _verify3TextController = TextEditingController();
    _verify4TextController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _textEditingController1.dispose();
    _textEditingController2.dispose();
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
              height: 30.h,
            ),
            ProfileTextField(controller: _textEditingController),
            SizedBox(
              height: 20.h,
            ),
            ProfileTextField(controller: _textEditingController1),
            SizedBox(
              height: 30.h,
            ),
            ProfileTextField(
              controller: _textEditingController2,
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
            Spacer(),
            AppElevatedBotton(
                title: 'Save Changes',
                onPressed: () {
                  showSnackBar(context,
                      message: 'Changes Successfully', erorr: false);
                  Navigator.pop(context);
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
                              controller: _mobileEditingController),
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

  _reset() {
    Navigator.pop(context);
    showSnackBar(context, message: 'Change Mobile Number Successfully',erorr: false);

  }

}
