import 'package:boilerplate/constants/color_palattes.dart';
import 'package:boilerplate/presenters/navigation_presenter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SidebarSkins extends StatelessWidget {
  final NavigationPresenter _navigation = Get.find<NavigationPresenter>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () => Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 250),
              width: _navigation.isCollapse.value ? 70 : 250,
              height: 60,
              padding: EdgeInsets.fromLTRB(15, 12, 15, 12),
              decoration: BoxDecoration(
                color: ColorPallates.dark,
              ),
              child: Text(
                'Logo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 250),
                width: _navigation.isCollapse.value ? 70 : 250,
                decoration: BoxDecoration(
                  color: ColorPallates.dark,
                ),
                child: Text('Sidebar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
