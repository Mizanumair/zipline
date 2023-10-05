import 'package:courier_app/src/core/config/navigation_binding.dart';
import 'package:courier_app/src/core/config/navigation_screen.dart';
import 'package:courier_app/src/features/auth/forgot_otp_email/forgot_otp_email_binding.dart';
import 'package:courier_app/src/features/auth/forgot_otp_email/forgot_otp_email_screen.dart';
import 'package:courier_app/src/features/auth/forgot_otp_mob/forgot_otp_binding.dart';
import 'package:courier_app/src/features/auth/forgot_otp_mob/forgot_otp_mobile_screen.dart';
import 'package:courier_app/src/features/auth/forgot_password/forgot_password_binding.dart';
import 'package:courier_app/src/features/auth/forgot_password/forgot_password_screen.dart';
import 'package:courier_app/src/features/auth/forgot_password2/forge_password2.dart';
import 'package:courier_app/src/features/auth/forgot_password2/forgot_password_2_binding.dart';
import 'package:courier_app/src/features/auth/login/login_bindings.dart';
import 'package:courier_app/src/features/auth/login/login_screen.dart';
import 'package:courier_app/src/features/auth/new_password/new_password_binding.dart';
import 'package:courier_app/src/features/auth/new_password/new_password_screen.dart';
import 'package:courier_app/src/features/auth/otp_email/otp_email_binding.dart';
import 'package:courier_app/src/features/auth/otp_email/otp_email_screen.dart';
import 'package:courier_app/src/features/auth/otp_mob/otp_binding.dart';
import 'package:courier_app/src/features/auth/otp_mob/otp_mobile_screen.dart';
import 'package:courier_app/src/features/auth/register/register_binding.dart';
import 'package:courier_app/src/features/auth/register/register_screen.dart';
import 'package:courier_app/src/features/auth/splash/splash_binding.dart';
import 'package:courier_app/src/features/auth/splash/splash_screen_one.dart';
import 'package:courier_app/src/features/features/add_order/add_order1_screen.dart';
import 'package:courier_app/src/features/features/add_order/add_order_binding.dart';
import 'package:courier_app/src/features/features/all_item/all_item_binding.dart';
import 'package:courier_app/src/features/features/all_item/all_item_screen.dart';
import 'package:courier_app/src/features/features/home/home_binding.dart';
import 'package:courier_app/src/features/features/home/home_controller.dart';
import 'package:courier_app/src/features/features/home/home_screen.dart';
import 'package:courier_app/src/features/features/item_details/complete_details.dart';
import 'package:courier_app/src/features/features/item_details/details_binding.dart';
import 'package:courier_app/src/features/features/profile/profile_binding.dart';
import 'package:courier_app/src/features/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/auth/splash/splash_screen.dart';
import '../../features/auth/splash/splash_screen_two.dart';
import '../../features/features/add_order/add_order2_screen.dart';
import '../../features/features/add_order/add_order3_screen.dart';
import '../../features/features/add_order/add_order4_screen.dart';
import '../../features/features/item_details/pending_details_screen.dart';
import '../../features/features/profile/edit_profile.dart';
import '../../features/features/signature_pad/signature_pad_binding.dart';
import '../../features/features/signature_pad/signature_pad_screen.dart';
import '../../features/features/signature_pad/signature_reciever_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String otpMob = '/otpmob';
  static const String forgotOtpMob = '/forgotOtpmob';
  static const String otpEmail = '/otpemail';
  static const String forgotOtpEmail = '/forgotOtpemail';
  static const String newPass = '/newpass';
  static const String forgotPass = '/forgotpass';
  static const String forgotPass2 = '/forgotpass2';
  static const String signature = '/signature';
  static const String home = '/home';
  static const String main = '/main';
  static const String addOrderOne = '/addorderone';
  static const String addOrderTwo = '/addordertwo';
  static const String addOrderThree = '/addorderthree';
  static const String addOrderFour = '/addorderfour';
  static const String completeOrders = '/completedetails';
  static const String pendingOrders = "/pendingorders";
  static const String recieverSign = "/recieversign";
  static const String allItem = "/allitem";
  static const String profile = "/profile";
  static const String editProfile = "/editprofile";
  static const String navBar = "/navbar";
  static const String splashOne = "/splashone";
  static const String splashTwo = "/splashtwo";
  static const String splash = "/splash";

  static String getLoginRoute() => login;

  static String getRegisterRoute() => register;

  static String getOtpMobRoute() => otpMob;

  static String getForgotOtpMobRoute() => forgotOtpMob;

  static String getOtpEmailRoute() => otpEmail;

  static String getForgotOtpEmailRoute() => forgotOtpEmail;

  static String getNewPasswordRoute() => newPass;

  static String getForgotPassRoute() => forgotPass;

  static String getForgotPass2Route() => forgotPass2;

  static String getSignatureRoute() => signature;

  static String getHomeRoute() => home;

  static String getMainRoute() => main;

  static String getAddOrderOneRoute() => addOrderOne;

  static String getAddOrderTwoRoute() => addOrderTwo;

  static String getAddOrderThreeRoute() => addOrderThree;

  static String getAddOrderFourRoute() => addOrderFour;

  static String getCompleteOrderRoute() => completeOrders;

  static String getPendingOrdersRoute() => pendingOrders;

  static String getRecieverSignRoute() => recieverSign;

  static String getAllItemRoute() => allItem;

  static String getProfileRoute() => profile;

  static String getEditProfileRoute() => editProfile;
  static String getNavBarRoute() => navBar;
  static String getSplashOneRoute() => splashOne;
  static String getSplashTwoRoute() => splashTwo;
  static String getSplashRoute() => splash;

  static generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return GetPageRoute(
            settings: settings,
            routeName: getLoginRoute(),
            page: () => LoginScreen());

      case register:
        return GetPageRoute(
          settings: settings,
          routeName: getRegisterRoute(),
          page: () => RegisterScreen(),
        );
      case otpMob:
        return GetPageRoute(
            settings: settings,
            routeName: getOtpMobRoute(),
            page: () => OTPMobScreen());
      case otpEmail:
        return GetPageRoute(
          settings: settings,
          routeName: getOtpEmailRoute(),
          page: () => OTPEmailScreen(),
        );
      case forgotOtpMob:
        return GetPageRoute(
          settings: settings,
          routeName: getForgotOtpMobRoute(),
          page: () => ForgotOTPMobScreen(),
        );
      case forgotOtpEmail:
        return GetPageRoute(
          settings: settings,
          routeName: getForgotOtpEmailRoute(),
          page: () => ForgotOTPEmailScreen(),
        );
      case newPass:
        return GetPageRoute(
            settings: settings,
            routeName: getNewPasswordRoute(),
            page: () => NewPasswordScreen());
      case forgotPass:
        return GetPageRoute(
          settings: settings,
          routeName: getForgotPassRoute(),
          page: () => ForgotPasswordScreen(),
        );

      case forgotPass2:
        return GetPageRoute(
          settings: settings,
          routeName: getForgotPass2Route(),
          page: () => ForgotPassword2Screen(),
        );
      case signature:
        return GetPageRoute(
          settings: settings,
          routeName: getSignatureRoute(),
          page: () => SignaturePadScreen(),
        );
      case home:
        return GetPageRoute(
            settings: settings,
            routeName: getHomeRoute(),
            page: () => HomeScreen());
      case main:
      // return GetPageRoute(settings: settings, routeName: getMainRoute(), page: () => MainScreen());
      case addOrderOne:
        return GetPageRoute(
          settings: settings,
          routeName: getAddOrderOneRoute(),
          page: () => const AddOrderOneScreen(),
        );
      case addOrderTwo:
        return GetPageRoute(
          settings: settings,
          routeName: getAddOrderTwoRoute(),
          page: () => AddOrderTwoScreen(),
        );
      case addOrderThree:
        return GetPageRoute(
          settings: settings,
          routeName: getAddOrderThreeRoute(),
          page: () => AddOrderThreeScreen(),
        );
      case addOrderFour:
        return GetPageRoute(
          settings: settings,
          routeName: getAddOrderFourRoute(),
          page: () => AddOrderFourScreen(),
        );
      // case completeOrders:
      //   return GetPageRoute(
      //     settings: settings,
      //     routeName: getCompleteOrderRoute(),
      //     page: () => CompleteOrdersScreen(),
      //   );
      // case pendingOrders:
      //   return GetPageRoute(
      //     settings: settings,
      //     routeName: getPendingOrdersRoute(),
      //     page: () => PendingDetailsScreen(),
      //   );
      // case recieverSign:
      //   return GetPageRoute(
      //     settings: settings,
      //     routeName: getRecieverSignRoute(),
      //     page: () => SignatureRecieverScreen(),
      //   );
      case allItem:
        return GetPageRoute(
          settings: settings,
          routeName: getAllItemRoute(),
          page: () => AllItemScreen(),
        );
      case profile:
        return GetPageRoute(
          settings: settings,
          routeName: getProfileRoute(),
          page: () => ProfileScreen(),
        );
      case editProfile:
        return GetPageRoute(
          settings: settings,
          routeName: getEditProfileRoute(),
          page: () => EditProfileScreen(),
        );
      case navBar:
        return GetPageRoute(
          settings: settings,
          routeName: getNavBarRoute(),
          page: () => CustomNavBar(),
        );
      case splashOne:
        return GetPageRoute(
          settings: settings,
          routeName: getSplashOneRoute(),
          page: () => SplashOneScreen(),
        );
      case splashTwo:
        return GetPageRoute(
          settings: settings,
          routeName: getSplashTwoRoute(),
          page: () => SplashTwoScreen(),
        );
      case splash:
        return GetPageRoute(
          settings: settings,
          routeName: getSplashRoute(),
          page: () => SplashScreen(),
        );
      default:
        return null;
    }
  }

  static getPages() => [
        GetPage(
          name: login,
          page: () => LoginScreen(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: register,
          page: () => RegisterScreen(),
          binding: RegisterBinding(),
        ),
        GetPage(
          name: otpMob,
          page: () => OTPMobScreen(),
          binding: OtpMobBinding(),
        ),
        GetPage(
          name: otpEmail,
          page: () => OTPEmailScreen(),
          binding: OtpEmailBinding(),
        ),
        GetPage(
          name: forgotOtpMob,
          page: () => ForgotOTPMobScreen(),
          binding: ForgotOtpMobBinding(),
        ),
        GetPage(
          name: forgotOtpEmail,
          page: () => ForgotOTPEmailScreen(),
          binding: ForgotOtpEmailBinding(),
        ),
        GetPage(
          name: newPass,
          page: () => NewPasswordScreen(),
          binding: NewPasswordBinding(),
        ),
        GetPage(
          name: forgotPass,
          page: () => ForgotPasswordScreen(),
          binding: ForgotPasswordBinding(),
        ),
        GetPage(
          name: forgotPass2,
          page: () => ForgotPassword2Screen(),
          binding: ForgotPassword2Binding(),
        ),
        GetPage(
          name: signature,
          page: () => SignaturePadScreen(),
          binding: SignaturePadBinding(),
        ),
        GetPage(
          name: home,
          page: () => HomeScreen(),
          binding: HomeBinding(),
        ),
        // GetPage(
        //   name: main,
        //   page: () => MainScreen(),
        //   binding: MainBinding(),
        // ),
        GetPage(
            name: addOrderOne,
            page: () => AddOrderOneScreen(),
            binding: AddOrderBinding()),
        GetPage(
            name: addOrderTwo,
            page: () => AddOrderTwoScreen(),
            binding: AddOrderBinding()),
        GetPage(
            name: addOrderThree,
            page: () => AddOrderThreeScreen(),
            binding: AddOrderBinding()),
        GetPage(
            name: addOrderFour,
            page: () => AddOrderFourScreen(),
            binding: AddOrderBinding()),
        // GetPage(
        //   name: completeOrders,
        //   page: () => CompleteOrdersScreen(),
        //   binding: DetailsBinding(),
        // ),
        // GetPage(
        //   name: pendingOrders,
        //   page: () => PendingDetailsScreen(),
        //   binding: DetailsBinding(),
        // ),
        // GetPage(
        //   name: recieverSign,
        //   page: () => SignatureRecieverScreen(),
        //   binding: SignaturePadBinding(),
        // ),
        GetPage(
          name: allItem,
          page: () => AllItemScreen(),
          binding: AllItemBinding(),
        ),
        GetPage(
          name: profile,
          page: () => ProfileScreen(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: editProfile,
          page: () => EditProfileScreen(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: navBar,
          page: () => CustomNavBar(),
          binding: NavBarBinding(),
        ),
        GetPage(
          name: splashOne,
          page: () => SplashOneScreen(),
          binding: SplashBinding(),
        ),
        GetPage(
          name: splashTwo,
          page: () => SplashTwoScreen(),
          binding: SplashBinding(),
        ),
        GetPage(
          name: splash,
          page: () => SplashScreen(),
          binding: SplashBinding(),
        ),
      ];
}
