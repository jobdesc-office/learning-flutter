import 'package:boilerplate/constants/color_palattes.dart';
import 'package:boilerplate/presenters/navigation_presenter.dart';
import 'package:boilerplate/views/widgets/header_icon.dart';
import 'package:boilerplate/views/widgets/button_info_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderSkins extends StatelessWidget {
  final NavigationPresenter _navigation = Get.find<NavigationPresenter>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                HeaderIcon(
                  icon: CupertinoIcons.text_justify,
                  onPress: () => _navigation.toggleCollapse(),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                HeaderIcon(
                  icon: Icons.notifications,
                  onPress: () {},
                  margin: EdgeInsets.only(right: 15),
                ),
                ButtonInfoAccount('Kholifan Alfon'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
