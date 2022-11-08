import 'package:flutter/material.dart';
import 'package:wood_center/common/components/button.dart';
import 'package:wood_center/common/components/customDropDown.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/warehouse/model/warehouse.dart';
import 'package:wood_center/wood/model/pallet.dart';
import 'package:wood_center/wood/model/product.dart';
import 'package:wood_center/wood/model/status.dart';

import '../../common/components/doubleTextInput.dart';
import '../../common/components/rowPiece.dart';

class PalletPage extends StatefulWidget {
  bool creating;

  PalletPage({key, this.creating = false}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _PalletPageState();
}

class _PalletPageState extends State<PalletPage> {
  int? currentStatusId;
  int? currentLocationId;
  int? currentProductId;
  @override
  void initState() {
    super.initState();
    if (widget.creating) {
      currentPallet = Pallet.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Sizes.initSizes(width, height);
    return Scaffold(
      drawer: MyDrawer(),
      appBar: myAppBar(widget.creating ? "Nueva Paleta" : "Editar Paleta"),
      body: SizedBox(
        height: Sizes.height,
        width: Sizes.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Sizes.padding,
              ),
              rowPiece(
                  const Text("Producto"),
                  CustomDropDown(myProducts, currentProductId, (value) {
                    setState(() {
                      currentProductId = value;
                    });
                  })),
              rowPiece(
                  const Text("Ubicación"),
                  CustomDropDown(myWarehouses, currentLocationId, (value) {
                    setState(() {
                      currentLocationId = value;
                    });
                  })),
              rowPiece(
                  const Text("Estado"),
                  CustomDropDown(myStatus, currentStatusId, (value) {
                    setState(() {
                      currentStatusId = value;
                    });
                  })),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              rowPiece(
                  const Text("Largo"),
                  DoubleTextInput((value) {
                    currentPallet.length = value;
                  }, hasUnits: true)),
              rowPiece(
                  const Text("Ancho"),
                  DoubleTextInput((value) {
                    currentPallet.width = value;
                  }, hasUnits: true)),
              rowPiece(
                  const Text("Alto"),
                  DoubleTextInput((value) {
                    currentPallet.height = value;
                  }, hasUnits: true)),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              rowPiece(const Text("Cantidad"), DoubleTextInput((value) {
                currentPallet.amount = value.toInt();
              })),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              CustomButton("Generar QR", const Color(0xff4C2F12), () {
                Navigator.of(context).pushNamed("/viewQr");
              }),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              CustomButton(widget.creating ? "Crear" : "Actualizar",
                  const Color(0xff13922C), () {}),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              CustomButton("Eliminar", const Color(0xffbc171d), () {}),
              SizedBox(
                height: 3 * Sizes.boxSeparation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
