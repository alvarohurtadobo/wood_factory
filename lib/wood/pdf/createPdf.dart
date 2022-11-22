import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wood_center/user/model/user.dart';
import 'package:wood_center/wood/model/pallet.dart';
import 'package:wood_center/common/tools/datetimeParser.dart';
import 'package:wood_center/wood/model/product.dart';

void exportAsPdf(Pallet myPallet) async {
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
                        Text(getDatetime(myPallet.createdAt)),
                        Text("Cantidad: ${myPallet.amount}"),
                        Text("Operario: ${myUser.fullName()}"),
                        Text("Ubicación: ${myPallet.locationName}"),
                        Text("Proveedor: ${myPallet.productCode}"),
                        Text(
                            "${currentProduct.length} x ${currentProduct.width} x ${currentProduct.height}"),
                      ])),
              Container(
                  decoration: BoxDecoration(border: Border.all()),
                  padding: const EdgeInsets.all(25),
                  width: 250,
                  height: 250,
                  child: BarcodeWidget(
                      height: 40,
                      width: 40,
                      data: myPallet.id.toString(),
                      barcode: Barcode.qrCode()))
            ]));
      }));
  String fileName =
      "qr_pallet_${myPallet.id}_${getDatetimeForFileName(myPallet.createdAt)}.pdf";
  Uint8List bytes = await pdf.save();
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = File("$dir/$fileName.pdf");
  await file.writeAsBytes(bytes);
  print("Open");
  await OpenFile.open(file.path);
  print("Opened");
}
