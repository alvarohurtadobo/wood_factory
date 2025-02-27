import 'package:flutter/material.dart';
import 'package:wood_center/wood/ui/clearancePage.dart';
import 'package:wood_center/wood/ui/inventoriesPage.dart';
import 'package:wood_center/wood/ui/inventoryPage.dart';
import 'package:wood_center/wood/ui/processesPage.dart';
import 'package:wood_center/wood/ui/qrPage.dart';
import 'package:wood_center/wood/ui/kitPage.dart';
import 'package:wood_center/wood/ui/homePage.dart';
import 'package:wood_center/wood/ui/scanPage.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/user/ui/loginPage.dart';
import 'package:wood_center/wood/ui/searchPage.dart';
import 'package:wood_center/user/ui/profilePage.dart';
import 'package:wood_center/common/ui/splashPage.dart';
import 'package:wood_center/wood/ui/searchResults.dart';
import 'package:wood_center/warehouse/ui/warehousesPage.dart';
import 'package:wood_center/wood/ui/transformPage.dart';

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
      case "/createKit":
        return MaterialPageRoute(
          builder: (_) => KitPage(creating: true),
        );
      case "/clearance":
        return MaterialPageRoute(
          builder: (_) => ClearancePage(),
        );
      case "/inventory":
        return MaterialPageRoute(
          builder: (_) => InventoryPage(),
        );
      case "/inventories":
        return MaterialPageRoute(
          builder: (_) => InventoriesPage(),
        );
      case "/processes":
        return MaterialPageRoute(
          builder: (_) => ProcessesPage(),
        );
      case "/process":
        return MaterialPageRoute(
          builder: (_) => TransformPage(),
        );
      case "/updateKit":
        return MaterialPageRoute(
          builder: (_) => KitPage(creating: false),
        );
      case "/scsannedKit":
        return MaterialPageRoute(
          builder: (_) => KitPage(creating: false, fromScan: true),
        );
      case "/viewQr":
        return MaterialPageRoute(
          builder: (_) => QrPage(),
        );
      case "/search":
        return MaterialPageRoute(
          builder: (_) => SearchPage(),
        );
      case "/searchResults":
        return MaterialPageRoute(
          builder: (_) => SearchResultsPage(),
        );
      case "/profile":
        return MaterialPageRoute(
          builder: (_) => ProfilePage(),
        );
      case "/maps":
        return MaterialPageRoute(
          builder: (_) => WarehousesMapPage(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar('Error'),
        // drawer: DrawerWidget(),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
