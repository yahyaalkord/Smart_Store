import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/api/order_api_controller.dart';
import 'package:smart_store/models/order.dart';

import 'order_detils_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ORDERS'),
      ),
      body: FutureBuilder<List<Order>>(
        future: OrderApiController().getCards(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
              itemBuilder: (context, index) {
                var order = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return OrderDetailsScreen(id: order.id,);
                      },
                    ));
                  },
                  child: Container(
                    height: 150.h,
                    margin: EdgeInsetsDirectional.only(
                        bottom: index == 3.h ? 0 : 15.h),
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
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      order.id.toString(),
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 30.w,
                                    ),
                                    Text(
                                      order.date,
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black45),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      'Total: \$${order.total}',
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0XFFFF7750)),
                                    ),
                                    SizedBox(
                                      width: 30.w,
                                    ),
                                    Text(
                                      order.status,
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      'Payment type: ',
                                      style: GoogleFonts.nunitoSans(),
                                    ),
                                    Text(
                                      'cash',
                                      style: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0XFFFF7750)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'No Data',
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.bold, fontSize: 25.sp),
              ),
            );
          }
        },
      ),
    );
  }
}
