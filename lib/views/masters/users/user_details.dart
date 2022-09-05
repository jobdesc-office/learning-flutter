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
import '../../../widgets/form_group.dart';
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
        back: true,
        child: Obx(() => Container(
              child: BsRow(
                children: [
                  BsCol(
                      sizes: ColScreen(lg: Col.col_6),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
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
                                child: FormGroup(
                                    label: Text('Name',
                                        style: TextStyle(
                                            color: _navigation.darkTheme.value
                                                ? Colors.white
                                                : Colors.black)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(controller.name.value),
                                        Divider()
                                      ],
                                    ))),
                            BsCol(
                                margin: EdgeInsets.only(top: 5),
                                sizes: ColScreen(lg: Col.col_12),
                                child: FormGroup(
                                    label: Text('Username',
                                        style: TextStyle(
                                            color: _navigation.darkTheme.value
                                                ? Colors.white
                                                : Colors.black)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(controller.username.value),
                                        Divider()
                                      ],
                                    ))),
                            BsCol(
                                margin: EdgeInsets.only(top: 5),
                                sizes: ColScreen(lg: Col.col_12),
                                child: FormGroup(
                                    label: Text('Email',
                                        style: TextStyle(
                                            color: _navigation.darkTheme.value
                                                ? Colors.white
                                                : Colors.black)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(controller.email.value),
                                        Divider()
                                      ],
                                    ))),
                            BsCol(
                                margin: EdgeInsets.only(top: 5),
                                sizes: ColScreen(lg: Col.col_12),
                                child: FormGroup(
                                    label: Text('Phone',
                                        style: TextStyle(
                                            color: _navigation.darkTheme.value
                                                ? Colors.white
                                                : Colors.black)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(controller.phone.value),
                                        Divider()
                                      ],
                                    ))),
                            BsCol(
                                margin: EdgeInsets.only(top: 5),
                                sizes: ColScreen(lg: Col.col_12),
                                child: FormGroup(
                                    label: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Device ID',
                                            style: TextStyle(
                                                color:
                                                    _navigation.darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                        BsButton(
                                          style: BsButtonStyle.danger,
                                          label: Text('Reset'),
                                          onPressed: () {
                                            presenter.reset(
                                                context, controller.id.value);
                                          },
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(controller.deviceid.value
                                            .toString()),
                                        Divider()
                                      ],
                                    ))),
                            if (controller.role.length != 0)
                              BsCol(
                                  margin: EdgeInsets.only(top: 5),
                                  sizes: ColScreen(lg: Col.col_12),
                                  child: FormGroup(
                                      label: Text('Job : ',
                                          style: TextStyle(
                                              color: _navigation.darkTheme.value
                                                  ? Colors.white
                                                  : Colors.black)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: controller.role.length,
                                              itemBuilder: (context, index) {
                                                var role =
                                                    controller.role[index];
                                                int x = index + 1;

                                                return Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(x.toString() +
                                                        ' )  ' +
                                                        role.usertype.typename +
                                                        ' at ' +
                                                        role.businesspartner
                                                            .bpname));
                                              }),
                                          Divider()
                                        ],
                                      ))),
                          ],
                        ),
                      )),
                  BsCol(
                      margin: EdgeInsets.only(left: 10),
                      sizes: ColScreen(lg: Col.col_6),
                      child: Container(
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
                              child: FormGroup(
                                  label: Text('Created By',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.createdby.value),
                                      Divider()
                                    ],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              child: FormGroup(
                                  label: Text('Created At',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.createddate.value),
                                      Divider()
                                    ],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              child: FormGroup(
                                  label: Text('Last Updated By',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.updatedby.value),
                                      Divider()
                                    ],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              child: FormGroup(
                                  label: Text('Last Updated At',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.updateddate.value),
                                      Divider()
                                    ],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              child: FormGroup(
                                  label: Text('Activation',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (controller.isactive.value)
                                        Card(
                                          color: Colors.green,
                                          child: Text('Active',
                                              style: TextStyle(
                                                  color: _navigation
                                                          .darkTheme.value
                                                      ? Colors.white
                                                      : Colors.black)),
                                        )
                                      else
                                        Card(
                                          color: Colors.red,
                                          child: Text('Not Active',
                                              style: TextStyle(
                                                  color: _navigation
                                                          .darkTheme.value
                                                      ? Colors.white
                                                      : Colors.black)),
                                        ),
                                      Divider()
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            )),
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

    controller.createdby.value = dt.usercreatedby?.userfullname ?? '';
    controller.createddate.value = dt.createddate ?? '';
    controller.updatedby.value = dt.userupdatedby?.userfullname ?? '';
    controller.updateddate.value = dt.updateddate ?? '';
    controller.isactive.value = dt.isactive ?? false;
    if (dt.userdetails != null) {
      for (var item in dt.userdetails!) {
        role.add(item);
      }
      controller.role.value = role;
    }
    presenter.setProcessing(false);
  }
}
