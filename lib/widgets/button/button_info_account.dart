import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../presenters/navigation_presenter.dart';
import '../../styles/color_palattes.dart';
import 'button_controller.dart';

final _navigation = Get.find<NavigationPresenter>();

final box = GetStorage();

class ButtonInfoAccount extends StatelessWidget {
  const ButtonInfoAccount(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      padding: EdgeInsets.all(5),
                      child: CircleAvatar(
                        child: Icon(
                          Icons.person,
                          size: 25,
                          color: _navigation.darkTheme.value
                              ? ColorPallates.elseDarkColor
                              : ColorPallates.navbarLightColor,
                        ),
                        backgroundColor: _navigation.darkTheme.value
                            ? ColorPallates.primary
                            : ColorPallates.primary,
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          box.read('username'),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _navigation.darkTheme.value
                                  ? ColorPallates.sidebarDarkTextColor
                                  : ColorPallates.sidebarLightTextColor),
                        ),
                      ),
                    )
                  ],
                ),
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
