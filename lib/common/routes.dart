import 'package:flutter/material.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/wood/ui/homePage.dart';
import 'package:wood_center/wood/ui/qrPage.dart';
import 'package:wood_center/wood/ui/scanPage.dart';
import 'package:wood_center/user/ui/loginPage.dart';
import 'package:wood_center/wood/ui/palletPage.dart';
import 'package:wood_center/common/ui/splashPage.dart';
import 'package:wood_center/warehouse/ui/warehousesPage.dart';
import 'package:wood_center/wood/ui/searchPage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments; // as List;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => SplashPage());
      case "/login":
        return MaterialPageRoute(builder: (_) => LoginPage());
      case "/home":
        return MaterialPageRoute(builder: (_) => HomePage());
      case "/scan":
        return MaterialPageRoute(builder: (_) => ScanPage());
      case "/createPallet":
        return MaterialPageRoute(
          builder: (_) => PalletPage(creating: true),
        );
      case "/updatePallet":
        return MaterialPageRoute(
          builder: (_) => PalletPage(creating: false),
        );
      case "/warehouses":
        return MaterialPageRoute(
          builder: (_) => WarehousesPage(),
        );
      case "/viewQr":
        return MaterialPageRoute(
          builder: (_) => QrPage(),
        );
      case "/search":
        return MaterialPageRoute(
          builder: (_) => SearchPage(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: myAppBar('Error'),
        // drawer: DrawerWidget(),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
