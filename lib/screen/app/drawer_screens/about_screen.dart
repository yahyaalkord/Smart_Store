import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('images/ls_image.png'),
          ),
          Text(
            'Nova',
            style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h,),
          Text(
            'Online store for everything you need',
            style: GoogleFonts.nunitoSans(height: 1),
          ),
          const Divider(
            thickness: 0.6,
            color: Color(0xffD6EFED),
            endIndent: 40,
            indent: 40,
            height: 50,
          ),
          Card(
            // margin: EdgeInsets.zero,
            elevation: 5,
            // shadowColor: Colors.green,
            margin:  EdgeInsets.only(right: 20,left: 20,),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(Icons.phone_android),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      Text(
                        'Nova Support',
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold, fontSize: 16,color: Color(0XFFFF7750)),
                      ),
                      Text(
                        '+970-59-5710-574',
                        style: GoogleFonts.nunito(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.call),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('images/facebook.png'),
                radius: 25.r,
              ),
              SizedBox(width: 40.w,),
              CircleAvatar(
                backgroundImage: AssetImage('images/Instagram.png'),
                radius: 25.r,
              ),
            ],
          ),
          const Spacer(),
          Text(
            'yahyaAlkord - eLancer2',
            style: GoogleFonts.cairo(fontSize: 16.sp),
          ),
           SizedBox(height: 10.h),
        ],
      ),
    );

  }
}
