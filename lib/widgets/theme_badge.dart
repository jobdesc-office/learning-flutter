import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/material.dart';

class ThemeBadge extends BsBadge {
  ThemeBadge({
    Widget? child,
    BsBadgeStyle style = BsBadgeStyle.secondary,
  }) : super(
          child: child,
          size: BsBadgeSize(
            margin: EdgeInsets.only(right: 5),
            padding: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
            fontSize: 9.0,
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          style: style,
        );
}
