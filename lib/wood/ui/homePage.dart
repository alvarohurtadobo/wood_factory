import 'package:flutter/material.dart';
import 'package:wood_center/common/bloc/settingsBloc.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
    getSettings().then((success) {
      setState(() {
        fullyLoaded = success;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Sizes.initSizes(width, height);
    return Scaffold(
        drawer: MyDrawer(),
        appBar: myAppBar("Inicio"),
        body: Container(
          width: Sizes.width,
          // color: const Color(0xff2E1AA4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    // Navigator.of(context).pushNamed("/scan");
                    FlutterBarcodeScanner.scanBarcode(
                            '#ff6666', 'Cancel', true, ScanMode.QR)
                        .then((String code) {
                      print("Code is $code");
                      if (code != null && code != "" && code != "-1") {
                        Navigator.of(context).pushNamed("/updatePallet");
                      }
                    });
                  },
                  child: Container(
                    width: Sizes.bigButtonSize,
                    height: Sizes.bigButtonSize,
                    alignment: Alignment.center,
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
              GestureDetector(
                onTap: () {
                  if(!fullyLoaded){
                    return;
                  }
                  Navigator.of(context).pushNamed("/createPallet");
                },
                child: Container(
                    width: Sizes.bigButtonSize,
                    height: Sizes.bigButtonSize,
                    alignment: Alignment.center,
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
                            style: TextStyle(color:fullyLoaded? Colors.white:Colors.grey)),
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
