import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  bool _favorite = true;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 20.h),
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
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
                  radius: 40.r,
                  backgroundImage: AssetImage('images/favorite1.png'),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rolex watch',
                      style:
                      GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$65',
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.bold,
                          color: Color(0XFFFF7750)),
                    )
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState((){
                            _favorite = !_favorite;
                          });
                        },
                        icon: Icon(
                          _favorite ? Icons.favorite : Icons.favorite_border,
                          color: Color(0XFFFF7750),
                        )
                    ),
                    Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(Icons.star,color: Color(0XFFFF7750),size: 15.sp,),
                        Icon(Icons.star,color: Color(0XFFFF7750),size: 15.sp,),
                        Icon(Icons.star,color: Color(0XFFFF7750),size: 15.sp,),
                        Icon(Icons.star,color: Color(0XFFFF7750),size: 15.sp,),
                        Icon(Icons.star,color: Color(0XFFFF7750),size: 15.sp,),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
