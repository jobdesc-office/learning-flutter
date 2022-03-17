import 'package:flutter/material.dart';

class ThemeDatatablesStyles {
  static BoxDecoration searchDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(5),
  );

  static InputDecoration searchInputDecoration = InputDecoration(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(15),
    hintText: 'Search ...',
    hintStyle: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w100,
      color: Colors.grey,
    ),
    isDense: true,
  );
}
