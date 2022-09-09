import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/get/home_getx_controller.dart';
import 'package:smart_store/screen/app/categories_screen.dart';
import 'package:smart_store/widget/app_text_field.dart';
import 'package:smart_store/widget/home_section.dart';

import '../../../models/api_response.dart';
import '../products_screen.dart';
import '../subcategory_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late void Function(int) onPressed;
  late TextEditingController _searchTextController;
  late PageController _pageController;
  late PageController _pageController1;
  int _currentPage = 0;
  bool _favorite = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchTextController = TextEditingController();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 0);
    _pageController1 = PageController(viewportFraction: 0.8, initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchTextController.dispose();
    _pageController.dispose();
    _pageController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeGetController>(
        init: HomeGetController(),
        builder: (controller) {
          var home = controller.home;
          if(controller.loading == true){
            return Center(child: CircularProgressIndicator(),);
          } else if (home != null) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
              children: [
                AppTextField(
                    hint: 'Search product',
                    prefixIcon: Icons.search,
                    keyboardType: TextInputType.text,
                    controller: _searchTextController),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'WELCOME BACK..',
                  style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 190),
                  child: PageView(
                    physics: const BouncingScrollPhysics(),
// physics: ClampingScrollPhysics(),
                    controller: _pageController1,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (int currentPage) {
                      setState(() {
                        _currentPage = currentPage;
                      });
                    },
                    children: home.slider.map(
                      (e) => Card(
                        elevation: 0,
                        child: Image(image: NetworkImage(e.imageUrl)),
                      ),
                    ).toList(),
                  ),
                ),
                HomeSection(
                    titel: 'Category',
                    onPressed: () {
                      Navigator.pushNamed(context, '/categorise_screen');
                    }),
// SizedBox(height: 20.h,),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 150.h,
                  ),
                  child: GridView.builder(
                    itemCount: home.categories.length,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 10,
                      childAspectRatio: 110.h / 141.w,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          title = home.categories[index].nameEn;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SubCategoryScreen(id: home.categories[index].id),
                              ));
                        },
                        child: Container(
                          margin:  EdgeInsetsDirectional.only(end: 5.h),
                          child: Column(
                            children: [
                              Image(
                                image: NetworkImage(
                                    home.categories[index].imageUrl),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                home.categories[index].nameEn,
                                style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: const Color(0XFFFF7750)),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                HomeSection(
                    titel: 'Latest Products',
                    onPressed: () {
                      Navigator.pushNamed(context, '/products_screen');
                    }),
                SizedBox(
                  height: 20.h,
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: home.latestProducts.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductsScreen(id: home.latestProducts[index].id),
                            ));
                      },
                      child: SizedBox(
                        height: 350.h,
                        child: Container(
                          height: 350.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            color: const Color(0XFFDEDEE0)),
                                        child: Image(
                                          image: NetworkImage(
                                              home.latestProducts[index].imageUrl),
                                        ),
                                      ),
                                    ),
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
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                 home.latestProducts[index].nameEn,
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                  child: Text(
                                '\$${home.latestProducts[index].price}',
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0XFFFF7750)),
                                textAlign: TextAlign.start,
                              )),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                HomeSection(
                    titel: 'Products you may like',
                    onPressed: () {
                      Navigator.pushNamed(context, '/like_product_screen');
                    }),
                SizedBox(
                  height: 10.h,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: home.famousProducts.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductsScreen(id: home.famousProducts[index].id),
                            ));
                      },
                      child: Container(
                        height: 100,
                        margin: EdgeInsetsDirectional.only(
                            bottom: index == 9 ? 0 : 15),
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
                          padding: EdgeInsets.zero,
                          child: Row(
                            children: [
                              Padding(
                                padding:  EdgeInsetsDirectional.only(start:10.w ),
                                child: CircleAvatar(
                                  radius: 40.r,
                                  backgroundImage: NetworkImage(
                                     home.famousProducts[index].imageUrl),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    home.famousProducts[index].nameEn,
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    home.famousProducts[index].price,
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0XFFFF7750)),
                                  )
                                ],
                              ),
                              // const Spacer(flex: 2,),
                              Padding(
                                padding: EdgeInsets.only(top: 40.h,),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: const Color(0XFFFF7750),
                                      size: 15.sp,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: const Color(0XFFFF7750),
                                      size: 15.sp,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: const Color(0XFFFF7750),
                                      size: 15.sp,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: const Color(0XFFFF7750),
                                      size: 15.sp,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: const Color(0XFFFF7750),
                                      size: 15.sp,
                                    ),
                                  ],
                                ),
                              ),
                              // const Spacer(flex: 2,),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          } else {
            return Center(
              child: Text(
                'NO DATA',
                style: GoogleFonts.nunitoSans(
                    fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            );
          }
        });
  }
}
