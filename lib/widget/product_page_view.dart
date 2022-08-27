import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/widget/page_view_idicator.dart';

class ProductPageView extends StatelessWidget {
  const ProductPageView({
    required this.image,
    Key? key,
  }) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {

    return Stack(
      children :[
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 25.w,vertical: 25.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.star,color: Color(0XFFFF7750),size: 18.sp,),
              Icon(Icons.star,color: Color(0XFFFF7750),size: 18.sp,),
              Icon(Icons.star,color: Color(0XFFFF7750),size: 18.sp,),
              Icon(Icons.star,color: Color(0XFFFF7750),size: 18.sp,),
              Icon(Icons.star,color: Color(0XFFFF7750),size: 18.sp,),

            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
                height: 300.h,
                child: Image.asset('images/$image.png')),

          ],
        ),
      ]
    );
  }
}