import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/wood/model/kit.dart';
import 'package:wood_center/common/settings.dart';
import 'package:wood_center/user/model/user.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/wood/model/product.dart';
import 'package:wood_center/user/model/employee.dart';
import 'package:wood_center/user/model/provider.dart';
import 'package:wood_center/common/components/button.dart';
import 'package:wood_center/warehouse/model/location.dart';
import 'package:wood_center/warehouse/model/warehouse.dart';
import 'package:wood_center/common/components/rowPiece.dart';
import 'package:wood_center/common/tools/datetimeParser.dart';
import 'package:wood_center/common/components/expandedTile.dart';
import 'package:wood_center/common/components/customDropDown.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:wood_center/common/components/threeColumnRowPiece.dart';

class InventoryPage extends StatefulWidget {
  // InventoryPage({key, })
  //     : super(key: key);
  @override
  State<StatefulWidget> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
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
      appBar: myAppBar("Generar Inventario"),
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
                  child: const Text("INFORMACIÓN DE INVENTARIO",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              rowPiece(const Text("Inventario"), const Text("0001")),
              rowPiece(const Text("Fecha de apertura"),
                  Text(DateTime.now().toIso8601String().substring(0,16).replaceAll("T", "\n"), maxLines: 1,)),
              expandedTile(
                  "Encargado",
                  CustomDropDown(myEmployees, currentKit.employeeId, (value) {
                    setState(() {
                      currentKit.employeeId = value;
                    });
                  }, enabled: true)),
              SizedBox(
                height: Sizes.padding,
              ),
              rowPiece(
                  const Text("Escanear KIT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3D464C))),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      FlutterBarcodeScanner.scanBarcode(
                          '#ff6666', 'Cancel', true, ScanMode.QR);
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
              threeColumnRowPiece(
                  Text("KIT 1412"),
                  Text(
                    "ESTIBA",
                    overflow: TextOverflow.fade,
                  ),
                  Text("RPRP2004")),
              threeColumnRowPiece(
                  Text("KIT 34"),
                  Text(
                    "CUARTONES",
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                  ),
                  Text("PPTB1001")),
              SizedBox(
                height: Sizes.padding,
              ),
              CustomButton(
                  "Guardar para mas tarde",
                  const Color.fromARGB(255, 65, 62, 234),
                  () async {},
                  generating,
                  enabled: false),
              SizedBox(
                height: Sizes.padding,
              ),
              CustomButton(
                  "Generar Inventario",
                  const Color.fromARGB(255, 68, 213, 80),
                  () async {},
                  generating,
                  enabled: false)
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
