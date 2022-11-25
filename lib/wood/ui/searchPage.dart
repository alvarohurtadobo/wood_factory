import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/wood/model/line.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/wood/model/pallet.dart';
import 'package:wood_center/wood/model/product.dart';
import 'package:wood_center/wood/model/woodState.dart';
import 'package:wood_center/warehouse/model/city.dart';
import 'package:wood_center/common/components/button.dart';
import 'package:wood_center/warehouse/model/warehouse.dart';
import 'package:wood_center/common/components/rowPiece.dart';
import 'package:wood_center/common/components/rangeTextInput.dart';
import 'package:wood_center/common/components/customDropDown.dart';
import 'package:wood_center/common/components/doubleTextInput.dart';
import 'package:wood_center/common/components/threeColumnRowPiece.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int? currentStatusId;
  int? currentLocationId;
  int? currentProductId;
  int? currentCityId;
  int? currentWarehouseId;
  bool exactLength = false;
  bool exactWidth = false;
  bool exactHeight = false;
  int? currentLineId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: myAppBar("Búsqueda"),
      body: SizedBox(
        width: Sizes.width,
        height: Sizes.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Sizes.padding,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                child: const Text("UBICACIÓN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff3D464C))),
              ),
              rowPiece(
                  const Text("Ciudad"),
                  CustomDropDown(City.getCitiesForDropDown(), currentCityId,
                      (value) {
                    print("New city is $value");
                    setState(() {
                      currentCityId = value;
                    });
                  })),
              rowPiece(
                  const Text("Bodega"),
                  CustomDropDown(
                      (currentCityId == 0 ||
                              currentCityId == 1 ||
                              currentCityId == null)
                          ? Warehouse.getWarehousesForDropDown()
                          : [],
                      currentWarehouseId, (value) {
                    setState(() {
                      currentWarehouseId = value;
                    });
                  })),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                child: const Text("INFORMACIÓN DE PRODUCTO",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff3D464C))),
              ),
              rowPiece(
                  const Text("Línea"),
                  CustomDropDown(Line.getLineListForDropdown(), currentLineId,
                      (value) {
                    setState(() {
                      currentLineId = value;
                    });
                  })),
              rowPiece(
                  const Text("Producto"),
                  CustomDropDown(
                      Product.getProductListForDropdown(), currentProductId,
                      (value) {
                    setState(() {
                      currentProductId = value;
                    });
                  })),
              rowPiece(
                  const Text("Estado"),
                  CustomDropDown(
                      WoodState.getStatusListForDropdown(), currentStatusId,
                      (value) {
                    setState(() {
                      currentStatusId = value;
                    });
                  })),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              (currentProductId == 0 || currentProductId == null)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Sizes.padding),
                          child: const Text("DIMENSIONES",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff3D464C))),
                        ),
                        threeColumnRowPiece(
                            Container(), const Text("Exacta"), Container()),
                        threeColumnRowPiece(
                            const Text("Largo"),
                            Checkbox(
                                value: exactLength,
                                onChanged: (value) {
                                  setState(() {
                                    exactLength = value ?? false;
                                  });
                                }),
                            exactLength
                                ? DoubleTextInput((value) {
                                    currentProduct.length = value;
                                  }, hasUnits: true)
                                : DoubleRangeTextInput((val) {})),
                        threeColumnRowPiece(
                            const Text("Ancho"),
                            Checkbox(
                                value: exactWidth,
                                onChanged: (value) {
                                  setState(() {
                                    exactWidth = value ?? false;
                                  });
                                }),
                            exactWidth
                                ? DoubleTextInput((value) {
                                    currentProduct.width = value;
                                  }, hasUnits: true)
                                : DoubleRangeTextInput((val) {})),
                        threeColumnRowPiece(
                            const Text("Alto"),
                            Checkbox(
                                value: exactHeight,
                                onChanged: (value) {
                                  setState(() {
                                    exactHeight = value ?? false;
                                  });
                                }),
                            exactHeight
                                ? DoubleTextInput((value) {
                                    currentProduct.height = value;
                                  }, hasUnits: true)
                                : DoubleRangeTextInput((val) {})),
                      ],
                    )
                  : Container(),
              rowPiece(const Text("Cantidad mínima"), DoubleTextInput((value) {
                currentPallet.amount = value.toInt();
              })),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              CustomButton("Buscar", const Color(0xff3D464C), () {
                Navigator.of(context).pushNamed("/searchResults");
              }, false),
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
