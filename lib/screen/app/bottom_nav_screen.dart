import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/api/auth_api_controller.dart';
import 'package:smart_store/model/bn_screen.dart';
import 'package:smart_store/models/api_response.dart';
import 'package:smart_store/prefs/shared_pref_controller.dart';
import 'package:smart_store/screen/app/bn_screens/cart_screens/cart_screen.dart';
import 'package:smart_store/screen/app/bn_screens/favorite_screen.dart';
import 'package:smart_store/screen/app/bn_screens/home_screen.dart';
import 'package:smart_store/screen/app/bn_screens/settings/profile_screen.dart';
import 'package:smart_store/screen/app/bn_screens/setting_screen.dart';


class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedPageIndex = 0;

  final List<BnScreen> _screens = <BnScreen>[
    const BnScreen(title: 'Home', widget: HomeScreen()),
    const BnScreen(title: 'favorite', widget: FavoriteScreen()),
    /*const*/ BnScreen(title: 'Cart', widget: CartScreen()),
    const BnScreen(title: 'Settings', widget: SettingsScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedPageIndex].title),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0XFFFF7750),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r)),

              ),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('images/profile2.png'),
                radius: 40,
              ),
              accountName: Text(
                SharedPrefController().getValueFor(PrefKeys.name.name),
                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                SharedPrefController().getValueFor(PrefKeys.mobile.name).toString(),
                style: GoogleFonts.nunitoSans(),
              ),

            ),

            ListTile(
              onTap: () {
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.pushNamed(context, '/orders_screen');

                });

              },
              leading: const Icon(Icons.reorder),
              title: Text('ORDERS',style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
              subtitle: Text('My Order Status ',style: GoogleFonts.nunitoSans(),),
              trailing: const Icon(Icons.arrow_forward_ios,size: 18,),
            ),
            SizedBox(height: 20.h,),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.pushNamed(context, '/notification_screen');
                });

              },
              leading: const Icon(Icons.notification_add),
              title: Text('NOTIFICATIONS',style:GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
              subtitle: Text('Show notifications received ',style: GoogleFonts.nunitoSans(),),
              trailing: const Icon(Icons.arrow_forward_ios,size: 18,),
            ),
            SizedBox(height: 20.h,),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.pushNamed(context, '/address_screen');
                });

              },
              leading: const Icon(Icons.location_pin),
              title: Text('Addresses',style:GoogleFonts.nunitoSans(fontWeight: FontWeight.bold,fontSize: 16.sp),),
              trailing: const Icon(Icons.arrow_forward_ios,size: 18,),
            ),
            SizedBox(height: 20.h,),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.pushNamed(context, '/contact_screen');
                });

              },
              leading: const Icon(Icons.contact_mail),
              title: Text('Contact us',style:GoogleFonts.nunitoSans(fontWeight: FontWeight.bold,fontSize: 16.sp),),
              trailing: const Icon(Icons.arrow_forward_ios,size: 18,),
            ),
            SizedBox(height: 20.h,),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.pushNamed(context, '/about_screen');
                });

              },
              leading: const Icon(Icons.contact_support),
              title: Text('About',style:GoogleFonts.nunitoSans(fontWeight: FontWeight.bold,fontSize: 16.sp),),
              trailing: const Icon(Icons.arrow_forward_ios,size: 18,),
            ),
            SizedBox(height: 40.h,),
            ListTile(

              onTap: () {
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 500), () {
                  _confirmLogoutDialog();
                });

              },
              leading: const Icon(Icons.logout),
              title: Text('Logout',style:GoogleFonts.nunitoSans(fontWeight: FontWeight.bold,fontSize: 16.sp),),
              trailing: const Icon(Icons.arrow_forward_ios,size: 18,),
            ),

          ],
        ),
      ),
      body: _screens[_selectedPageIndex].widget,
      bottomNavigationBar: ClipRRect(
        borderRadius:  BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),//طعجه بالبار السفلي
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.deepOrangeAccent,
          selectedIconTheme: const IconThemeData(
            color: Colors.deepOrangeAccent, /*size: 24*/
          ),

          selectedLabelStyle: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          elevation: 1,

          unselectedIconTheme: const IconThemeData(color: Colors.orange),
          unselectedItemColor: Colors.orange,
          unselectedLabelStyle:
          GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 12),

          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (int selectedPageIndex) {
            setState(() {
              _selectedPageIndex = selectedPageIndex;
            });
          },
          currentIndex: _selectedPageIndex,
          items: const[
            BottomNavigationBarItem(
              activeIcon:  Icon(Icons.home),
              icon:  Icon(Icons.home_outlined),
              label: 'home',
            ),
            BottomNavigationBarItem(
              activeIcon:  Icon(Icons.favorite,),
              icon:  Icon(
                Icons.favorite_border,
              ),
              label: 'favorite',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.shopping_cart_rounded),
              icon:  Icon(
                Icons.shopping_cart_outlined,
              ),
              label: 'cart',
            ),
            BottomNavigationBarItem(
              activeIcon:  Icon(Icons.settings),
              icon:  Icon(
                Icons.settings_outlined,
              ),
              label: 'settings',
            ),
          ],
        ),
      ),
    );
  }
  void _confirmLogoutDialog() async {
    showDialog<bool>(
      context: context,
      // barrierColor: Colors.red.shade100.withOpacity(0.5),
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'log out',style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
          ),
          titleTextStyle: GoogleFonts.cairo(
            fontSize: 16,
            color: Colors.black,
          ),
          content: Text(
            'Are you sure to log out',style: GoogleFonts.nunitoSans(),
          ),
          contentTextStyle: GoogleFonts.cairo(
            fontSize: 13,
            color: Colors.black45,
          ),
          actions: [
            TextButton(
              onPressed: () async{
                ApiResponse apiResponse = await AuthApiController().logout();
                if(apiResponse.success){
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/login_screen');
                }

              },
              child: Text(
                'Yes',
                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold,color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );

  }
}
