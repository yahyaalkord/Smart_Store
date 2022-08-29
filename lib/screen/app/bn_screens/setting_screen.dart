import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/address_screen');
          },
          child: Container(
            height: 100,

            child: Row(
              children: [
                Icon(Icons.location_pin,size: 30,color:  Color(0XFFFF7750)),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'Addresses',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(onPressed: (){
                  Navigator.pushNamed(context, '/address_screen');
                }, icon: Icon(Icons.arrow_forward_ios,color:  Color(0XFFFF7750)),),

              ],
            ),
          ),
        ),
          SizedBox(height: 20.h,),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/payment_cards_screen');
            },
            child: Container(
              height: 100,

              child: Row(
                children: [
                  Icon(Icons.payments,size: 30,color:  Color(0XFFFF7750)),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    'Payment Cards',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(onPressed: (){
                    Navigator.pushNamed(context, '/payment_cards_screen');
                  }, icon: Icon(Icons.arrow_forward_ios,color:  Color(0XFFFF7750)),),

                ],
              ),
            ),
          ),
    ],
    );
  }
}
