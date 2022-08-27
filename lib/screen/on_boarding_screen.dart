import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/page_view_content.dart';
import '../widget/page_view_idicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Visibility(
                visible: _currentPage < 2,
                replacement: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login_screen');
                  },
                  child:  Text(
                    'Start',style: GoogleFonts.nunitoSans(color: const Color(0XFFFF7750),fontWeight: FontWeight.bold),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    _pageController.animateToPage(2,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOutBack);
                  },
                  child:  Text(
                    'SKIP',style: GoogleFonts.nunitoSans(color: const Color(0XFFFF7750),fontWeight: FontWeight.bold),
                  ),
                ),
              ),
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
                children: const [
                  PageViewContent(
                      text: 'Discover a New For You',
                      image: 'ob1',
                      subText: 'Lots of new products here and decide'
                          ' which product is best for you'),
                  PageViewContent(
                      text: 'Find Your Best Product',
                      image: 'ob2',
                      subText: 'Famous and quality product at'
                          'affordable prices'),
                  PageViewContent(
                      text: 'Express Product Delivery',
                      image: 'ob3',
                      subText: 'Your product will be delivered to your'
                          'home safetly and securely'),
                ],
              ),
            ),
            SizedBox(height: 10.h,),

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
            const SizedBox(
              height: 30,
            ),

            Visibility(
              visible: _currentPage==  2,
              maintainAnimation: true,
              maintainSize: true,
              maintainState: true,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 25.w),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        offset:  Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                    color: const Color(0XFFFF7750),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize:  Size(double.infinity, 63.h),
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login_screen');
                    },
                    child:  Text(
                      'Start Your Journey',style: GoogleFonts.nunitoSans(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}
