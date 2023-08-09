import 'package:get/get.dart';

import 'package:qr_code_getx/app/modules/add_products/bindings/add_products_binding.dart';
import 'package:qr_code_getx/app/modules/add_products/views/add_products_view.dart';
import 'package:qr_code_getx/app/modules/detail_products/bindings/detail_products_binding.dart';
import 'package:qr_code_getx/app/modules/detail_products/views/detail_products_view.dart';
import 'package:qr_code_getx/app/modules/home/bindings/home_binding.dart';
import 'package:qr_code_getx/app/modules/home/views/home_view.dart';
import 'package:qr_code_getx/app/modules/login/bindings/login_binding.dart';
import 'package:qr_code_getx/app/modules/login/views/login_view.dart';
import 'package:qr_code_getx/app/modules/navigation/bindings/navigation_binding.dart';
import 'package:qr_code_getx/app/modules/navigation/views/navigation_view.dart';
import 'package:qr_code_getx/app/modules/products/bindings/products_binding.dart';
import 'package:qr_code_getx/app/modules/products/views/products_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.login;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.navigation,
      page: () => NavigationView(),
      binding: NavigationBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.addProducts,
      page: () => AddProductsView(),
      binding: AddProductsBinding(),
    ),
    GetPage(
      name: _Paths.products,
      page: () => ProductsView(),
      binding: ProductsBinding(),
    ),
    GetPage(
      name: _Paths.detailProducts,
      page: () => DetailProductsView(),
      binding: DetailProductsBinding(),
    ),
  ];
}
