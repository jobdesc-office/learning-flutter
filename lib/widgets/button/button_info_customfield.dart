import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../presenters/navigation_presenter.dart';
import '../../styles/color_palattes.dart';
import 'button_controller.dart';

final _navigation = Get.find<NavigationPresenter>();

final box = GetStorage();

class ButtonCustomField extends StatelessWidget {
  const ButtonCustomField(
    this.text, {
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final String text;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    // final _navigation = Get.find<NavigationPresenter>();
    final controller = Get.put(ButtonController());
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: ColorPallates.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text('Add CustomField',
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ),
              // Container(
              //   padding: EdgeInsets.all(5),
              //   child: Icon(
              //     Icons.settings,
              //     color: Colors.white,
              //   ),
              // ),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: Obx(() => Icon(
                      controller.btnInfoAccountIsTap.value
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right,
                      size: 16,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ),
        onTap: this.onPressed,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );
  }
}
