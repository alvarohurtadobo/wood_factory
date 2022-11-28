import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/wood/model/kit.dart';
import 'package:wood_center/common/settings.dart';
import 'package:wood_center/wood/model/line.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/wood/bloc/kitBloc.dart';
import 'package:wood_center/wood/pdf/createPdf.dart';
import 'package:wood_center/wood/model/product.dart';
import 'package:wood_center/user/model/employee.dart';
import 'package:wood_center/user/model/provider.dart';
import 'package:wood_center/wood/model/woodState.dart';
import 'package:wood_center/warehouse/model/city.dart';
import 'package:wood_center/common/repository/api.dart';
import 'package:wood_center/wood/bloc/productBloc.dart';
import 'package:wood_center/warehouse/model/location.dart';
import 'package:wood_center/common/components/button.dart';
import 'package:wood_center/user/model/roleManagement.dart';
import 'package:wood_center/common/components/rowPiece.dart';
import 'package:wood_center/common/components/customDropDown.dart';
import 'package:wood_center/common/components/doubleTextInput.dart';

class KitPage extends StatefulWidget {
  bool creating;

  KitPage({key, this.creating = false}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _KitPageState();
}

class _KitPageState extends State<KitPage> {
  int? currentWarehouseId;
  bool externalProvider = false;

  bool updatingLoading = false;
  bool deletingLoading = false;

  bool loadingProducts = false;

  bool generating = false;

  bool problemMismatchInDropdown = false;

  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    externalProvider = currentKit.isFromExternalProvider();
    amountController.text = currentKit.amount.toString();
    if (widget.creating) {
      currentKit = Kit.empty();
    } else {
      currentCityId = null;
      currentLineId = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Sizes.initSizes(width, height);
    print("Display kit is ${currentKit.describe()}");
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
              (!widget.creating)
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Sizes.padding),
                          child: const Text(
                            "FILTROS",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        rowPiece(
                            const Text("Ciudad"),
                            CustomDropDown(
                                City.getCitiesForDropDown(), currentCityId,
                                (value) async {
                              setState(() {
                                loadingProducts = true;
                                // My value is set and the values of the dropdowns that rely on me are clear
                                currentCityId = value;
                                currentKit.productId = null;
                                currentKit.locationId = null;
                              });
                              bool success =
                                  await getProductsForCityAndUpdateAllLocalProducts(
                                      currentCityId);
                              if (!success) {
                                print("Unable to load products");
                              }
                              setState(() {
                                loadingProducts = false;
                              });
                            })),
                        rowPiece(
                            const Text("Línea"),
                            CustomDropDown(
                                Line.getLineListForDropdown(), currentLineId,
                                (value) {
                              setState(() {
                                currentKit.productId = null;
                                currentLineId = value;
                              });
                            })),
                        SizedBox(
                          height: Sizes.padding,
                        ),
                      ],
                    ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                  child: const Text("INFORMACIÓN DEL KIT",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              rowPiece(
                  const Text("Producto"),
                  loadingProducts
                      ? Center(
                          child: SizedBox(
                            height: Sizes.boxSeparation,
                            width: Sizes.boxSeparation,
                            child: const CircularProgressIndicator(
                              color: Color(0xffbc171d),
                            ),
                          ),
                        )
                      : CustomDropDown(
                          Product.getProductListFilteredByLineIdAndCityId(
                              currentLineId, currentCityId),
                          currentKit.productId, (value) {
                          setState(() {
                            currentKit.productId = value;
                          });
                        }, enabled: widget.creating || canUpdateProduct())),
              rowPiece(
                  const Text("Ubicación"),
                  CustomDropDown(
                      Location.getLocationsFilteredByCityId(currentCityId),
                      currentKit.locationId, (value) {
                    setState(() {
                      currentKit.locationId = value;
                    });
                  }, enabled: widget.creating || canUpdateLocation())),
              rowPiece(
                  const Text("Estado"),
                  CustomDropDown(myWoodStates, currentKit.stateId, (value) {
                    setState(() {
                      currentKit.stateId = value;
                    });
                  }, enabled: widget.creating || canUpdateState())),
              rowPiece(
                  const Text("Cantidad"),
                  DoubleTextInput((value) {
                    currentKit.amount = value.toInt();
                  },
                      controller: amountController,
                      enabled: widget.creating || canUpdateAmoun())),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              rowPiece(
                  const Text("Proveedor externo"),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Switch(
                        value: externalProvider,
                        activeColor: const Color(0xffbc171d),
                        onChanged: (widget.creating || canUpdateProduct())
                            ? (value) {
                                setState(() {
                                  if (widget.creating) {
                                    currentKit.originalLocationId = null;
                                    currentKit.employeeId = null;
                                    currentKit.externalProviderId = null;
                                  }
                                  externalProvider = value;
                                });
                              }
                            : null),
                  )),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              externalProvider
                  ? Container()
                  : rowPiece(
                      const Text("Lugar de origen"),
                      CustomDropDown(myLocations, currentKit.originalLocationId,
                          (value) {
                        setState(() {
                          currentKit.originalLocationId = value;
                        });
                      },
                          enabled: widget.creating ||
                              canUpdateOriginProviderEmployee())),
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
                      },
                          enabled: widget.creating ||
                              canUpdateOriginProviderEmployee())),
              externalProvider
                  ? rowPiece(
                      const Text("Nombre"),
                      CustomDropDown(myProviders, currentKit.externalProviderId,
                          (value) {
                        setState(() {
                          currentKit.externalProviderId = value;
                        });
                      },
                          enabled: widget.creating ||
                              canUpdateOriginProviderEmployee()))
                  : Container(),
              SizedBox(
                height: Sizes.padding,
              ),
              (widget.creating)
                  ? Container()
                  : CustomButton("Exportar QR", const Color(0xff3D464C),
                      () async {
                      if (generating) {
                        return;
                      }
                      setState(() {
                        generating = true;
                      });
                      await getExtendedKit(currentKit.id);
                      lastKitIdGeneratedQrForDebug = currentKit.id;
                      setState(() {
                        generating = false;
                      });
                      exportAsPdf(currentKit);
                    }, generating),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              (!widget.creating && !canUpdateAnything())
                  ? Container()
                  : CustomButton(widget.creating ? "Crear" : "Actualizar",
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
              (!widget.creating && canDelete())
                  ? CustomButton("Eliminar", const Color(0xffbc171d), () async {
                      if (updatingLoading || deletingLoading) {
                        return;
                      }
                      setState(() {
                        deletingLoading = true;
                      });
                      BackendResponse myRes =
                          await Api.deleteKit(currentKit.id);
                      if (myRes.status == 204) {
                        deletedKitId = currentKit.id;
                        print("Borrado correctamente");
                      } else {
                        print("No se pudo borrar");
                      }
                      setState(() {
                        deletingLoading = false;
                      });
                      Navigator.of(context).pop();
                    }, deletingLoading)
                  : Container(),
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
