import 'package:get/get.dart';
import 'package:stock_pro/controllers/auth/login_controller.dart';
import 'package:stock_pro/controllers/auth/post_auth_controller.dart';
import 'package:stock_pro/controllers/auth/signup_controller.dart';
import 'package:stock_pro/controllers/help/help_controller.dart';
import 'package:stock_pro/controllers/home/owner_home_controller.dart';
import 'package:stock_pro/controllers/items/add_item_controller.dart';
import 'package:stock_pro/controllers/items/items_controller.dart';
import 'package:stock_pro/controllers/notifications/notifications_controller.dart';
import 'package:stock_pro/controllers/operations/add_operation_controller.dart';
import 'package:stock_pro/controllers/operations/operations_controller.dart';
import 'package:stock_pro/controllers/reports/reports_controller.dart';
import 'package:stock_pro/controllers/reports/stock_reports_controller.dart';
import 'package:stock_pro/controllers/settings/settings_controller.dart';
import 'package:stock_pro/controllers/shops/shops_controller.dart';
import 'package:stock_pro/views/auth/login_view.dart';
import 'package:stock_pro/views/auth/post_auth_view.dart';
import 'package:stock_pro/views/auth/signup_view.dart';
import 'package:stock_pro/views/help/help_view.dart';
import 'package:stock_pro/views/home/owner_home_view.dart';
import 'package:stock_pro/views/items/add_item_view.dart';
import 'package:stock_pro/views/items/items_view.dart';
import 'package:stock_pro/views/notifications/notifications_view.dart';
import 'package:stock_pro/views/operations/add_operation_view.dart';
import 'package:stock_pro/views/operations/operations_view.dart';
import 'package:stock_pro/views/reports/reports_view.dart';
import 'package:stock_pro/views/reports/stock_reports_view.dart';
import 'package:stock_pro/views/settings/settings_view.dart';
import 'package:stock_pro/views/shops/shops_view.dart';
import 'package:stock_pro/views/splash_view.dart';

import 'controllers/splash_controller.dart';

abstract class Routes {
  Routes._();

  static const login = '/login';
  static const signUp = '/signup';
  static const main = '/';
  static const splash = '/splash';

  static const items = '/items';
  static const addItem = '$items/add';

  static const operations = '/operations';
  static const addOperation = '$operations/add';

  static const notifications = '/notifications';

  static const account = '/account';
  static const accountComplete = '/account/complete';

  static const shops = '/shops';
  static const singleShop = '$shops/:id';

  static const reports = '/reports';
  static const stockReports = '$reports/stock';

  static const help = '/help';

  static const settings = '/settings';
}

class AppPages {
  AppPages._();

  static const initial = Routes.main;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: BindingsBuilder.put(() => SplashController()),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: BindingsBuilder.put(() => LoginController()),
    ),
    GetPage(
      name: Routes.signUp,
      page: () => const SignUpView(),
      binding: BindingsBuilder.put(() => SignUpController()),
    ),
    GetPage(
      name: Routes.accountComplete,
      page: () => const PostAuthView(),
      binding: BindingsBuilder.put(() => PostAuthController()),
    ),
    GetPage(
      name: Routes.main,
      page: () => const OwnerHomeView(),
      binding: BindingsBuilder.put(() => OwnerHomeController()),
    ),
    GetPage(
      name: Routes.items,
      page: () => const ItemsView(),
      binding: BindingsBuilder.put(() => ItemsController()),
      children: [
        GetPage(
          name: Routes.addItem.replaceFirst(Routes.items, ''),
          page: () => const AddItemView(),
          binding: BindingsBuilder.put(() => AddItemController()),
        ),
      ],
    ),
    GetPage(
      name: Routes.operations,
      page: () => const OperationsView(),
      binding: BindingsBuilder.put(() => OperationsController()),
      children: [
        GetPage(
          name: Routes.addOperation.replaceFirst(Routes.operations, ''),
          page: () => const AddOperationView(),
          binding: BindingsBuilder.put(() => AddOperationController()),
        ),
      ],
    ),
    GetPage(
      name: Routes.notifications,
      page: () => const NotificationsView(),
      binding: BindingsBuilder.put(() => NotificationsController()),
    ),
    GetPage(
      name: Routes.shops,
      page: () => const ShopsView(),
      binding: BindingsBuilder.put(() => ShopsController()),
    ),
    GetPage(
      name: Routes.reports,
      page: () => const ReportsView(),
      binding: BindingsBuilder.put(() => ReportsController()),
      children: [
        GetPage(
          name: Routes.stockReports.replaceFirst(Routes.reports, ''),
          page: () => const StockReportsView(),
          binding: BindingsBuilder.put(() => StockReportsController()),
        ),
      ],
    ),
    GetPage(
      name: Routes.help,
      page: () => const HelpView(),
      binding: BindingsBuilder.put(() => HelpController()),
    ),
    GetPage(
      name: Routes.settings,
      page: () => const SettingsView(),
      binding: BindingsBuilder.put(() => SettingsController()),
    ),
  ];
}
