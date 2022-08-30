import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/utils/helpers.dart';
import 'package:smart_store/widget/app_elevated_botton.dart';
import 'package:smart_store/widget/app_text_field.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with Helpers{
  late TextEditingController _textEditingController;
  int _cuonter = 0;
  String _box = 'address 1';
  String _payment = 'online';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

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
                    boxShadow: const [BoxShadow(color: Color(0XFFF9F3EE))]),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
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
            physics: const NeverScrollableScrollPhysics(),
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
                        icon: const Icon(Icons.close),
                        color: Colors.red,
                        visualDensity: const VisualDensity(
                          vertical: VisualDensity.minimumDensity,
                          horizontal: VisualDensity.minimumDensity,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: const AssetImage('images/caty.png'),
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
                                style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                'Quantity:   ${2}    Total:   \$${50}',
                                style: GoogleFonts.nunitoSans(
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
              color: const Color(0XFFF9F3EE),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Total:',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '10',
                        style: GoogleFonts.nunitoSans(
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
                        style: GoogleFonts.nunitoSans(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$300',
                        style: GoogleFonts.nunitoSans(
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
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: AppElevatedBotton(
                title: 'Buy Now !',
                onPressed: () => _showConfirmyBottomSheet()),
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
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_pin,
                            size: 30, color: Color(0XFFFF7750)),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Enter Your Addresses',
                          style: GoogleFonts.nunitoSans(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        PopupMenuButton<String>(onSelected: (String value) {
                          if (_box != value) {
                            setState(() {
                              _box = value;
                              _cuonter = 0;
                            });
                          }
                        }, itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: 'a1',
                              height: 20,
                              child: Text(
                                'Address 1',
                                style: GoogleFonts.nunitoSans(),
                              ),
                            ),
                            const PopupMenuDivider(),
                            PopupMenuItem(
                              value: 'a2',
                              height: 20,
                              child: Text(
                                'Address 2',
                                style: GoogleFonts.nunitoSans(),
                              ),
                            ),
                          ];
                        }),
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                              title: const Text('Cash'),
                              value: 'cash',
                              groupValue: _payment,
                              onChanged: (String? value) {
                                setState(() => _payment = value!);
                              }),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                              title: const Text('Online '),
                              value: 'online ',
                              groupValue: _payment,
                              onChanged: (String? value) {
                                setState(() => _payment = value!);
                              }),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.w),
                      child: AppTextField(
                        hint: 'Enter Card Number',
                        prefixIcon: Icons.add_card,
                        keyboardType: TextInputType.text,
                        controller: _textEditingController,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: AppElevatedBotton(
                          title: 'Buy Now !',
                          onPressed: () => _performBuy()),
                    ),
                    SizedBox(height: 15.h,),
                  ],
                );
              },
            );
          });
        });
  }
  void _performBuy() {
    if(_checkData()) {
      _buy();
    }
  }
  bool _checkData(){
    if(_textEditingController.text.isNotEmpty&& _payment != null || _payment == 'cash'){
      return true;
    }
    Navigator.pop(context);
    showSnackBar(context, message: 'Enter Your Required Data');
    return false;
  }
  void _buy() {
    Navigator.pop(context);
    showSnackBar(context, message: 'Buy Successfully',erorr: false);
  }
}
