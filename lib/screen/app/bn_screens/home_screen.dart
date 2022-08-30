import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/widget/app_text_field.dart';
import 'package:smart_store/widget/home_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            children: const [
              Card(
                elevation: 0,
                child: Image(image: AssetImage('images/Group1.png')),
              ),
              Card(
                elevation: 0,
                child: Image(image: AssetImage('images/Group2.png')),
              ),
              Card(
                elevation: 0,
                child: Image(image: AssetImage('images/Group3.png')),
              ),
            ],
          ),
        ),
        HomeSection(
            titel: 'Category',
            onPressed: () {
              Navigator.pushNamed(context, '/categorise_screen');
            }),
        // SizedBox(height: 20.h,),
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/subcategory_screen');
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 150.h,
            ),
            child: GridView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  childAspectRatio: 110.h/141.w,
                   ),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsetsDirectional.only(end: 5),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('images/category1.png'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10.h,),
                      Text(
                        'Furniture',
                        style:
                        GoogleFonts.nunitoSans(fontWeight: FontWeight.bold,fontSize: 16,color: Color(0XFFFF7750)),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        HomeSection(titel: 'Latest Products', onPressed: () {
          Navigator.pushNamed(context,'/products_screen');
        }),
        SizedBox(
          height: 20.h,
        ),
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/product_screen');
          },
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 30,
              crossAxisSpacing: 15,
            ),
            itemBuilder: (context, index) {
              return SizedBox(
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
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: const Color(0XFFDEDEE0)),
                                child: const Image(
                                  image: AssetImage('images/shoes.png'),
                                ),
                              ),
                            ),
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
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Nike Jordan 1 Retro'
                              'Yellow',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                          child: Text(
                            '\$28',
                            style: GoogleFonts.nunitoSans(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0XFFFF7750)),
                            textAlign: TextAlign.start,
                          )),
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
        HomeSection(titel: 'Products you may like', onPressed: () {
          Navigator.pushNamed(context, '/like_product_screen');
        }),
        SizedBox(
          height: 10.h,
        ),
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/product_screen');
          },
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
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
                        backgroundImage: AssetImage('images/caty.png'),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Home furnishings',
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\$100',
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.bold,
                                color: Color(0XFFFF7750)),
                          )
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.star,
                              color: Color(0XFFFF7750),
                              size: 15.sp,
                            ),
                            Icon(
                              Icons.star,
                              color: Color(0XFFFF7750),
                              size: 15.sp,
                            ),
                            Icon(
                              Icons.star,
                              color: Color(0XFFFF7750),
                              size: 15.sp,
                            ),
                            Icon(
                              Icons.star,
                              color: Color(0XFFFF7750),
                              size: 15.sp,
                            ),
                            Icon(
                              Icons.star,
                              color: Color(0XFFFF7750),
                              size: 15.sp,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
