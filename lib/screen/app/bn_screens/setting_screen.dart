import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/widget/settings_section.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _cuonter = 0;
  String _box = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        children: [
          CircleAvatar(
            child: CircleAvatar(
              radius: 50.r,
              backgroundImage: AssetImage('images/profile2.png'),
            ),
            radius: 50.r,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Text(
              'Yahya AlKord',
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.bold, fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: [
              Icon(Icons.language, size: 30, color: Color(0XFFFF7750)),
              SizedBox(
                width: 10.w,
              ),
              Text(
                'Language',
                style: GoogleFonts.nunitoSans(
                    fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              PopupMenuButton<String>(onSelected: (String value) {
                if (_box != value) {
                  setState(() {
                    _box = value;
                    _cuonter = 0;
                  });
                }
              }, itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'en',
                    height: 20,
                    child: Text(
                      'English',
                      style: GoogleFonts.nunitoSans(),
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'ar',
                    height: 20,
                    child: Text(
                      'العربية',
                      style: GoogleFonts.nunitoSans(),
                    ),
                  ),
                ];
              }),
            ],
          ),
          SettingsSections(
              title: 'Addresses',
              icon: Icons.arrow_forward_ios,
              icon1: Icons.location_pin,
              onPressed: () {
                Navigator.pushNamed(context, '/address_screen');
              }),
          // SizedBox(height: 10.h,),
          SettingsSections(
              title: 'Payment Cards',
              icon: Icons.arrow_forward_ios,
              icon1: Icons.payments,
              onPressed: () {
                Navigator.pushNamed(context, '/payment_cards_screen');
              }),
          SettingsSections(
              title: 'Profile',
              icon: Icons.arrow_forward_ios,
              icon1: Icons.person,
              onPressed: () {
                Navigator.pushNamed(context, '/profile_screen');
              }),
          SettingsSections(
              title: 'Change password',
              icon: Icons.arrow_forward_ios,
              icon1: Icons.password,
              onPressed: () {
                Navigator.pushNamed(context, '/change_password_screen');
              }),
          SettingsSections(
              title: 'LogUot',
              icon: Icons.arrow_forward_ios,
              icon1: Icons.logout,
              onPressed: () {
                _confirmLogoutDialog();
              }),
        ],
      ),
    );
  }

  void _confirmLogoutDialog() async {
    showDialog<bool>(
      context: context,
      // barrierColor: Colors.red.shade100.withOpacity(0.5),
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'log out',
            style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
          ),
          titleTextStyle: GoogleFonts.cairo(
            fontSize: 16,
            color: Colors.black,
          ),
          content: Text(
            'Are you sure to log out',
            style: GoogleFonts.nunitoSans(),
          ),
          contentTextStyle: GoogleFonts.cairo(
            fontSize: 13,
            color: Colors.black45,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login_screen');
              },
              child: Text(
                'Yes',
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
