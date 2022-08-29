import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/model/bn_screen.dart';
import 'package:smart_store/screen/app/bn_screens/cart_screens/cart_screen.dart';
import 'package:smart_store/screen/app/bn_screens/favorite_screen.dart';
import 'package:smart_store/screen/app/bn_screens/home_screen.dart';
import 'package:smart_store/screen/app/bn_screens/profile_screen.dart';
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
    const BnScreen(title: 'Cart', widget: CartScreen()),
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
                borderRadius: BorderRadius.circular(10.r),

              ),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('images/avatar.png'),
                radius: 40,
              ),
              accountName: Text(
                'User Name',
                style: GoogleFonts.montserrat(),
              ),
              accountEmail: Text(
                'Flutter@email.com',
                style: GoogleFonts.montserrat(),
              ),
             
            ),

            ListTile(
              onTap: () {
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.pushNamed(context, '/orders_screen');

                });

              },
              leading: const Icon(Icons.question_answer),
              title: Text('ORDERS',style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
              subtitle: Text('My Order Status ',style: GoogleFonts.nunitoSans(),),
              trailing: const Icon(Icons.arrow_forward_ios,size: 18,),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Future.delayed(const Duration(milliseconds: 500), () {
                  // Navigator.pushNamed(context, '/third_favorite_screen');
                });

              },
              leading: const Icon(Icons.question_answer),
              title: Text('NOTIFICATIONS',style:GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
              subtitle: Text('Show notifications received ',style: GoogleFonts.nunitoSans(),),
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
}
