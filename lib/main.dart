import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_store/screen/app/address_screen.dart';
import 'package:smart_store/screen/app/bottom_nav_screen.dart';
import 'package:smart_store/screen/app/categories_screen.dart';
import 'package:smart_store/screen/app/favorite_screen.dart';
import 'package:smart_store/screen/app/home_screen.dart';
import 'package:smart_store/screen/app/product_screen.dart';
import 'package:smart_store/screen/app/profile_screen.dart';
import 'package:smart_store/screen/app/setting_screen.dart';
import 'package:smart_store/screen/app/subcategory_screen.dart';
import 'package:smart_store/screen/app/updated_address_screen.dart';
import 'package:smart_store/screen/auth/fotget_password_screen.dart';
import 'package:smart_store/screen/auth/login_screen.dart';
import 'package:smart_store/screen/auth/signup_screen.dart';
import 'package:smart_store/screen/auth/reset_password_screen.dart';
import 'package:smart_store/screen/auth/verification_screen.dart';
import 'package:smart_store/screen/launch_screen.dart';
import 'package:smart_store/screen/on_boarding_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
      builder: (context, child) {
          return  MaterialApp(
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            //OR
            //  localizationsDelegates: AppLocalizations.localizationsDelegates,
            //******************
            supportedLocales: [
               Locale('ar'),
               Locale('en'),
            ],
            locale:  Locale('en'),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0XFFFAFAFA),
              appBarTheme: AppBarTheme(
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                iconTheme: const IconThemeData(
                    color: Colors.black
                ),
                titleTextStyle: GoogleFonts.nunitoSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
          ),
            initialRoute: '/launch_screen',
            routes: {
              '/launch_screen' : (context) => const LaunchScreen(),
              '/onBoarding_screen' : (context) => const OnBoardingScreen(),
              '/login_screen' : (context) => const LoginScreen(),
              '/forget_password_screen' : (context) => const ForgetPasswordScreen(),
              '/verification_screen' : (context) => const VerificationScreen(),
              '/reset_password_screen' : (context) => const ResetPasswordScreen(),
              '/signup_screen' : (context) => const SignUpScreen(),
              '/home_screen' : (context) => const HomeScreen(),
              '/favorite_screen' : (context) => const FavoriteScreen(),
              '/categorise_screen' : (context) => const CategoriesScreen(),
              '/subcategory_screen' : (context) => const SubCategoryScreen(),
              '/product_screen' : (context) => const ProductScreen(),
              '/profile_screen' : (context) => const ProfileScreen(),
              '/settings_screen' : (context) => const SettingsScreen(),
              '/bottom_nav_screen' : (context) => const BottomNavigationScreen(),
              '/address_screen' : (context) => const AddressScreen(),
              '/updated_address_screen' : (context) => const UpdatedAddressScreen(),

            },
          );
      },

         );
  }
}
