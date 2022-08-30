import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Notifications'),
            SizedBox(width: 5.w,),
            Icon(Icons.notifications_active,color: Color(0XFFFF7750),)
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            height: 100.h,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 10.h,
            ),
            padding: EdgeInsetsDirectional.only(start: 15.w, end: 5.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,

            ),
            child: Stack(
              children: [
                PositionedDirectional(
                  end: 0,
                  top: 0,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.close),
                    color: Colors.red,
                    visualDensity: VisualDensity(
                      vertical: VisualDensity.minimumDensity,
                      horizontal: VisualDensity.minimumDensity,
                    ),
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('images/Group1.png'),
                      radius: 30.r,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text('Your order has been sent'),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
