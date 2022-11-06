import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/wood/model/pallet.dart';
import 'package:wood_center/wood/model/status.dart';
import 'package:wood_center/wood/model/product.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool exactMeasures = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: myAppBar("Búsqueda"),
      body: Column(
        children: [
          rowPiece(
              const Text("Familia"),
              DropdownButton<int>(
                  items: Product.getProductListForDropdown()
                      .map((e) => DropdownMenuItem<int>(
                            value: e.id,
                            child: Text(e.code),
                          ))
                      .toList(),
                  onChanged: (value) {})),
          rowPiece(
              const Text("Estado"),
              DropdownButton<int>(
                  items: Status.getStatusListForDropdown()
                      .map((e) => DropdownMenuItem<int>(
                            value: e.id,
                            child: Text(e.name),
                          ))
                      .toList(),
                  onChanged: (value) {})),
          const Text("UBICACIÓN"),
          rowPiece(const Text("Ciudad"), Container()),
          rowPiece(const Text("Bodega"), Container()),
          rowPiece(
              const Text("DIMENSIONES"),
              Row(
                children: [
                  const Text("Exacta"),
                  Checkbox(
                      value: exactMeasures,
                      onChanged: (value) {
                        setState(() {
                          exactMeasures = value ?? false;
                        });
                      })
                ],
              )),
              rowPiece(const Text("Largo"), DoubleTextInput((value) {
            currentPallet.height = value;
          })),
          rowPiece(const Text("Ancho"), DoubleTextInput((value) {
            currentPallet.height = value;
          })),
          rowPiece(const Text("Alto"), DoubleTextInput((value) {
            currentPallet.height = value;
          })),
          rowPiece(const Text("Cantidad"), DoubleTextInput((value) {
            currentPallet.amount = value.toInt();
          })),
        ],
      ),
    );
  }

  Widget DoubleTextInput(Function(double) updateParam) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
        hintText: "",
        contentPadding: EdgeInsets.symmetric(horizontal: Sizes.boxSeparation),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Color(0xff0077CD)),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: null,
      ),
      onChanged: (value) {
        double? parsedValue = double.tryParse(value);
        if (parsedValue != null) {
          updateParam(parsedValue);
        }
      },
      keyboardType:
          const TextInputType.numberWithOptions(signed: false, decimal: false),
    );
  }

  Widget rowPiece(Widget left, Widget right) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.padding, vertical: Sizes.boxSeparation),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [left, const Expanded(child: SizedBox()), right],
      ),
    );
  }
}
