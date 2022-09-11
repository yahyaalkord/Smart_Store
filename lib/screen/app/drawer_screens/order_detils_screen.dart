import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/api/order_api_controller.dart';
import 'package:smart_store/models/api_response.dart';
import 'package:smart_store/models/order_detils.dart';
import 'package:smart_store/utils/helpers.dart';
import 'package:smart_store/widget/app_elevated_botton.dart';

class OrderDetailsScreen extends StatefulWidget {
  /*const*/ OrderDetailsScreen({Key? key, required this.id}) : super(key: key);
  int id;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> with Helpers {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Order Details'),
        ),
        body: FutureBuilder<ApiResponseT<OrderDetails>>(
          future:
              OrderApiController().getOrderDetails(id: widget.id.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data != null) {
              return ListView(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('order id:',style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
                            SizedBox(width: 25.w,),
                            Text(snapshot.data!.model!.id.toString()),
                          ],
                        ),
                        SizedBox(height: 25.w,),
                        Row(
                          children: [
                            Text('order total:',style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
                            SizedBox(width: 25.w,),
                            Text(snapshot.data!.model!.total),
                          ],
                        ),
                        SizedBox(height: 25.w,),
                        Row(
                          children: [
                            Text('order date:',style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
                            SizedBox(width: 25.w,),
                            Text(snapshot.data!.model!.date),
                          ],
                        ),
                        SizedBox(height: 25.w,),
                        Row(
                          children: [
                            Text('Status:',style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
                            SizedBox(width: 25.w,),
                            Text(snapshot.data!.model!.status),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.model!.products.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                            border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        width: double.infinity,
                        height: 100.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(snapshot
                                  .data!.model!.products[index].imageUrl),
                              radius: 35.r,
                            ),
                            Text(snapshot
                                .data!.model!.products[index].nameEn,style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
                            Row(
                              children: [
                                Text('Quantity:  ',style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
                                Text(snapshot
                                    .data!.model!.products[index].quantity),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
/* ListView(
                  children: [
                    for(int i=0;i<snapshot.data!.model!.products.length;i++)
                    Container(
                      alignment: AlignmentDirectional.center,
                      height: 200.h,
                      width: double.infinity,
                      child: Image(image: NetworkImage(snapshot.data!.model!.products[0].imageUrl)),
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
                              snapshot.data!.model!.id.toString(),
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
                                  snapshot.data!.model!.total.toString(),
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

                  ],
                ),*/
}
