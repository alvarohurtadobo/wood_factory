import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';

Widget CustomButton(String label, Color color, Function() action, bool loading,
    {bool enabled = true, bool disablePadding = false}) {
  return Container(
      margin:
          EdgeInsets.symmetric(horizontal: disablePadding ? 0 : Sizes.padding),
      width: double.infinity,
      height: Sizes.tileNormal,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Sizes.radius),
      ),
      child: loading
          ? Container(
              alignment: Alignment.center,
              height: Sizes.padding,
              width: Sizes.padding,
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : TextButton(
              onPressed: action,
              child: Text(
                label,
                style: TextStyle(color: enabled ? Colors.white : Colors.grey),
              )));
}
