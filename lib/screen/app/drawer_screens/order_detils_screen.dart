import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/utils/helpers.dart';
import 'package:smart_store/widget/app_elevated_botton.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> with Helpers{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Order Details'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Column(
            children: [
              Container(
                alignment: AlignmentDirectional.center,
                height: 200.h,
                width: double.infinity,
                child: Image(image: AssetImage('images/Jacket.png')),
              ),
              SizedBox(
                height: 40.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Color(0XFFF9F3EE),
                ),

                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
                  child: Column(
                    children: [
                      Text(
                        'Jacket Pullover Sweat Hoodie',
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold, color: Color(0XFFFF7750)),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'Quantity : ',
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,

                            ),
                          ),

                          Text(
                            '2',
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              color: Color(0XFFFF7750),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'Number : ',
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            'order #1',
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              color: Color(0XFFFF7750),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'Total : ',
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            '\$120',
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              color: Color(0XFFFF7750),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'Date : ',
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            '14/6/2021',
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              color: Color(0XFFFF7750),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              AppElevatedBotton(title: 'Order products', onPressed: (){
                Future.delayed(Duration(milliseconds: 500),(){
                  Navigator.pop(context);
                  showSnackBar(context, message: 'Order Successfully',erorr: false);
                });


              })
            ],
          ),
        ));
  }
}
