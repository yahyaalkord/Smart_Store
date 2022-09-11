import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/get/address_getx_controller.dart';
import 'package:smart_store/models/address.dart';
import 'package:smart_store/models/api_response.dart';
import 'package:smart_store/utils/extenssion.dart';
import 'package:smart_store/utils/helpers.dart';
import 'package:smart_store/widget/app_elevated_botton.dart';
import 'package:smart_store/widget/app_text_field.dart';

import '../../../../api/order_api_controller.dart';
import '../../../../get/cart_getx_cntroller.dart';
import '../../../../models/create_order.dart';

class CartScreen extends StatefulWidget {
  /*const*/ CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with Helpers {
  late TextEditingController _textEditingController;
  int _cuonter = 0;
  String _box = 'address 1';
  String _payment = 'online';
  int? _selectedCountryId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put<CartGetxController>(CartGetxController());
    Get.put<AddressGetController>(AddressGetController());
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
    return GetBuilder<CartGetxController>(
        init: CartGetxController(),
        builder: (controller) {
          if (controller.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.cartItems.isNotEmpty) {
            var cart = controller.cartItems;
            return Scaffold(
                appBar: AppBar(
                  actions: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 20.w),
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: const [
                                BoxShadow(color: Color(0XFFF9F3EE))
                              ]),
                          child: IconButton(
                              onPressed: () {
                                CartGetxController.to.clear();
                              },
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
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 90,
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 10.h,
                          ),
                          padding:
                              EdgeInsetsDirectional.only(start: 15.w, end: 5.w),
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
                                  onPressed: () {
                                    controller.changeQuantity(index, 0);
                                  },
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
                                    backgroundImage:
                                        NetworkImage(cart[index].img),
                                    radius: 30.r,
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cart[index].name,
                                          style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        Text(
                                          'Quantity:   ${cart[index].quantity}    Total:   \$${cart[index].price}',
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
                                        onPressed: () {
                                          controller.changeQuantity(index,
                                              cart[index].quantity += 1, "add");
                                        },
                                        iconSize: 20,
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.green,
                                        ),
                                      ),
                                      IconButton(
                                        padding: EdgeInsetsDirectional.only(
                                            top: 10.h),
                                        onPressed: () {
                                          controller.changeQuantity(
                                              index,
                                              cart[index].quantity -= 1,
                                              "minus");
                                        },
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
                                  controller.total.toString(),
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
                                  '\$${controller.itemsCount.toString()}',
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
                ));
          } else {
            return Center(
              child: Text(
                'Sorry, your cart is Empty',
                style: GoogleFonts.nunitoSans(fontSize: 20.sp),
              ),
            );
          }
        });
  }

  void _showConfirmyBottomSheet() {
    showModalBottomSheet<ApiResponseT>(
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
                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                  shrinkWrap: true,
                  children: [
                    Text(
                      'Enter your contact information',
                      style:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.bold,fontSize: 16.sp),
                    ),
                    SizedBox(height: 15.h,),
                    Text(
                      'Choose Your Address',
                      style: GoogleFonts.nunitoSans(),
                    ),
                    SizedBox(height: 20.h,),
                    GetBuilder<AddressGetController>(
                      builder: (controller) {
                        var list = controller.list;
                        return Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 20.w),
                          child: DropdownButton(
                            hint: const Text('Select your Country'),
                            style: GoogleFonts.montserrat(color: Colors.black),
                            onTap: () {},
                            icon: const Icon(Icons.keyboard_arrow_down),
                            // itemHeight: 65,
                            dropdownColor: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            underline: const Divider(
                              color: Colors.black,
                              thickness: 1,
                              height: 0,
                            ),
                            isExpanded: true,
                            value: _selectedCountryId,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedCountryId = value;
                              });
                            },
                            items: list
                                .map((e) => DropdownMenuItem(
                                    value: e.id, child: Text(e.name)))
                                .toList(),
                          ),
                        );
                      },
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
                    AppTextField(
                      hint: 'Enter Card Number',
                      prefixIcon: Icons.add_card,
                      keyboardType: TextInputType.text,
                      controller: _textEditingController,
                    ),
                    SizedBox(height: 30.h,),
                    AppElevatedBotton(title: 'Buy Now !', onPressed: (){
                      _performBuy(context);
                    }),
                  ],
                );
                // return Padding(
                //   padding:
                //   EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                //   child: GetBuilder<AddressGetController>(
                //     builder: (controller) {
                //       var list = controller.list;
                //       return Column(
                //         children: [
                //           Text(
                //             'Your Adresses',
                //             style: GoogleFonts.nunitoSans(
                //                 fontWeight: FontWeight.bold),
                //           ),
                //           ListView.builder(
                //             shrinkWrap: true,
                //             itemCount: list.length,
                //             itemBuilder: (context, index) {
                //               address = list[index];
                //               gIndex = index;
                //               print("size ${list.length}");
                //               return Column(
                //                 mainAxisSize: MainAxisSize.min,
                //                 children: [
                //                   Stack(
                //                     children: [
                //                       Row(
                //                         children: [
                //                           const Icon(Icons.location_pin,
                //                               size: 30,
                //                               color: const Color(0XFFFF7750)),
                //                           SizedBox(
                //                             width: 10.w,
                //                           ),
                //                           Text(
                //                             list[index].info,
                //                             style: GoogleFonts.nunitoSans(
                //                               fontSize: 16.sp,
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                       Align(
                //                         alignment:
                //                         AlignmentDirectional.centerEnd,
                //                         child: Container(
                //                           decoration: BoxDecoration(
                //                               borderRadius:
                //                               BorderRadius.circular(40.r),
                //                               boxShadow: [
                //                                 BoxShadow(
                //                                     color:
                //                                     Colors.orange.shade100)
                //                               ]),
                //                           child: IconButton(
                //                             onPressed: () {
                //                               Navigator.pop(context);
                //                             },
                //                             icon: const Icon(Icons.update),
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                   SizedBox(
                //                     height: 10.h,
                //                   ),
                //                   const Divider(),
                //                 ],
                //               );
                //             },
                //           ),
                //         ],
                //       );
                //     },
                //   ),
                // );
              },
            );
          });
        }).then((value) {
          if(value != null){
            if(value.status){
              showSnackBar(context, message: value.message,erorr: !value.status);
            }
          }
    });
  }

  void _performBuy(BuildContext context) async {
    if (_checkData()) {
     var res = await _createOrder();
     if(res.status){
       // ignore: use_build_context_synchronously
       _done(context,res);
     }
    }
  }

  bool _checkData() {
    if (_textEditingController.text.isNotEmpty && _payment != null ||
        _payment == 'cash') {
      return true;
    }
    Navigator.pop(context);
    showSnackBar(context, message: 'Enter Your Required Data');
    return false;
  }

  void _done(BuildContext context,ApiResponseT responseT) {
    Navigator.pop(context,responseT);
    // showSnackBar(context, message: 'Buy Successfully', erorr: false);
  }

  Future<ApiResponseT> _createOrder() async {
    return OrderApiController().createOrder(
      order: CreateOrder(
        paymentType: "Cash",
        addressId: AddressGetController.to.defaultAddress!.id.toString(),
        cart: CartGetxController.to.cartItems.map((e) => CartObj.fromJson(e.toJson())).toList(),
      ),
    );
  }
}

