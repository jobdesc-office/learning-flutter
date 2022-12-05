import 'package:boilerplate/models/masters/security_group_model.dart';
import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/index_view_contract.dart';
import '../../../presenters/auth_presenter.dart';
import '../../../presenters/masters/security_group_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../utils/handle_error_request.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/button_controller.dart';
import '../../../widgets/button/theme_button_create.dart';
import '../../../widgets/datatables/custom_datatable.dart';
import '../../../widgets/snackbar.dart';
import '../../skins/template.dart';
import '_datatable_source.dart';
import '_text.dart';

class SecurityGroupView extends StatelessWidget with IndexViewContract, HandleErrorRequest {
  final presenter = Get.find<SecurityGroupPresenter>();
  final datatable = SecurityGroupDataTableSource();

  final authPresenter = Get.find<AuthPresenter>();

  late SecurityGroupModel? parent;
  List<SecurityGroupModel> get parents => parent != null ? getParents(parent!).reversed.toList() : [];
  String get generatedRoute => parents.map((e) => e.sgcode).toList().join('/');

  bool get hasParent => parent != null;
  List<SecurityGroupModel> getParents(SecurityGroupModel sg) {
    List<SecurityGroupModel> parents = [sg];
    if (sg.parent != null) parents.addAll(getParents(sg.parent!));
    return parents;
  }

  SecurityGroupView() {
    presenter.securityGroupViewContract = this;
    parent = Get.arguments?['parent'];
  }

  @override
  Widget build(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    var permis = authPresenter.rolepermis.value;
    return Scaffold(
      body: TemplateView(
        title: SecurityGroupsText.title,
        breadcrumbs: [
          BreadcrumbWidget('Security Group', active: !hasParent),
          if (hasParent)
            for (SecurityGroupModel parent in parents) BreadcrumbWidget(parent.sgname!, active: parents.last == parent),
        ],
        background: true,
        activeRoutes: [RouteList.type.index, RouteList.masterSecurityGroup.index],
        child: Container(
          child: Column(
            children: [
              CustomDatabales(
                source: datatable,
                columns: datatable.columns,
                headerActions: [
                  if (permis
                      .where((element) => element.menunm == 'Settings')
                      .first
                      .children!
                      .where((element) => element.menunm == 'Security Group')
                      .first
                      .features!
                      .where((element) => element.featslug == 'create')
                      .first
                      .permissions!
                      .hasaccess!)
                    ThemeButtonCreate(
                      prefix: SecurityGroupsText.title,
                      onPressed: () => presenter.add(context, parent),
                    )
                ],
                serverSide: (params) {
                  if (hasParent) params['sgmasterid'] = parent!.sgid.toString();
                  return presenter.datatables(context, params);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Get.close(1);
    Snackbar().createSuccess(context!);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().deleteSuccess(context!);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    if (context != null) Navigator.pop(context);
    Snackbar().editSuccess(context!);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    final btn = Get.put(ButtonController());
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener = (typeid) => presenter.details(context, typeid, parents);
    datatable.onEditListener = (typeid) => presenter.edit(context, typeid, parent);
    if (btn.btnDeleteDisabled.value)
      datatable.onDeleteListener = (typeid, name) => presenter.delete(context, typeid, name);
    else
      datatable.onDeleteListener = (typeid, name) => Snackbar().regionDeletePermission();
    datatable.onShowChildren = (value) => Get.to(
          () => SecurityGroupView(),
          routeName: "${RouteList.masterSecurityGroup.index}/${value.sgcode}",
          arguments: {
            'parent': value,
          },
        );
  }
}
