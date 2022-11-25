import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/common/components/button.dart';

class QrPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: myAppBar("Código Qr"),
      body: Column(children: [
        Expanded(
            child: Center(
                // child: QrImage(
                //   data: currentPallet.id.toString() + "12345678ALVARO",
                //   version: QrVersions.auto,
                //   size: Sizes.initialLogoSide,
                // ),
                )),
        CustomButton("Volver", const Color(0xff3D464C), () {
          Navigator.of(context).pop();
        }, false),
        SizedBox(
          height: 3 * Sizes.boxSeparation,
        ),
      ]),
    );
  }
}
