import 'package:flutter/material.dart';
import 'package:wood_center/common/components/expandedTile.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/wood/bloc/productBloc.dart';
import 'package:wood_center/wood/model/kit.dart';
import 'package:wood_center/wood/model/line.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/wood/model/product.dart';
import 'package:wood_center/wood/model/woodState.dart';
import 'package:wood_center/warehouse/model/city.dart';
import 'package:wood_center/common/repository/api.dart';
import 'package:wood_center/common/components/button.dart';
import 'package:wood_center/warehouse/model/location.dart';
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
  bool exactLength = false;
  bool exactWidth = false;
  bool exactHeight = false;
  int? currentLineId;

  bool currentProductIdWood = true;

  bool loading = false;
  int amountMin = 0;

  bool loadingProducts = false;

  TextEditingController lengthController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  TextEditingController lengthMinController = TextEditingController();
  TextEditingController widthMinController = TextEditingController();
  TextEditingController heightMinController = TextEditingController();

  TextEditingController lengthMaxController = TextEditingController();
  TextEditingController widthMaxController = TextEditingController();
  TextEditingController heightMaxController = TextEditingController();

  Map<String, dynamic> filters = {};

  @override
  Widget build(BuildContext context) {
    final mi = myProducts
        .map<int>(
          (e) => e.id,
        )
        .toList();
    print("Products with filter $mi");
    return Scaffold(
      backgroundColor: Colors.white,
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
                      (value) async {
                    setState(() {
                      loadingProducts = true;
                      // My value is set and the values of the dropdowns that rely on me are clear
                      currentCityId = value;
                      currentLocationId = null;
                      currentProductId = null;
                    });
                    filters.remove("location_id");
                    filters.remove("product_id");
                    if (currentCityId != 0 && currentCityId != null) {
                      filters["city_id"] = currentCityId;
                    } else {
                      filters.remove("city_id");
                    }
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
                  const Text("Ubicación"),
                  CustomDropDown(
                      Location.getLocationsForDropDownFilteredByCityId(
                          currentCityId),
                      currentLocationId, (value) {
                    setState(() {
                      currentLocationId = value;
                    });
                    if (currentLocationId != 0 && currentLocationId != null) {
                      filters["location_id"] = currentLocationId;
                    } else {
                      filters.remove("location_id");
                    }
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
                      currentProductId = null;
                      currentLineId = value;
                    });
                    filters.remove("product_id");
                  })),
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
                      : CustomDropDown(
                          Product
                              .getProductListForDropdownFilteredByLineIdAndCityId(
                                  currentLineId, currentCityId),
                          currentProductId, (value) {
                          currentProductId = value;
                          if (currentProductId == 0 ||
                              currentProductId == null) {
                            // If no product selected we show the filter for dimensions
                            currentProductIdWood = true;
                          } else {
                            // If one is selected we show dimensions filter only if it is wood
                            currentProductIdWood = myProducts
                                .firstWhere(
                                    (element) => element.id == currentProductId)
                                .isWood;
                          }
                          setState(() {});
                          if (currentProductId != null &&
                              currentProductId != 0) {
                            filters["product_id"] = currentProductId;
                          } else {
                            filters.remove("product_id");
                          }
                        })),
              rowPiece(
                  const Text("Estado"),
                  CustomDropDown(
                      WoodState.getStatusListForDropdown(), currentStatusId,
                      (value) {
                    setState(() {
                      currentStatusId = value;
                    });
                    if (currentStatusId != null && currentStatusId != 0) {
                      filters["state_id"] = currentStatusId;
                    } else {
                      filters.remove("state_id");
                    }
                  })),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              rowPiece(const Text("Cantidad mínima"), DoubleTextInput((value) {
                amountMin = value.toInt();
                if (amountMin > 0) {
                  filters["amount_min"] = amountMin;
                } else {
                  filters.remove("amount_min");
                }
              })),
              SizedBox(
                height: Sizes.boxSeparation,
              ),
              currentProductIdWood
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        rowPiece(
                            const Text("DIMENSIONES",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff3D464C))),
                            GestureDetector(
                              onTap: () {
                                lengthController.clear();
                                widthController.clear();
                                heightController.clear();
                                lengthMinController.clear();
                                widthMinController.clear();
                                heightMinController.clear();
                                lengthMaxController.clear();
                                widthMaxController.clear();
                                heightMaxController.clear();
                                setState(() {
                                  exactHeight = false;
                                  exactLength = false;
                                  exactWidth = false;
                                });

                                filters.remove("length");
                                filters.remove("length_min");
                                filters.remove("length_max");

                                filters.remove("width");
                                filters.remove("width_min");
                                filters.remove("width_max");

                                filters.remove("height");
                                filters.remove("height_min");
                                filters.remove("height_max");

                                FocusScope.of(context).unfocus();
                              },
                              child: Container(
                                  margin: EdgeInsets.only(left: Sizes.padding),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xff3D464C)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Sizes.padding))),
                                  height: 5 * Sizes.tileNormal,
                                  alignment: Alignment.center,
                                  child: const Text("Limpiar")),
                            )),
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
                                  // Whenever the user updates this value the filter and text fields are reset
                                  filters.remove("length");
                                  filters.remove("length_min");
                                  filters.remove("length_max");
                                  lengthController.clear();
                                  lengthMinController.clear();
                                  lengthMaxController.clear();
                                }),
                            exactLength
                                ? DoubleTextInput((value) {
                                    if (value > 0) {
                                      filters["length"] = value;
                                    } else {
                                      filters.remove("length");
                                    }
                                  },
                                    hasUnits: true,
                                    controller: lengthController)
                                : DoubleRangeTextInput((val) {
                                    if (val > 0) {
                                      filters["length_min"] = val;
                                    } else {
                                      filters.remove("length_min");
                                    }
                                  }, (val) {
                                    if (val > 0) {
                                      filters["length_max"] = val;
                                    } else {
                                      filters.remove("length_max");
                                    }
                                  },
                                    controllerLeft: lengthMinController,
                                    controllerRight: lengthMaxController)),
                        threeColumnRowPiece(
                            const Text("Ancho"),
                            Checkbox(
                                value: exactWidth,
                                onChanged: (value) {
                                  setState(() {
                                    exactWidth = value ?? false;
                                  });
                                  filters.remove("width");
                                  filters.remove("width_min");
                                  filters.remove("width_max");
                                  widthController.clear();
                                  widthMinController.clear();
                                  widthMaxController.clear();
                                }),
                            exactWidth
                                ? DoubleTextInput((value) {
                                    if (value > 0) {
                                      filters["width"] = value;
                                    } else {
                                      filters.remove("width");
                                    }
                                  },
                                    hasUnits: true, controller: widthController)
                                : DoubleRangeTextInput((val) {
                                    if (val > 0) {
                                      filters["width_min"] = val;
                                    } else {
                                      filters.remove("width_min");
                                    }
                                  }, (val) {
                                    if (val > 0) {
                                      filters["width_max"] = val;
                                    } else {
                                      filters.remove("width_max");
                                    }
                                  },
                                    controllerLeft: widthMinController,
                                    controllerRight: widthMaxController)),
                        threeColumnRowPiece(
                            const Text("Alto"),
                            Checkbox(
                                value: exactHeight,
                                onChanged: (value) {
                                  setState(() {
                                    exactHeight = value ?? false;
                                  });
                                  filters.remove("height");
                                  filters.remove("height_min");
                                  filters.remove("height_max");
                                  heightController.clear();
                                  heightMinController.clear();
                                  heightMaxController.clear();
                                }),
                            exactHeight
                                ? DoubleTextInput((val) {
                                    if (val > 0) {
                                      filters["height"] = val;
                                    } else {
                                      filters.remove("height");
                                    }
                                  },
                                    hasUnits: true,
                                    controller: heightController)
                                : DoubleRangeTextInput((val) {
                                    if (val > 0) {
                                      filters["height_min"] = val;
                                    } else {
                                      filters.remove("height_min");
                                    }
                                  }, (val) {
                                    if (val > 0) {
                                      filters["height_max"] = val;
                                    } else {
                                      filters.remove("height_max");
                                    }
                                  },
                                    controllerLeft: heightMinController,
                                    controllerRight: heightMaxController)),
                      ],
                    )
                  : Container(),
              SizedBox(
                height: Sizes.padding,
              ),
              CustomButton("Buscar", const Color(0xff3D464C), () async {
                if (loading) {
                  return;
                }
                setState(() {
                  loading = true;
                });
                print("filters are $filters");
                BackendResponse myRes = await Api.searchKits(filters);
                setState(() {
                  loading = false;
                });
                if (myRes.status != 200) {
                  return;
                }
                if (myRes.myBody.containsKey("kits")) {
                  myKits = myRes.myBody["kits"]
                      .map<Kit>((kitRes) => Kit.fromBackendResponse(kitRes))
                      .toList();
                  // if(myKits.length==0){
                  //   return;
                  // }
                }
                Navigator.of(context).pushNamed("/searchResults");
              }, loading),
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
