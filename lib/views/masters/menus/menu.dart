import 'package:boilerplate/constants/custom_button_size.dart';
import 'package:boilerplate/constants/custom_button_styles.dart';
import 'package:boilerplate/routes/route_list.dart';
import 'package:boilerplate/widgets/custom_datatable.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presenters/masters/menu_presenter.dart';
import '../../../widgets/breadcrumb.dart';
import '../../skins/tempalte.dart';

class MenuView extends StatelessWidget {
  final _presenter = Get.put(MenuPresenter());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Menus',
        breadcrumbs: [
          BreadcrumbWidget('Dashboard', route: RouteList.home.index),
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Menus', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.masterMenu.index],
        child: Container(
          child: Column(
            children: [
              CustomDatabales(
                source: _presenter.source.value.datatable,
                columns: _presenter.source.value.datatable.columns,
                customizeRightHeader: (el) {
                  return Row(
                    children: [
                      BsButton(
                        margin: EdgeInsets.only(right: 5),
                        style: CustomButtonStyle.roundedPrimary,
                        size: CustomButonSize.small,
                        label: Text("Add Product"),
                        prefixIcon: Icons.add_circle_rounded,
                        onPressed: () => _presenter.add(context),
                      ),
                      el.searchForm(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        inputDecoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(15),
                          hintText: 'Search ...',
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w100,
                            color: Colors.grey,
                          ),
                          isDense: true,
                        ),
                        builderLabel: null,
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
