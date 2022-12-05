// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';

Future<bool> genericConfirmationDialog(BuildContext context, String finalLabel,
    {bool hideYes = false, String cancelLabel = 'Cancelar'}) async {
  double dialogWidth = Sizes.width * 0.8;
  double dialogHeight = dialogWidth * 1.4;

  return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: const EdgeInsets.all(0),
              content: Container(
                  height: dialogHeight,
                  width: dialogWidth,
                  padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(dialogHeight * 0.03)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Sizes.padding,
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              width: 1.6 * Sizes.padding,
                              height: 1.6 * Sizes.padding,
                              decoration: BoxDecoration(
                                  color: const Color(0xff3D464C),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.8 * Sizes.padding))),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: Sizes.boxSeparation,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: dialogWidth * 0.1),
                        child: Text(
                          finalLabel,
                          style: TextStyle(
                              color: const Color(0xff343434),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                              fontSize: Sizes.font08),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: Sizes.boxSeparation,
                      ),
                      hideYes
                          ? Container()
                          : Container(
                              height: Sizes.height * 0.08,
                              width: dialogWidth - 2 * Sizes.padding,
                              decoration: BoxDecoration(
                                  color: const Color(0xffbc171d),
                                  border: Border.all(
                                      color: const Color(0xffbc171d)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Sizes.height * 0.2 / 8))),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: const Text("Si",
                                    style: TextStyle(color: Colors.white)),
                              )),
                      SizedBox(
                        height: Sizes.boxSeparation,
                      ),
                      Container(
                          height: Sizes.height * 0.08,
                          width: dialogWidth - 2 * Sizes.padding,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: const Color(0xff3D464C)),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Sizes.height * 0.2 / 8))),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text(cancelLabel,
                                style:
                                    const TextStyle(color: Color(0xff3D464C))),
                          )),
                      SizedBox(
                        height: 2 * Sizes.boxSeparation,
                      ),
                    ],
                  )),
            );
          }) ==
      true;
}
