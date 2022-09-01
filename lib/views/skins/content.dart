import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presenters/navigation_presenter.dart';
import '../../styles/color_palattes.dart';
import '../../widgets/breadcrumb.dart';
import '../../widgets/button/theme_button_back.dart';

final _navigation = Get.find<NavigationPresenter>();

class ContentSkins extends StatelessWidget {
  const ContentSkins({
    Key? key,
    this.child,
    this.title,
    this.subTitle,
    this.breadcrumbs = const [],
    this.back = false,
    this.titlebg = true,
    this.background = false,
  }) : super(key: key);

  final String? title;

  final String? subTitle;

  final List<BreadcrumbWidget> breadcrumbs;

  final Widget? child;

  final bool back;

  final bool titlebg;

  final bool background;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          width: constraints.maxWidth,
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: this.titlebg
                      ? BoxDecoration(
                          color: _navigation.darkTheme.value
                              ? ColorPallates.elseDarkColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        )
                      : BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: this.back
                            ? EdgeInsets.only(left: 15, top: 10)
                            : EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  this.title == null
                                      ? Container()
                                      : Text(
                                          this.title!,
                                          style: TextStyle(
                                            fontSize: 28,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            this.breadcrumbs.length == 0
                                ? Container()
                                : Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      children:
                                          this.breadcrumbs.map((breadcrumb) {
                                        int currentIndex = this
                                            .breadcrumbs
                                            .indexOf(breadcrumb);
                                        return Row(
                                          children: [
                                            breadcrumb,
                                            currentIndex ==
                                                    this.breadcrumbs.length - 1
                                                ? Container()
                                                : Container(
                                                    padding: EdgeInsets.only(
                                                        left: 5, right: 5),
                                                    child: Icon(
                                                      Icons
                                                          .keyboard_arrow_right_outlined,
                                                      size: 12,
                                                    ),
                                                  ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      if (this.back)
                        ThemeButtonBack(
                          margin: EdgeInsets.only(right: 15, top: 5),
                        ),
                    ],
                  ),
                ),
                Scrollbar(
                  child: SingleChildScrollView(
                    child: this.background
                        ? Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: _navigation.darkTheme.value
                                  ? ColorPallates.elseDarkColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: child,
                          )
                        : Container(
                            child: child,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
