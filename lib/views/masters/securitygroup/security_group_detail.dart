import 'package:boilerplate/models/masters/security_group_model.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/masters/type_model.dart';
import '../../../presenters/masters/security_group_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/form_group.dart';
import '../../skins/template.dart';
import '_detail_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class SecurityGroupDetails extends GetView implements DetailViewContract {
  final SecurityGroupPresenter presenter = Get.find<SecurityGroupPresenter>();
  final SecurityGroupDetailsSource controller = Get.put(SecurityGroupDetailsSource());

  List<SecurityGroupModel>? parents;

  SecurityGroupDetails({this.parents}) {
    Get.delete<SecurityGroupDetailsSource>();
    presenter.securityGroupDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return TemplateView(
          title: SecurityGroupsText.title + ' Details',
          breadcrumbs: [
            BreadcrumbWidget('Security Group'),
            if (parents != null)
              for (SecurityGroupModel parent in parents!) BreadcrumbWidget(parent.sgname!),
            if (controller.name.isNotEmpty) BreadcrumbWidget(controller.name.value),
            BreadcrumbWidget('Security Group Details', active: true),
          ],
          activeRoutes: [RouteList.masterSecurityGroup.index, RouteList.masterSecurityGroup.index],
          back: true,
          child: Obx(() => BsRow(
                children: [
                  BsCol(
                      sizes: ColScreen(lg: Col.col_6),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _navigation.darkTheme.value ? ColorPallates.elseDarkColor : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: BsRow(
                          children: [
                            BsCol(
                                sizes: ColScreen(lg: Col.col_12),
                                child: FormGroup(
                                    label: Text('Name', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [Text(controller.name.value), Divider()],
                                    ))),
                            BsCol(
                                margin: EdgeInsets.only(top: 10),
                                sizes: ColScreen(lg: Col.col_12),
                                child: FormGroup(
                                    label: Text('Code', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [Text(controller.cd.value), Divider()],
                                    ))),
                            if (controller.parent.value.isNotEmpty)
                              BsCol(
                                  margin: EdgeInsets.only(top: 10),
                                  sizes: ColScreen(lg: Col.col_12),
                                  child: FormGroup(
                                      label: Text('Parent', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [Text(controller.parent.value), Divider()],
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
                          color: _navigation.darkTheme.value ? ColorPallates.elseDarkColor : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: BsRow(
                          children: [
                            BsCol(
                              child: FormGroup(
                                  label: Text('Created By', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [Text(controller.createdby.value), Divider()],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              child: FormGroup(
                                  label: Text('Created At', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [Text(controller.createddate.value), Divider()],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              child: FormGroup(
                                  label: Text('Last Updated By', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [Text(controller.updatedby.value), Divider()],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              child: FormGroup(
                                  label: Text('Last Updated At', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [Text(controller.updateddate.value), Divider()],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              child: FormGroup(
                                  label: Text('Is Active', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (controller.isactive.value)
                                        Card(
                                          color: Colors.green,
                                          child: Text('Active', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                        )
                                      else
                                        Card(
                                          color: Colors.red,
                                          child: Text('Not Active', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                        ),
                                      Divider()
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      )),
                ],
              )),
        );
      }),
    );
  }

  @override
  void onSuccessFetchData(Response response) {
    SecurityGroupModel dt = SecurityGroupModel.fromJson(response.body);
    controller.cd.value = dt.sgcode ?? '';
    controller.name.value = dt.sgname ?? '';
    controller.parent.value = parents?.last.sgname ?? '';

    controller.createdby.value = dt.usercreatedby?.userfullname ?? '';
    controller.createddate.value = dt.createddate ?? '';
    controller.updatedby.value = dt.userupdatedby?.userfullname ?? '';
    controller.updateddate.value = dt.updateddate ?? '';
    controller.isactive.value = dt.isactive ?? false;
    presenter.setProcessing(false);
  }
}
