import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';

class CustomBsDataCell extends BsDataCell {
  const CustomBsDataCell(this.child,
      {Key? key,
      this.padding = const EdgeInsets.all(10.0),
      this.alignment,
      this.color = Colors.white})
      : super(child, key: key);

  final Widget child;

  final EdgeInsets padding;

  final Color color;

  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: padding,
      alignment: alignment,
      child: Row(
        children: [Expanded(child: Container(child: child))],
      ),
    );
  }
}
