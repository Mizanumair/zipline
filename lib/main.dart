import 'package:courier_app/src/core/config/navigation_binding.dart';
import 'package:courier_app/src/core/config/routes.dart';
import 'package:courier_app/src/core/constants/palette.dart';
import 'package:courier_app/src/core/constants/user_constants.dart';
import 'package:courier_app/src/features/auth/auth/preferences_service.dart';
import 'package:courier_app/src/features/auth/forgot_password/forgot_password_binding.dart';
import 'package:courier_app/src/features/auth/login/login_bindings.dart';
import 'package:courier_app/src/features/auth/new_password/new_password_binding.dart';
import 'package:courier_app/src/features/auth/register/register_binding.dart';
import 'package:courier_app/src/features/auth/splash/splash_binding.dart';
import 'package:courier_app/src/features/features/add_order/add_order1_screen.dart';
import 'package:courier_app/src/features/features/add_order/add_order_binding.dart';
import 'package:courier_app/src/features/features/home/home_binding.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  SplashBinding().dependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
  );
  await PreferencesService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  SharedPreferences prefs = PreferencesService.instance;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isFirstLogin = prefs.getInt('loginCounter') == 1;
    print(isFirstLogin);
    int? userId = prefs.getInt(UserContants.userId);

    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return GetMaterialApp(
            theme: ThemeData(
              fontFamily: 'OpenSans',
              primarySwatch: Colors.pink,
              colorScheme: const ColorScheme.light(
                primary: AppColors.orange,
              ),
              scaffoldBackgroundColor: AppColors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.white,
                elevation: 0,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                elevation: 3,
                backgroundColor: AppColors.white,
              ),
            ),
            debugShowCheckedModeBanner: false,
            smartManagement: SmartManagement.full,
            initialRoute: !isFirstLogin
                ? AppRoutes.getSplashRoute()
                : userId == null
                    ? AppRoutes.getSplashRoute()
                    : AppRoutes.getNavBarRoute(),
            initialBinding: !isFirstLogin
                ? SplashBinding()
                : userId != null
                    ? SplashBinding()
                    : NavBarBinding(),
            // initialRoute: AppRoutes.getAddOrderOneRoute(),
            // initialBinding: AddOrderBinding(),
            getPages: AppRoutes.getPages(),
            onGenerateRoute: (settings) => AppRoutes.generateRoute(settings),
          );
        });
  }
}
