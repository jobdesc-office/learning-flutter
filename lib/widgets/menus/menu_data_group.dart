import 'package:flutter/material.dart';

import 'menu_data.dart';

class MenuDataGroup {
  final String? title;
  final List<MenuData> children;
  final IconData? icon;

  const MenuDataGroup({
    this.title,
    this.icon = Icons.folder_outlined,
    this.children = const [],
  });
}
