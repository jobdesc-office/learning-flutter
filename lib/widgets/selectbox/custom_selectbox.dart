import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presenters/navigation_presenter.dart';
import '../../styles/color_palattes.dart';

final _navigation = Get.find<NavigationPresenter>();

class CustomSelectBox extends BsSelectBox {
  CustomSelectBox({
    required BsSelectBoxController controller,
    bool searchable = true,
    bool disabled = false,
    ValueChanged<BsSelectBoxOption>? onChange,
    String? hintText,
    List<BsSelectValidator> validators = const [],
    BsSelectBoxServerSide? serverSide,
  }) : super(
          searchable: searchable,
          disabled: disabled,
          onChange: onChange,
          controller: controller,
          hintText: hintText,
          validators: validators,
          serverSide: serverSide,
          style: BsSelectBoxStyle(
            selectedColor: _navigation.darkTheme.value
                ? ColorPallates.contentDarkColor
                : Colors.white,
            selectedTextColor:
                _navigation.darkTheme.value ? Colors.white : Colors.black,
            searchTextColor:
                _navigation.darkTheme.value ? Colors.white : Colors.black,
            searchColor: _navigation.darkTheme.value
                ? ColorPallates.contentDarkColor
                : Colors.white,
            textColor:
                _navigation.darkTheme.value ? Colors.white : Colors.black,
            backgroundColor: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : Colors.white,
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
            itemColor: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : Colors.white,
            itemTextColor:
                _navigation.darkTheme.value ? Colors.white : Colors.black,
            backgroundColor: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : Colors.white,
            border: Border.all(color: ColorPallates.dark),
            borderRadius: BorderRadius.circular(5),
          ),
        );
}
