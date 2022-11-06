import 'package:flutter/material.dart';
import 'package:wood_center/common/sizes.dart';

Widget CustomButton(String label, Color color, Function() action) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: Sizes.padding),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(Sizes.radius),
        ),
        child: TextButton(
            onPressed: action,
            child: Text(
              label,
              style: TextStyle(color: Colors.white),
            )));
  }