import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/masters/user_model.dart';
import '../../../presenters/masters/user_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_back.dart';
import '../../skins/template.dart';
import '_details_source.dart';

final _navigation = Get.find<NavigationPresenter>();

class UserDetails extends GetView implements DetailViewContract {
  final UserPresenter presenter = Get.find<UserPresenter>();
  final UserDetailsSource controller = Get.put(UserDetailsSource());

  UserDetails() {
    Get.delete<UserDetailsSource>();
    presenter.userFetchDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'User Form',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Users', back: true),
          BreadcrumbWidget('User Form', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.masterUser.index],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ThemeButtonBack(
              onPressed: () => Navigator.pop(context),
              margin: EdgeInsets.only(bottom: 5),
            ),
            Obx(() => Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _navigation.darkTheme.value
                        ? ColorPallates.elseDarkColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: BsRow(
                    children: [
                      BsCol(
                          sizes: ColScreen(lg: Col.col_12),
                          child: BsRow(
                            children: [
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_3),
                                  child: Text('Name')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_1),
                                  child: Text(':')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_8),
                                  child: Text(controller.name.value))
                            ],
                          )),
                      BsCol(
                          margin: EdgeInsets.only(top: 5),
                          sizes: ColScreen(lg: Col.col_12),
                          child: BsRow(
                            children: [
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_3),
                                  child: Text('Username')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_1),
                                  child: Text(':')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_8),
                                  child: Text(controller.username.value))
                            ],
                          )),
                      BsCol(
                          margin: EdgeInsets.only(top: 5),
                          sizes: ColScreen(lg: Col.col_12),
                          child: BsRow(
                            children: [
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_3),
                                  child: Text('Email')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_1),
                                  child: Text(':')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_8),
                                  child: Text(controller.email.value))
                            ],
                          )),
                      BsCol(
                          margin: EdgeInsets.only(top: 5),
                          sizes: ColScreen(lg: Col.col_12),
                          child: BsRow(
                            children: [
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_3),
                                  child: Text('Phone')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_1),
                                  child: Text(':')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_8),
                                  child: Text(controller.phone.value))
                            ],
                          )),
                      BsCol(
                          margin: EdgeInsets.only(top: 5),
                          sizes: ColScreen(lg: Col.col_12),
                          child: BsRow(
                            children: [
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_3),
                                  child: Text('Device ID')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_1),
                                  child: Text(':')),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_6),
                                  child: Text(
                                      controller.deviceid.value.toString())),
                              BsCol(
                                  sizes: ColScreen(lg: Col.col_2),
                                  child: BsButton(
                                    style: BsButtonStyle.danger,
                                    label: Text('Reset'),
                                    onPressed: () {
                                      presenter.reset(
                                          context, controller.id.value);
                                    },
                                  )),
                              if (controller.role.length != 0)
                                BsCol(
                                    margin: EdgeInsets.only(top: 5),
                                    sizes: ColScreen(lg: Col.col_12),
                                    child: BsRow(
                                      children: [
                                        BsCol(
                                            sizes: ColScreen(lg: Col.col_12),
                                            child: Text('Job :')),
                                        BsCol(
                                            sizes: ColScreen(lg: Col.col_12),
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount:
                                                    controller.role.length,
                                                itemBuilder: (context, index) {
                                                  var role =
                                                      controller.role[index];
                                                  int x = index + 1;

                                                  return Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(x.toString() +
                                                          ' )  ' +
                                                          role.usertype
                                                              .typename +
                                                          ' at ' +
                                                          role.businesspartner
                                                              .bpname));
                                                })),
                                      ],
                                    )),
                            ],
                          )),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  @override
  void onSuccessFetchData(Response response) {
    var role = [];
    UserModel dt = UserModel.fromJson(response.body);
    controller.id.value = dt.userid!;
    controller.name.value = dt.userfullname ?? '-';
    controller.username.value = dt.username ?? '-';
    controller.email.value = dt.useremail ?? '-';
    controller.phone.value = dt.userphone ?? '-';
    controller.deviceid.value = dt.userdeviceid ?? '';
    controller.active.value = dt.isactive!;
    if (dt.userdetails != null) {
      for (var item in dt.userdetails!) {
        role.add(item);
      }
      controller.role.value = role;
    }
    presenter.setProcessing(false);
  }
}
