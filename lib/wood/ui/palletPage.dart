import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/wood/model/line.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/wood/model/pallet.dart';
import 'package:wood_center/wood/model/status.dart';
import 'package:wood_center/wood/pdf/createPdf.dart';
import 'package:wood_center/wood/model/product.dart';
import 'package:wood_center/user/model/employee.dart';
import 'package:wood_center/user/model/provider.dart';
import 'package:wood_center/warehouse/model/city.dart';
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
  int? currentWarehouseId;
  bool externalProvider = false;
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
      appBar: myAppBar(widget.creating ? "Nuevo Kit" : "Editar Kit"),
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
                  CustomDropDown(
                      City.getCitiesForDropDown(), currentPallet.locationId,
                      (value) {
                    setState(() {
                      currentPallet.locationId = value;
                    });
                  })),
              rowPiece(
                  const Text("Familia"),
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
                  CustomDropDown(myProducts, currentPallet.productId, (value) {
                    setState(() {
                      currentPallet.productId = value;
                    });
                  })),
              rowPiece(
                  const Text("Ubicación"),
                  CustomDropDown(myWarehouses, currentPallet.locationId,
                      (value) {
                    setState(() {
                      currentPallet.locationId = value;
                    });
                  })),
              rowPiece(
                  const Text("Estado"),
                  CustomDropDown(myStatus, currentPallet.stateId, (value) {
                    setState(() {
                      currentPallet.stateId = value;
                    });
                  })),
              rowPiece(const Text("Cantidad"), DoubleTextInput((value) {
                currentPallet.amount = value.toInt();
              })),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              rowPiece(
                  const Text("Proveedor externo"),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Switch(
                        value: externalProvider,
                        onChanged: (value) {
                          setState(() {
                            externalProvider = value;
                          });
                        }),
                  )),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              externalProvider
                  ? Container()
                  : rowPiece(
                      const Text("Lugar de origen"),
                      CustomDropDown(
                          myWarehouses, currentPallet.originalLocationId,
                          (value) {
                        setState(() {
                          currentPallet.originalLocationId = value;
                        });
                      })),
              externalProvider
                  ? Container()
                  : SizedBox(
                      height: Sizes.boxSeparation,
                    ),
              externalProvider
                  ? Container()
                  : rowPiece(
                      const Text("Empleado"),
                      CustomDropDown(myEmployees, currentPallet.employeeId,
                          (value) {
                        setState(() {
                          currentPallet.employeeId = value;
                        });
                      })),
              externalProvider
                  ? rowPiece(
                      const Text("Nombre"),
                      CustomDropDown(
                          myProviders, currentPallet.externalProviderId,
                          (value) {
                        setState(() {
                          currentPallet.externalProviderId = value;
                        });
                      }))
                  : Container(),
              CustomButton("Exportar QR", const Color(0xff3D464C), () {
                // Navigator.of(context).pushNamed("/viewQr");
                exportAsPdf(currentPallet);
              }),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              CustomButton(widget.creating ? "Crear" : "Actualizar",
                  const Color(0xff13922C), () {
                Navigator.of(context).pop();
              }),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              CustomButton("Eliminar", const Color(0xffbc171d), () {
                Navigator.of(context).pop();
              }),
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
