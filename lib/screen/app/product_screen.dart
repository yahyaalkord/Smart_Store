import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/get/product_getx_controller.dart';
import 'package:smart_store/models/api_response.dart';
import 'package:smart_store/models/product.dart';
import 'package:smart_store/screen/app/bn_screens/cart_screens/cart_screen.dart';
import 'package:smart_store/utils/helpers.dart';
import 'package:smart_store/widget/app_elevated_botton.dart';
import 'package:smart_store/widget/product_page_view.dart';

import '../../api/product_api_controller.dart';
import '../../get/address_getx_controller.dart';
import '../../get/cart_getx_cntroller.dart';
import '../../models/cart.dart';
import '../../prefs/shared_pref_controller.dart';
import '../../widget/page_view_content.dart';
import '../../widget/page_view_idicator.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({required this.id, Key? key}) : super(key: key);
  final int id;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with SingleTickerProviderStateMixin, Helpers {


  late PageController _pageController;
  late TabController _tabController;
  int _currentPage = 0;
  bool _favorite = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put<CartGetxController>(CartGetxController());
    Get.put<AddressGetController>(AddressGetController());
    ProductsApiController().getHomeData();
    _pageController = PageController();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return CartScreen();
                    },
                  ));
                },
                icon: const Icon(Icons.card_travel)),
          ),
        ],
      ),
      body: GetBuilder<ProductGetController>(
        init: ProductGetController(id: widget.id),
        builder: (controller) {
          var product = controller.products;
          if (controller.loading == true) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (product != null) {
            return SafeArea(
              child: Column(
                children: [
                  const Align(
                    alignment: AlignmentDirectional.topEnd,
                  ),
                  Expanded(
                    child: PageView(
                      physics: const BouncingScrollPhysics(),
                      // physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (int currentPage) {
                        setState(() {
                          _currentPage = currentPage;
                        });
                      },
                      children:
                          product.images.map((e) => Image.network(e)).toList(),
                    ),
                  ),

                  //***********
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    PageViewIndicator(
                      isCurrentPage: _currentPage == 0,
                      marginEnd: 15,
                    ),
                    PageViewIndicator(
                      isCurrentPage: _currentPage == 1,
                      marginEnd: 15,
                    ),
                    PageViewIndicator(
                      isCurrentPage: _currentPage == 2,
                    ),
                  ]),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.nameEn,
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Row(
                          children: [
                            Text(
                              '\$ ${product.price}',
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: const Color(0XFFFF7750)),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _favorite = !_favorite;
                                  });
                                },
                                icon: Icon(
                                  _favorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: const Color(0XFFFF7750),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'Siz',
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: Colors.black45),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 50.h),
                          child: TabBar(
                            // indicatorColor: Colors.transparent,
                            indicator: BoxDecoration(
                                color: const Color(0XFFFF7750),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  )
                                ]),
                            controller: _tabController,
                            labelColor: Colors.black,
                            onTap: (int tabIndex) {
                              setState(() {
                                _tabController.index = tabIndex;
                              });
                            },
                            tabs: const [
                              Tab(
                                text: 'S',
                              ),
                              Tab(
                                text: 'M',
                              ),
                              Tab(
                                text: 'L',
                              ),
                              Tab(
                                text: 'XL',
                              ),
                              Tab(
                                text: 'XXL',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38,
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                        color: const Color(0XFFFF7750),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 63.h),
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () async{
                       // var response =  await CartGetxController.to.create(getCart(product));
                       // ignore: use_build_context_synchronously
                       // showSnackBar(context, message: response.message,erorr: !response.success);
                          _showConfirmyBottomSheet(product);
                        },
                        child: Text(
                          'Add To Cart',
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                'NoData',
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.bold, fontSize: 20.sp),
              ),
            );
          }
        },
      ),
    );
  }

  void _showConfirmyBottomSheet(Products products) {

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.r),
                topLeft: Radius.circular(20.r))),
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            '',
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Row(
                            children: [
                              Text(
                                '\$40',
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: const Color(0XFFFF7750)),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _favorite = !_favorite;
                                    });
                                  },
                                  icon: Icon(
                                    _favorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: const Color(0XFFFF7750),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'Siz',
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Colors.black45),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 50.h),
                            child: TabBar(
                              // indicatorColor: Colors.transparent,
                              indicator: BoxDecoration(
                                  color: const Color(0XFFFF7750),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    )
                                  ]),
                              controller: _tabController,
                              labelColor: Colors.black,
                              onTap: (int tabIndex) {
                                setState(() {
                                  _tabController.index = tabIndex;
                                });
                              },
                              tabs: const [
                                Tab(
                                  text: 'S',
                                ),
                                Tab(
                                  text: 'M',
                                ),
                                Tab(
                                  text: 'L',
                                ),
                                Tab(
                                  text: 'XL',
                                ),
                                Tab(
                                  text: 'XXL',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'Color',
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Colors.black45),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Color(0XFF3E3E3E),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              const CircleAvatar(
                                backgroundColor: Color(0XFFAB4444),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              const CircleAvatar(
                                backgroundColor: Color(0XFFE2D1D1),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            children: [
                              Text(
                                'Total rate value',
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const Spacer(),
                              Text(
                                '(3/5)',
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          AppElevatedBotton(
                              title: 'Confirm Add To Cart',
                              onPressed: () async{
                                var response =  await CartGetxController.to.create(getCart(products));
                                showSnackBar(context, message: response.message,erorr: !response.success);
                                // cartGetxController.create(getCart(product))
                                Navigator.pop(context);
                              }),
                        ],
                      ),
                    );
                  },
                );
              });
        });
  }
  Cart getCart(Products product) {
    Cart cart = Cart();
    cart.img = product.imageUrl;
    cart.quantity = int.parse(product.quantity);
    cart.price = double.parse(product.price);
    cart.name = product.nameEn;
    cart.productId = product.id.toString();
    cart.info = product.infoEn;

    return cart;
  }

}
