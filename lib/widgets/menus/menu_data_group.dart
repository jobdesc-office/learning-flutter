import 'package:flutter/material.dart';

import 'menu_data.dart';

// class MenuDataGroup {
//   final String? title;
//   final List<MenuData> children;
//   final IconData? icon;

//   const MenuDataGroup({
//     this.title,
//     this.icon = Icons.folder_outlined,
//     this.children = const [],
//   });
// }

class MenuDataGroupDrill extends StatefulWidget {
  const MenuDataGroupDrill({
    Key? key,
    required this.title,
    this.icon = Icons.folder_outlined,
    this.children = const [],
  }) : super(key: key);

  final String title;
  final List<MenuData> children;
  final IconData? icon;

  @override
  State<MenuDataGroupDrill> createState() => _MenuDataGroupDrillState();
}

class _MenuDataGroupDrillState extends State<MenuDataGroupDrill> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        leading: Icon(widget.icon),
        title: Text(widget.title),
        children: widget.children.map((menuData) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(menuData.label), Icon(menuData.icon)]),
          );
        }).toList());
  }
}
