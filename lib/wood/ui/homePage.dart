import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/common/settings.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/wood/bloc/kitBloc.dart';
import 'package:wood_center/user/bloc/providersBloc.dart';
import 'package:wood_center/common/components/toast.dart';
import 'package:wood_center/common/bloc/settingsBloc.dart';
import 'package:wood_center/user/model/roleManagement.dart';
import 'package:wood_center/warehouse/bloc/warehouseBloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:wood_center/wood/model/kit.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool fullyLoaded = false;

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  void initState() {
    super.initState();
    clearanceKits = [];
    getSettings().then((success) {
      updateEmployeesAndProviders().then((successo) {
        getAllWarehouses().then((value) {
          setState(() {
            fullyLoaded = success && successo;
          });
          print("Set state to $fullyLoaded");
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Sizes.initSizes(width, height);
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: MyDrawer(),
        appBar: myAppBar("Inicio"),
        body: SizedBox(
          width: Sizes.width,
          // color: const Color(0xff2E1AA4),
          child: Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: Sizes.padding,
              children: [
                GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pushNamed("/scan");
                      FlutterBarcodeScanner.scanBarcode(
                              '#ff6666', 'Cancel', true, ScanMode.QR)
                          .then((String code) {
                        print("Code is $code");
                        if (code != null && code != "" && code != "-1") {
                          int parsedCode =
                              int.tryParse(code.replaceAll("kit_", "")) ?? 0;
                          getExtendedKit(parsedCode).then((success) {
                            if (success) {
                              clearanceKits.add(currentKit);
                              setState(() {});
                            } else {
                              showToast("Código no encontrado");
                            }
                          });
                        }
                      });
                    },
                    onLongPress: () {
                      if (lastKitIdGeneratedQrForDebug == 0) {
                        return;
                      }
                      FlutterBarcodeScanner.scanBarcode(
                              '#ff6666', 'Cancel', true, ScanMode.QR)
                          .then((String code) {
                        int parsedCode = 205;
                        print("Debug code $parsedCode");
                        //int.tryParse(code.replaceAll("kit_", "")) ?? 0;
                        getExtendedKit(parsedCode).then((success) {
                          if (success) {
                            Navigator.of(context).pushNamed("/scsannedKit");
                          } else {
                            showToast("Código no encontrado");
                          }
                        });
                      });
                    },
                    child: Container(
                      width: Sizes.bigButtonSize,
                      height: Sizes.bigButtonSize,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: Sizes.padding),
                      decoration: BoxDecoration(
                          color: const Color(0xffbc171d),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.bigButtonSize / 6))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.qr_code,
                            color: Colors.white,
                            size: Sizes.bigButtonSize / 2,
                          ),
                          const Text(
                            "Escanear",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )),
                canCreateKits()
                    ? GestureDetector(
                        onTap: () {
                          if (!fullyLoaded) {
                            return;
                          }
                          Navigator.of(context).pushNamed("/createKit");
                        },
                        child: Container(
                            width: Sizes.bigButtonSize,
                            height: Sizes.bigButtonSize,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: Sizes.padding),
                            decoration: BoxDecoration(
                                color: const Color(0xff343434),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Sizes.bigButtonSize / 6))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.format_indent_increase_sharp,
                                  color: Colors.white,
                                  size: Sizes.bigButtonSize / 2,
                                ),
                                Text("Nuevo Ingreso",
                                    style: TextStyle(
                                        color: fullyLoaded
                                            ? Colors.white
                                            : Colors.grey)),
                              ],
                            )),
                      )
                    : Container(),
                homeButton(
                    routeName: '',
                    title: 'Transformar',
                    backgroundColor: const Color.fromARGB(255, 84, 210, 202),
                    myIcon: Icons.transform_outlined),
                homeButton(
                    routeName: '',
                    title: 'Ensamblar',
                    backgroundColor: const Color.fromARGB(255, 160, 91, 57),
                    myIcon: Icons.join_full),
                homeButton(
                    routeName: '/clearance',
                    title: 'Despachar',
                    backgroundColor: const Color.fromARGB(255, 93, 148, 48),
                    myIcon: Icons.outbond_outlined),
                homeButton(
                    routeName: '/inventory',
                    title: 'Toma de inventarios',
                    backgroundColor: const Color.fromARGB(255, 91, 59, 186),
                    myIcon: Icons.inventory),
              ],
            ),
          ),
        ));
  }

  Widget homeButton(
      {String routeName = '/createKit',
      String title = 'Nuevo Ingreso',
      Color backgroundColor = const Color(0xff343434),
      IconData myIcon = Icons.format_indent_increase_sharp}) {
    return GestureDetector(
      onTap: () {
        if (!fullyLoaded) {
          return;
        }
        Navigator.of(context).pushNamed(routeName);
      },
      child: Container(
          width: Sizes.bigButtonSize,
          height: Sizes.bigButtonSize,
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: Sizes.padding),
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(Sizes.bigButtonSize / 6))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                myIcon,
                color: Colors.white,
                size: Sizes.bigButtonSize / 2,
              ),
              Text(title,
                  style: TextStyle(
                      color: fullyLoaded ? Colors.white : Colors.grey)),
            ],
          )),
    );
  }
}
