import 'package:flutter/material.dart';
import 'package:wood_center/common/components/button.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/warehouse/model/warehouse.dart';
import 'package:wood_center/wood/model/pallet.dart';
import 'package:wood_center/wood/model/product.dart';
import 'package:wood_center/wood/model/status.dart';

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

  

  Widget CustomDropDown(
      List<dynamic> myList, int? myValue, Function(int?) updateValue) {
    return Container(
      width: 0.32 * Sizes.width,
      height: Sizes.tileNormal,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xff343434)))),
      child: DropdownButton<int>(
          isExpanded: true,
          value: myValue,
          underline: Container(),
          items: myList
              .map((e) => DropdownMenuItem<int>(
                    value: e.id,
                    child: SizedBox(
                        height: Sizes.tileNormal, child: Text(e.getName())),
                  ))
              .toList(),
          onChanged: updateValue),
    );
  }

  Widget DoubleTextInput(Function(double) updateParam,
      {bool hasUnits = false}) {
    return Container(
      width: 0.32 * Sizes.width,
      height: Sizes.tileNormal,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xff343434)))),
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          hintText: "",
          contentPadding: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(width: 1, color: Color(0xff343434)),
          //   borderRadius: BorderRadius.circular(8),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(width: 1, color: Color(0xff0077CD)),
          //   borderRadius: BorderRadius.circular(8),
          // ),
          suffix: hasUnits ? const Text("cm") : null,
          disabledBorder: null,
        ),
        onChanged: (value) {
          double? parsedValue = double.tryParse(value);
          if (parsedValue != null) {
            updateParam(parsedValue);
          }
        },
        keyboardType: const TextInputType.numberWithOptions(
            signed: false, decimal: false),
      ),
    );
  }

  Widget rowPiece(Widget left, Widget right) {
    return Container(
      width: Sizes.width,
      height: Sizes.tileNormal,
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.padding, vertical: Sizes.boxSeparation),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [left, const Expanded(child: SizedBox()), right],
      ),
    );
  }
}
