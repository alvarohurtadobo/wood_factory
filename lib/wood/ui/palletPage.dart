import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/warehouse/model/city.dart';
import 'package:wood_center/wood/model/line.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/wood/model/pallet.dart';
import 'package:wood_center/wood/model/status.dart';
import 'package:wood_center/wood/model/product.dart';
import 'package:wood_center/common/components/button.dart';
import 'package:wood_center/warehouse/model/warehouse.dart';
import 'package:wood_center/common/components/rowPiece.dart';
import 'package:wood_center/common/components/customDropDown.dart';
import 'package:wood_center/common/components/doubleTextInput.dart';

class PalletPage extends StatefulWidget {
  bool creating;

  PalletPage({key, this.creating = false}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _PalletPageState();
}

class _PalletPageState extends State<PalletPage> {
  int? currentLineId;
  int? currentStatusId;
  int? currentLocationId;
  int? currentWarehouseId;
  int? currentProductId;
  bool innerProduction = false;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Sizes.padding,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                child: const Text(
                  "FILTROS",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              rowPiece(
                  const Text("Ciudad"),
                  CustomDropDown(City.getCitiesForDropDown(), currentLocationId,
                      (value) {
                    setState(() {
                      currentLocationId = value;
                    });
                  })),
              rowPiece(
                  const Text("LÍNEA"),
                  CustomDropDown(Line.getLineListForDropdown(), currentLineId,
                      (value) {
                    setState(() {
                      currentLineId = value;
                    });
                  })),
              SizedBox(
                height: Sizes.padding,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                  child: const Text("DETALLE",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              rowPiece(
                  const Text("Producto"),
                  CustomDropDown(myProducts, currentProductId, (value) {
                    setState(() {
                      currentProductId = value;
                    });
                  })),
              rowPiece(
                  const Text("Ubicación"),
                  CustomDropDown(myWarehouses, currentWarehouseId, (value) {
                    setState(() {
                      currentWarehouseId = value;
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
              rowPiece(
                  const Text("Producción propia"),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Switch(
                        value: innerProduction,
                        onChanged: (value) {
                          setState(() {
                            innerProduction = value;
                          });
                        }),
                  )),
              rowPiece(const Text("Cantidad"), DoubleTextInput((value) {
                currentPallet.amount = value.toInt();
              })),
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
