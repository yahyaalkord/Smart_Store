import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(end: 20.w),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0XFFF9F3EE),
                    )
                  ]),
              child: TextButton(
                onPressed: () {
                  _showConfirmyBottomSheet();
                },
                child: Text(
                  'Buy',
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(end: 20.w),
            child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: const [BoxShadow(color: Color(0XFFF9F3EE))]),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.red,
                    ))),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                height: 90,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 10.h,
                ),
                padding: EdgeInsetsDirectional.only(start: 15.w, end: 5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 0),
                      color: Colors.black45,
                      blurRadius: 4,
                    ),
                  ],
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
                          backgroundImage: AssetImage('images/caty.png'),
                          radius: 30.r,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Home furnishing',
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                'Quantity:   ${2}    Total:   \$${50}',
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w300,
                                  height: 1.0,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              iconSize: 20,
                              icon: const Icon(
                                Icons.add,
                                color: Colors.green,
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsetsDirectional.only(top: 10.h),
                              onPressed: () {},
                              iconSize: 20,
                              icon: const Icon(Icons.remove),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              color: Color(0XFFF9F3EE),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Total:',
                        style: GoogleFonts.cairo(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '10',
                        style: GoogleFonts.cairo(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text(
                        'Quantity:',
                        style: GoogleFonts.cairo(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '\$300',
                        style: GoogleFonts.cairo(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmyBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.r),
                topLeft: Radius.circular(20.r))),
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return BottomSheet(onClosing: () {
            Navigator.pop(context);
          }, builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                  ],
                );
              },
            );
          });
        });
  }
}
