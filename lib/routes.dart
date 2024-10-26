import 'package:get/get.dart';
import 'package:stock_pro/controllers/auth/login_controller.dart';
import 'package:stock_pro/controllers/auth/post_auth_controller.dart';
import 'package:stock_pro/controllers/auth/signup_controller.dart';
import 'package:stock_pro/controllers/home/manager_home_controller.dart';
import 'package:stock_pro/views/auth/login_screen.dart';
import 'package:stock_pro/views/auth/post_auth_screen.dart';
import 'package:stock_pro/views/auth/signup_screen.dart';
import 'package:stock_pro/views/home/manager_home_screen.dart';
import 'package:stock_pro/views/splash_screen.dart';

import 'controllers/splash_controller.dart';

abstract class Routes {
  Routes._();

  static const login = '/login';
  static const signUp = '/signup';
  static const main = '/';
  static const splash = '/splash';

  static const account = '/account';
  static const accountComplete = '/account/complete';
}

class AppPages {
  AppPages._();

  static const initial = Routes.main;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: BindingsBuilder.put(() => SplashController()),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      binding: BindingsBuilder.put(() => LoginController()),
    ),
    GetPage(
      name: Routes.signUp,
      page: () => const SignUpScreen(),
      binding: BindingsBuilder.put(() => SignUpController()),
    ),
    GetPage(
      name: Routes.accountComplete,
      page: () => const PostAuthScreen(),
      binding: BindingsBuilder.put(() => PostAuthController()),
    ),
    GetPage(
      name: Routes.main,
      page: () => const ManagerHomeScreen(),
      binding: BindingsBuilder.put(() => ManagerHomeController()),
    ),
  ];
}
