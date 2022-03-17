import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';

import '../../styles/color_palattes.dart';

class CustomSelectBox extends BsSelectBox {
  CustomSelectBox({
    required BsSelectBoxController controller,
    bool searchable = true,
    bool disabled = false,
    String? hintText,
    List<BsSelectValidator> validators = const [],
    BsSelectBoxServerSide? serverSide,
  }) : super(
          searchable: searchable,
          disabled: disabled,
          controller: controller,
          hintText: hintText,
          validators: validators,
          serverSide: serverSide,
          style: BsSelectBoxStyle(
            backgroundColor: Colors.white,
            border: Border.all(color: ColorPallates.dark),
            borderRadius: BorderRadius.circular(5),
            focusedBorder: Border.all(color: ColorPallates.dark),
            focusedBoxShadow: [
              BoxShadow(
                color: ColorPallates.dark.withOpacity(.5),
                offset: Offset(0, 0),
                spreadRadius: 2.5,
              )
            ],
          ),
          size: BsSelectBoxSize(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          ),
          dialogStyle: BsDialogBoxStyle(
            backgroundColor: Colors.white,
            border: Border.all(color: ColorPallates.dark),
            borderRadius: BorderRadius.circular(5),
          ),
        );
}
