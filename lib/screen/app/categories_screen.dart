import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/subcategory_screen');
          },
          child: Container(
            height: 100,
            margin: EdgeInsetsDirectional.only(bottom: index == 9 ? 0 : 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0, 0),
                    blurRadius: 5,
                  )
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 45.r,
                    backgroundImage: AssetImage('images/shoes1.png'),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shoes brand',
                        style:
                        GoogleFonts.nunitoSans(fontWeight: FontWeight.bold,fontSize: 18.sp),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(onPressed: (){
                    Navigator.pushNamed(context, '/subcategory_screen');
                  }, icon: Icon(Icons.arrow_forward_ios))

                ],
              ),
            ),
          ),
        );
      },),
    );
  }
}
