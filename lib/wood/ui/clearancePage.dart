import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/wood/model/kit.dart';
import 'package:wood_center/user/model/user.dart';
import 'package:wood_center/common/settings.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/user/model/client.dart';
import 'package:wood_center/wood/bloc/kitBloc.dart';
import 'package:wood_center/wood/model/product.dart';
import 'package:wood_center/user/model/employee.dart';
import 'package:wood_center/user/model/provider.dart';
import 'package:wood_center/common/components/toast.dart';
import 'package:wood_center/common/components/button.dart';
import 'package:wood_center/warehouse/model/location.dart';
import 'package:wood_center/warehouse/model/warehouse.dart';
import 'package:wood_center/common/components/rowPiece.dart';
import 'package:wood_center/common/tools/datetimeParser.dart';
import 'package:wood_center/common/components/customDropDown.dart';
import 'package:wood_center/common/components/doubleTextInput.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:wood_center/common/components/threeColumnRowPiece.dart';

class ClearancePage extends StatefulWidget {
  // ClearancePage({key, })
  //     : super(key: key);
  @override
  State<StatefulWidget> createState() => _ClearancePageState();
}

class _ClearancePageState extends State<ClearancePage> {
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
    clearanceKits = [];
    myFocusNode = FocusNode();
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
      appBar: myAppBar("Despacho de carga"),
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
              sourceKit.id == 0
                  ? Container()
                  : SizedBox(
                      height: Sizes.boxSeparation,
                    ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                  child: const Text("INFORMACIÓN DE DESPACHO",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              rowPiece(
                  const Text("Documento de Remisión (RE)"),
                  DoubleTextInput((value) {
                    currentKit.amount = value.toInt();
                  },
                      myFocusNode: myFocusNode,
                      controller: amountController,
                      enabled: false)),
              rowPiece(
                  const Text("Cliente"),
                  CustomDropDown(myClients, myClient.id, (value) {
                    setState(() {
                      myClient = myClients.firstWhere(
                          (element) => element.id == value, orElse: () {
                        return Client.empty();
                      });
                    });
                  })),
              myClient.id == 0
                  ? const SizedBox.shrink()
                  : clientDisplayWidget(),
              rowPiece(
                  const Text("KITS despachados",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3D464C))),
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
                    child: Container(
                        margin: EdgeInsets.only(left: Sizes.padding),
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff3D464C)),
                            borderRadius: BorderRadius.all(
                                Radius.circular(Sizes.padding))),
                        height: 5 * Sizes.tileNormal,
                        alignment: Alignment.center,
                        child: const Text("Agregar")),
                  )),
              SizedBox(
                  height: Sizes.height / 3.6,
                  width: Sizes.width,
                  child: ListView(
                    children: [
                      for (Kit aKit in clearanceKits)
                        threeColumnRowPiece(
                            Text("KIT ${aKit.id}", maxLines: 1),
                            Text(
                              aKit.productName,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                            ),
                            Text(
                              aKit.amount.toString(),
                              maxLines: 1,
                            )),
                    ],
                  )),
              CustomButton("Despachar", const Color.fromARGB(255, 68, 213, 80),
                  () async {}, generating,
                  enabled: false)
            ],
          ),
        ),
      ),
    );
  }

  clientDisplayWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rowPiece(const Text("Cliente:"), const SizedBox.shrink(), flat: true),
        rowPiece(const Text("Representante:"),
            Text(myClient.getRepresentativeName()),
            flat: true),
        rowPiece(const Text("NIT:"), Text(myClient.nit), flat: true),
        rowPiece(const Text("Vehículo:"), Text(myClient.plate), flat: true),
      ],
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
