import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/cupertino.dart';

class CustomButonSize {
  static BsButtonSize get medium => BsButtonSize(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        fontSize: 12,
        iconSize: 14,
      );

  static BsButtonSize get small => BsButtonSize(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        fontSize: 12,
        iconSize: 14,
      );

  static BsButtonSize get mini => BsButtonSize(
        padding: EdgeInsets.all(2),
        fontSize: 12,
        iconSize: 13,
      );

  static BsButtonSize get confirm => BsButtonSize(
        padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
        fontSize: 12,
        iconSize: 14,
      );
}
