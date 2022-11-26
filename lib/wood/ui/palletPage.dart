import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/common/settings.dart';
import 'package:wood_center/wood/model/line.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/wood/model/pallet.dart';
import 'package:wood_center/wood/pdf/createPdf.dart';
import 'package:wood_center/wood/model/product.dart';
import 'package:wood_center/user/model/employee.dart';
import 'package:wood_center/user/model/provider.dart';
import 'package:wood_center/wood/model/woodState.dart';
import 'package:wood_center/warehouse/model/city.dart';
import 'package:wood_center/common/repository/api.dart';
import 'package:wood_center/warehouse/model/location.dart';
import 'package:wood_center/common/components/button.dart';
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
  int? currentWarehouseId;
  bool externalProvider = false;

  bool updatingLoading = false;
  bool deletingLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.creating) {
      currentKit = Pallet.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print("Locations $myLocations");
    Sizes.initSizes(width, height);
    return Scaffold(
      backgroundColor: Colors.white,
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
                  CustomDropDown(City.getCitiesForDropDown(), currentCityId,
                      (value) {
                    setState(() {
                      currentKit.locationId = null;
                      currentCityId = value;
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
                  CustomDropDown(myProducts, currentKit.productId, (value) {
                    setState(() {
                      currentKit.productId = value;
                    });
                  })),
              rowPiece(
                  const Text("Ubicación"),
                  CustomDropDown(
                      Location.getLocationsFiltered(), currentKit.locationId,
                      (value) {
                    setState(() {
                      currentKit.locationId = value;
                    });
                  })),
              rowPiece(
                  const Text("Estado"),
                  CustomDropDown(myWoodStates, currentKit.stateId, (value) {
                    setState(() {
                      currentKit.stateId = value;
                    });
                  })),
              rowPiece(const Text("Cantidad"), DoubleTextInput((value) {
                currentKit.amount = value.toInt();
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
                          myLocations, currentKit.originalLocationId,
                          (value) {
                        setState(() {
                          currentKit.originalLocationId = value;
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
                      CustomDropDown(myEmployees, currentKit.employeeId,
                          (value) {
                        setState(() {
                          currentKit.employeeId = value;
                        });
                      })),
              externalProvider
                  ? rowPiece(
                      const Text("Nombre"),
                      CustomDropDown(
                          myProviders, currentKit.externalProviderId,
                          (value) {
                        setState(() {
                          currentKit.externalProviderId = value;
                        });
                      }))
                  : Container(),
              SizedBox(
                height: Sizes.padding,
              ),
              CustomButton("Exportar QR", const Color(0xff3D464C), () {
                // Navigator.of(context).pushNamed("/viewQr");
                exportAsPdf(currentKit);
              }, false),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              CustomButton(widget.creating ? "Crear" : "Actualizar",
                  const Color(0xff13922C), () async {
                if (updatingLoading || deletingLoading) {
                  return;
                }
                setState(() {
                  updatingLoading = true;
                });
                if (widget.creating) {
                  BackendResponse myRes = await Api.createKit(currentKit);
                  if (myRes.status == 201) {
                    setState(() {
                      widget.creating = false;
                    });
                    print("Creado correctamente");
                  } else {
                    print("No se pudo crear");
                  }
                } else {
                  BackendResponse myRes =
                      await Api.updateKit(currentKit.id, currentKit);
                  if (myRes.status == 200) {
                    print("Actualizado correctamente");
                  } else {
                    print("No se pudo actualizar");
                  }
                }
                setState(() {
                  updatingLoading = false;
                });
              }, updatingLoading),
              widget.creating
                  ? Container()
                  : SizedBox(
                      height: Sizes.boxSeparation,
                    ),
              widget.creating
                  ? Container()
                  : CustomButton("Eliminar", const Color(0xffbc171d), () async {
                      if (updatingLoading || deletingLoading) {
                        return;
                      }
                      setState(() {
                        deletingLoading = true;
                      });
                      BackendResponse myRes =
                          await Api.createKit(currentKit);
                      if (myRes.status == 204) {
                        print("Borrado correctamente");
                      } else {
                        print("No se pudo borrar");
                      }
                      setState(() {
                        deletingLoading = false;
                      });
                      Navigator.of(context).pop();
                    }, deletingLoading),
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
