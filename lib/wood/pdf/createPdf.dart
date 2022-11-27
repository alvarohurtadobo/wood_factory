import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:wood_center/wood/model/kit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wood_center/user/model/user.dart';
import 'package:wood_center/wood/model/product.dart';
import 'package:wood_center/common/tools/datetimeParser.dart';

void exportAsPdf(Kit myKit) async {
  currentProduct = myProducts.elementAt(2);
  print("Generating PDF");
  final pdf = Document(author: "Central Maderas", compress: true);
  pdf.addPage(Page(
      pageFormat: PdfPageFormat.undefined,
      build: (context) {
        return Container(
            margin: const EdgeInsets.all(25),
            width: 500,
            child: Row(children: [
              Container(
                  decoration: BoxDecoration(border: Border.all()),
                  padding: const EdgeInsets.all(25),
                  width: 250,
                  height: 250,
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
                        (myKit.employeeFirstName == "" &&
                                myKit.employeeLastName == "")
                            ? Container()
                            : Text(
                                "Operario: ${myKit.employeeFirstName} ${myKit.employeeLastName}",
                                maxLines: 1,
                                style: const TextStyle(fontSize: 16)),
                        (myKit.originalLocationName == "")
                            ? Container()
                            : Text(
                                "Ubicación original: ${myKit.originalLocationName}",
                                maxLines: 1,
                                style: const TextStyle(fontSize: 16)),
                        (myKit.providerFirstName == "" &&
                                myKit.providerLastName == "")
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
                                maxLines: 1,
                                style: const TextStyle(fontSize: 16)),
                        (!myKit.productIsWood)
                            ? Container()
                            : Text(
                                "${myKit.productLength} x ${myKit.productWidth} x ${myKit.productHeight}",
                                maxLines: 1,
                                style: const TextStyle(fontSize: 16)),
                      ])),
              Container(
                  decoration: BoxDecoration(border: Border.all()),
                  padding: const EdgeInsets.all(25),
                  width: 250,
                  height: 250,
                  child: BarcodeWidget(
                      height: 40,
                      width: 40,
                      data: "kit_${myKit.id.toString().padLeft(8, '0')}",
                      barcode: Barcode.qrCode()))
            ]));
      }));
  String fileName =
      "qr_kit_${myKit.id}_${getDatetimeForFileName(myKit.createdAt)}.pdf";
  Uint8List bytes = await pdf.save();
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = File("$dir/$fileName.pdf");
  await file.writeAsBytes(bytes);
  print("Open");
  await OpenFile.open(file.path);
  print("Opened");
}
