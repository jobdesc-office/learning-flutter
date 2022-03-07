import 'package:boilerplate/presenters/navigation_presenter.dart';
import 'package:boilerplate/views/skins/content.dart';
import 'package:boilerplate/views/skins/header.dart';
import 'package:boilerplate/views/skins/sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TemplateView extends StatelessWidget {
  final NavigationPresenter _navigation = Get.put(NavigationPresenter());

  TemplateView({
    Key? key,
    this.child,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xfff1f1f1),
        ),
        child: Row(
          children: [
            SidebarSkins(),
            Expanded(
              child: Column(
                children: [
                  HeaderSkins(),
                  Expanded(
                    child: ContentSkins(
                      title: this.title,
                      child: this.child,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  final Widget? child;

  final String? title;
}
