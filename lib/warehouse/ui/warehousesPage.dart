import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';
import 'package:wood_center/common/ui/appbar.dart';
import 'package:wood_center/common/ui/drawer.dart';
import 'package:wood_center/warehouse/model/city.dart';
import 'package:wood_center/common/repository/api.dart';
import 'package:wood_center/warehouse/model/warehouse.dart';
import 'package:wood_center/warehouse/bloc/warehouseBloc.dart';
import 'package:wood_center/common/components/customDropDown.dart';

class WarehousesMapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WarehousesMapPageState();
}

class _WarehousesMapPageState extends State<WarehousesMapPage> {
  int? currentWarehouseId;
  bool loading = true;
  Warehouse? currentWarehouse;

  @override
  void initState() {
    super.initState();
    currentWarehouse = myWarehouses.firstWhere(
      (thisWarehouse) => thisWarehouse.cityId == myCity.id,
    );
    currentWarehouseId = currentWarehouse!.id;
    getAllWarehouses().then((success) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String currentMapUrl = "";
    if (currentWarehouseId != null && currentWarehouseId != 0) {
      currentMapUrl = currentWarehouse!.mapUrl;
    }
    print("Show ${serverUrl + currentMapUrl}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar("Mapa  de bodega"),
      drawer: MyDrawer(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
        height: Sizes.height,
        width: Sizes.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: Sizes.padding,
            ),
            const Text("Seleccionar la bodega:"),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            loading
                ? Center(
                    child: SizedBox(
                      height: Sizes.boxSeparation,
                      width: Sizes.boxSeparation,
                      child: const CircularProgressIndicator(
                        color: Color(0xffbc171d),
                      ),
                    ),
                  )
                : Center(
                    child: CustomDropDown(myWarehouses, currentWarehouseId,
                        (value) {
                      setState(() {
                        currentWarehouseId = value;
                        currentWarehouse = myWarehouses.firstWhere(
                            (element) => element.id == currentWarehouseId);
                      });
                    }, isExpanded: true),
                  ),
            SizedBox(
              height: Sizes.boxSeparation,
            ),
            currentMapUrl == ""
                ? const Expanded(
                    child: Center(
                      child: Text("No hay para para esta bodega"),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                    width: Sizes.width - 2 * Sizes.padding,
                    height: Sizes.width - 2 * Sizes.padding,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(serverUrl + currentMapUrl))),
                  )
          ],
        ),
      ),
    );
  }
}
