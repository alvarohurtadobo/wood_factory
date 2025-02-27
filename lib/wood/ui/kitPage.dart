import 'package:flutter/material.dart';
import 'package:wood_center/common/components/expandedTile.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/common/tools/datetimeParser.dart';
import 'package:wood_center/user/model/user.dart';
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
import 'package:wood_center/common/components/toast.dart';
import 'package:wood_center/warehouse/model/location.dart';
import 'package:wood_center/common/components/button.dart';
import 'package:wood_center/warehouse/model/warehouse.dart';
import 'package:wood_center/user/model/roleManagement.dart';
import 'package:wood_center/common/components/rowPiece.dart';
import 'package:wood_center/common/components/customDropDown.dart';
import 'package:wood_center/common/components/doubleTextInput.dart';
import 'package:wood_center/common/ui/genericConfirmationDialog.dart';

class KitPage extends StatefulWidget {
  bool creating;
  bool fromScan;

  KitPage({key, this.creating = false, this.fromScan = false})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _KitPageState();
}

class _KitPageState extends State<KitPage> {
  int? currentWarehouseId;
  bool externalProvider = false;

  bool updatingLoading = false;
  bool deletingLoading = false;
  bool clearingLoading = false;

  bool loadingProducts = false;

  bool generating = false;

  bool problemMismatchInDropdown = false;

  bool noProductError = false;
  bool noLocationError = false;
  bool noWoodStateError = false;
  // bool noAmountError = false;

  int displaySourceId = 0;

  Kit impressKit = Kit.empty();
  Kit backupKit = Kit.empty();

