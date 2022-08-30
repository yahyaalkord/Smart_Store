import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/utils/helpers.dart';
import 'package:smart_store/widget/app_elevated_botton.dart';
import 'package:smart_store/widget/app_text_field.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> with Helpers{
  late TextEditingController _textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController();
  }
  @override
  void dispose() {
    _textEditingController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('images/avatar.png'),
            ),
            Text(
              'Nova administrator ',
              style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h,),
            const Divider(
              thickness: 0.6,
              color: Color(0xffD6EFED),
              endIndent: 40,
              indent: 40,
              height: 50,
            ),
            AppTextField(hint: 'Enter your message', prefixIcon: Icons.contact_support_outlined, keyboardType: TextInputType.text, controller: _textEditingController),
            SizedBox(height: 50.h,),
            AppElevatedBotton(title: 'Send', onPressed: () {
              _prformSend();
            }),

            const Spacer(),
            Text(
              'yahyaAlkord - eLancer2',
              style: GoogleFonts.cairo(fontSize: 16),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
  void _prformSend() {
    if(_checkData()) {
      _send();
    }
  }
  bool _checkData() {
    if(_textEditingController.text.isNotEmpty){
      return true;
    }
    showSnackBar(context, message: 'No Message');
    return false;
  }
  
  void _send() {
    Future.delayed(Duration(milliseconds: 500),(){
      showSnackBar(context, message: 'Your message has been delivered, thank you',erorr: false);
      Navigator.pop(context);
    });
  }
}