  TextEditingController amountController = TextEditingController();

  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    externalProvider = currentKit.isFromExternalProvider();
    amountController.text = currentKit.amount.toString();
    backupKit = Kit.copy(currentKit);
    if (widget.creating) {
      currentKit = Kit.empty();
      if (sourceKit.id != 0) {
        displaySourceId = sourceKit.id;
        currentKit = sourceKit;
        currentKit.id = 0;
        currentKit.sourceKitId = displaySourceId;
      }
      print("Initial current kit ${sourceKit.id}, ${sourceKit.toMap()}");
    } else {
      currentCityId = null;
      currentLineId = null;
    }
    if (widget.fromScan) {
      impressKit = Kit.copy(currentKit);
    }
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
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
      appBar: myAppBar(
          widget.creating ? "Nuevo Kit" : "Editar Kit ${currentKit.id}"),
      body: SizedBox(
        height: Sizes.height,
        width: Sizes.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height:
                    displaySourceId != 0 ? Sizes.boxSeparation : Sizes.padding,
              ),
              widget.fromScan ? impressKitDisplay(impressKit) : Container(),
              (displaySourceId == 0 || !widget.creating)
                  ? Container()
                  : rowPiece(
                      Text("KIT PADRE $displaySourceId",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff3D464C))),
                      GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          genericConfirmationDialog(context,
                                  "¿Está seguro que desea desvincular este kit de su kit padre?")
                              .then((confirm) {
                            if (confirm) {
                              setState(() {
                                sourceKit = Kit.empty();
                                displaySourceId = 0;
                                currentKit.sourceKitId = null;
                              });
                            }
                          });
                        },
                        child: Container(
                            margin: EdgeInsets.only(left: Sizes.padding),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff3D464C)),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Sizes.padding))),
                            height: 5 * Sizes.tileNormal,
                            alignment: Alignment.center,
                            child: const Text("Limpiar")),
                      )),
              sourceKit.id == 0
                  ? Container()
                  : SizedBox(
                      height: Sizes.boxSeparation,
                    ),
              (widget.creating && sourceKit.id != 0)
                  ? Container()
                  : (!widget.creating)
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.padding),
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
                                CustomDropDown(Line.getLineListForDropdown(),
                                    currentLineId, (value) {
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
              expandedTile(
                  "Producto",
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
                      : CustomDropDownProduct(
                          Product.getProductListFilteredByLineIdAndCityId(
                              currentLineId, currentCityId),
                          currentKit.productId, (value) {
                          setState(() {
                            currentKit.productId = value;
                          });
                        },
                          error: noProductError,
                          enabled: widget.creating || canUpdateProduct())),
              expandedTile(
                  "Ubicación",
                  CustomDropDown(
                      Location.getLocationsFilteredByCityId(currentCityId),
                      currentKit.locationId, (value) {
                    setState(() {
                      currentKit.locationId = value;
                    });
                  },
                      error: noLocationError,
                      enabled: widget.creating || canUpdateLocation())),
              expandedTile(
                  "Estado",
                  CustomDropDown(myWoodStates, currentKit.stateId, (value) {
                    setState(() {
                      currentKit.stateId = value;
                    });
                  },
                      error: noWoodStateError,
                      enabled: widget.creating || canUpdateState())),
              rowPiece(
                  const Text("Cantidad"),
                  DoubleTextInput((value) {
                    currentKit.amount = value.toInt();
                  },
                      myFocusNode: myFocusNode,
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
                                currentKit.originalLocationId = null;
                                currentKit.employeeId = null;
                                currentKit.externalProviderId = null;
                                updateExternalParametersInCurrentKit(currentKit);
                                setState(() {
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
                  : expandedTile(
                      "Lugar de origen",
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
                  : expandedTile(
                      "Empleado",
                      CustomDropDown(myEmployees, currentKit.employeeId,
                          (value) {
                        setState(() {
                          currentKit.employeeId = value;
                        });
                      },
                          enabled: widget.creating ||
                              canUpdateOriginProviderEmployee())),
              externalProvider
                  ? expandedTile(
                      "Nombre",
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
                      print("Set demo kit to $lastKitIdGeneratedQrForDebug");
                      setState(() {
                        generating = false;
                      });
                      exportAsPdf(currentKit);
                    }, generating),
              (noProductError || noLocationError || noWoodStateError)
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Sizes.boxSeparation,
                          horizontal: Sizes.padding),
                      child: const Text(
                        "Estos campos son requeridos",
                        style: TextStyle(color: Color(0xffbc171d)),
                      ),
                    )
                  : Container(),
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
                      noProductError = currentKit.productId == null;
                      noLocationError = currentKit.locationId == null;
                      noWoodStateError = currentKit.stateId == null;

                      setState(() {});
                      if (noProductError ||
                          noLocationError ||
                          noWoodStateError) {
                        return;
                      }
                      bool amoutIsFine = true;
                      if (currentKit.amount == 0 && widget.creating) {
                        amoutIsFine = await genericConfirmationDialog(context,
                            "¿Está seguro que desea crear la etiqueta con 0 elementos?");
                      }
                      if (!amoutIsFine) {
                        return;
                      }
                      setState(() {
                        updatingLoading = true;
                      });
                      if (widget.creating) {
                        BackendResponse myRes = await Api.createKit(currentKit);
                        if (myRes.status == 201) {
                          if (myRes.myBody.containsKey("id")) {
                            currentKit.id = myRes.myBody["id"] as int;
                            backupKit = Kit.copy(currentKit);
                            sourceKit = Kit.empty();
                          } else {
                            showToast('Creación irregular');
                            Navigator.of(context).pop();
                          }
                          setState(() {
                            widget.creating = false;
                          });
                          print("Creado correctamente");
                        } else {
                          print("No se pudo crear");
                        }
                      } else {
                        if (Kit.areEqual(backupKit, currentKit)) {
                          print("No changes, returning");
                          setState(() {
                            updatingLoading = false;
                          });
                          return;
                        }
                        BackendResponse myRes =
                            await Api.updateKit(currentKit.id, currentKit);
                        if (myRes.status == 200) {
                          print("Actualizado correctamente $currentKit");
                          showToast("Kit actualizado correctamente");
                          impressKit = Kit.copy(currentKit);
                          backupKit = Kit.copy(currentKit);
                          updateExternalParametersInCurrentKit(currentKit);
                          updateExternalParametersInCurrentKit(impressKit);
                          updateExternalParametersInCurrentKit(backupKit);
                          setState(() {});
                          int index = myKits.indexWhere(
                              (element) => element.id == currentKit.id);
                          if (index != -1) {
                            myKits[index] = currentKit;
                          }
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
                      if (updatingLoading ||
                          deletingLoading ||
                          clearingLoading) {
                        return;
                      }
                      bool confirm = await genericConfirmationDialog(context,
                          "¿Está seguro que desea borrar permanentemente este kit?");
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
              widget.creating
                  ? Container()
                  : SizedBox(
                      height: Sizes.boxSeparation,
                    ),
              (!widget.creating &&
                      canDelete() &&
                      currentKit.usedDatetime == null)
                  ? CustomButton("Ensamblar", const Color(0xff4C2F12),
                      () async {
                      if (updatingLoading ||
                          deletingLoading ||
                          clearingLoading) {
                        return;
                      }
                      setState(() {
                        clearingLoading = true;
                      });
                      bool confirm = await genericConfirmationDialog(context,
                          "¿Está seguro que este kit fue utilizado en su totalidad?");
                      if (confirm) {
                        bool used = await useKit(currentKit.id);
                        amountController.text = "0";
                        if (used) {
                          showToast("Kit marcado como terminado");
                        } else {
                          showToast("Kit marcando como terminado");
                        }
                      } else {
                        genericConfirmationDialog(context,
                                "En ese caso simplemente actualice la cantidad",
                                hideYes: true, cancelLabel: "Aceptar")
                            .then((value) => myFocusNode.requestFocus());
                      }
                      setState(() {
                        clearingLoading = false;
                      });
                    }, false)
                  : Container(),
              widget.creating
                  ? Container()
                  : SizedBox(
                      height: Sizes.boxSeparation,
                    ),
              (!widget.creating &&
                      canDelete() &&
                      currentKit.transformedDatetime == null)
                  ? CustomButton("Transformar en nuevo kit", Colors.blueAccent,
                      () async {
                      if (updatingLoading ||
                          deletingLoading ||
                          clearingLoading) {
                        return;
                      }
                      setState(() {
                        clearingLoading = true;
                      });
                      bool confirm = await genericConfirmationDialog(context,
                          "¿Está seguro que quiere crear un nuevo kit a partir de este? El siguiente kit que cree será marcado como hijo del presente kit");
                      if (confirm) {
                        print("clear transform ${currentKit.id}");
                        bool success = await transformKit(currentKit.id);
                        print("success $success");
                        if (success) {
                          amountController.text = "0";
                          showToast("Kit marcado como transformado");
                          sourceKit = currentKit;
                          sourceKit.transformedDatetime = null;
                          print(
                              "Kit fuente nuevo ${sourceKit.id}, ${sourceKit.toMap()}");
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed("/createKit");
                        } else {
                          showToast("Problema marcando como transformado");
                        }
                      }
                      setState(() {
                        clearingLoading = false;
                      });
                    }, false)
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

  Widget impressKitDisplay(Kit myKit) {
    return Container(
      margin: EdgeInsets.only(
          left: Sizes.padding,
          right: Sizes.padding,
          bottom: Sizes.boxSeparation),
      padding: EdgeInsets.all(Sizes.boxSeparation),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getDatetime(myKit.createdAt),
                maxLines: 1, style: const TextStyle(fontSize: 24)),
            Text("Cantidad: ${myKit.amount}",
                maxLines: 1, style: const TextStyle(fontSize: 16)),
            Text("Bodega: ${myKit.warehouseName}",
                maxLines: 1, style: const TextStyle(fontSize: 16)),
            Text("Ubicación: ${myKit.locationName}",
                maxLines: 1, style: const TextStyle(fontSize: 16)),
            (myKit.employeeFirstName == "" && myKit.employeeLastName == "")
                ? Container()
                : Text(
                    "Operario: ${myKit.employeeFirstName} ${myKit.employeeLastName}",
                    maxLines: 1,
                    style: const TextStyle(fontSize: 16)),
            (myKit.originalLocationName == "")
                ? Container()
                : Text("Ubicación original: ${myKit.originalLocationName}",
                    maxLines: 1, style: const TextStyle(fontSize: 16)),
            (myKit.providerFirstName == "" && myKit.providerLastName == "")
                ? Container()
                : Text(
                    "Proveedor: ${myKit.providerFirstName} ${myKit.providerLastName}",
                    maxLines: 1,
                    style: const TextStyle(fontSize: 16)),
            Text(myKit.productCode,
                maxLines: 1, style: const TextStyle(fontSize: 16)),
            (myKit.productSpecies == "")
                ? Container()
                : Text("Especie: ${myKit.productSpecies}",
                    maxLines: 1, style: const TextStyle(fontSize: 16)),
            (!myKit.productIsWood)
                ? Container()
                : Text(
                    "${myKit.productLength} x ${myKit.productWidth} x ${myKit.productHeight}",
                    maxLines: 1,
                    style: const TextStyle(fontSize: 16)),
            (myKit.updatingUserFirstName != "" &&
                    myKit.updatingUserLastName != "")
                ? Text(
                    "Responsable Qr: ${myKit.updatingUserFirstName} ${myKit.updatingUserLastName}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16))
                : Container(),
          ]),
    );
  }
}

bool updateExternalParametersInCurrentKit(Kit currentKit) {
  // Ubicacion actual
  Location newLocation =
      myLocations.firstWhere((element) => element.id == currentKit.locationId);
  currentKit.locationName = newLocation.name;
  // Ubicacion original
  if (currentKit.originalLocationId != null) {
    currentKit.originalLocationName = myLocations
        .firstWhere((element) => element.id == currentKit.originalLocationId)
        .name;
  } else {
    currentKit.originalLocationName = "";
  }
  // Proveedor
  if (currentKit.externalProviderId != null) {
    currentKit.providerFirstName = myProviders
        .firstWhere((element) => element.id == currentKit.externalProviderId)
        .firstName;
    currentKit.providerLastName = myProviders
        .firstWhere((element) => element.id == currentKit.externalProviderId)
        .lastName;
  } else {
    currentKit.providerFirstName = "";
    currentKit.providerLastName = "";
  }
  // Operario
  if (currentKit.employeeId != null) {
    currentKit.employeeFirstName = myEmployees
        .firstWhere((element) => element.id == currentKit.employeeId)
        .firstName;
    currentKit.employeeLastName = myEmployees
        .firstWhere((element) => element.id == currentKit.employeeId)
        .lastName;
  } else {
    currentKit.employeeFirstName = "";
    currentKit.employeeLastName = "";
  }
  // Product
  currentKit.productCode = myProducts
      .firstWhere((element) => element.id == currentKit.productId)
      .code;
  currentKit.productHeight = myProducts
          .firstWhere((element) => element.id == currentKit.productId)
          .height ??
      0;
  currentKit.productWidth = myProducts
          .firstWhere((element) => element.id == currentKit.productId)
          .width ??
      0;
  currentKit.productLength = myProducts
          .firstWhere((element) => element.id == currentKit.productId)
          .length ??
      0;
  currentKit.productSpecies = myProducts
          .firstWhere((element) => element.id == currentKit.productId)
          .species ??
      "";
  // User
  currentKit.updatingUserFirstName = myUser.firstName;
  currentKit.updatingUserLastName = myUser.lastName;
  // Waresouse name
  currentKit.warehouseName = myWarehouses
      .firstWhere((element) => element.id == newLocation.warehouseId)
      .name;
  return true;
}
