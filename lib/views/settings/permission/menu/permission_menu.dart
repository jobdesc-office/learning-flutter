import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../contracts/base/index_view_contract.dart';
import '../../../../middleware/verifyToken.dart';
import '../../../../models/security/permission_model.dart';
import '../../../../models/session_model.dart';
import '../../../../presenters/auth_presenter.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/settings/permission_presenter.dart';
import '../../../../routes/route_list.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../utils/session_manager.dart';
import '../../../../widgets/breadcrumb.dart';
import '../../../../widgets/snackbar.dart';
import '../../../skins/template.dart';
import '../_permission_source.dart';

part 'part/_tabWeb.dart';
part 'part/_tabApps.dart';

final _navigation = Get.find<NavigationPresenter>();
final presenter = Get.find<PermissionPresenter>();
final source = Get.put(PermissionSource());
final authPresenter = Get.find<AuthPresenter>();
// ignore: invalid_use_of_protected_member
var permis = authPresenter.rolepermis.value;

class PermissionMenuView extends StatefulWidget {
  final int roleid;
  final String rolename;

  PermissionMenuView({required this.roleid, required this.rolename});

  @override
  State<PermissionMenuView> createState() => _PermissionMenuViewState();
}

class _PermissionMenuViewState extends State<PermissionMenuView>
    with TickerProviderStateMixin
    implements IndexViewContract {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    presenter.datatablesMenu(context, widget.roleid);
    presenter.permissionViewMenuContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Permissions',
        breadcrumbs: [
          BreadcrumbWidget('Settings'),
          BreadcrumbWidget('Permissions', active: true),
        ],
        activeRoutes: [
          RouteList.master.index,
          RouteList.settingsPermission.index
        ],
        background: true,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: _navigation.darkTheme.value
                          ? ColorPallates.elseDarkColor
                          : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Text('${widget.rolename}',
                        style: TextStyle(
                            fontSize: 27, fontWeight: FontWeight.bold)),
                  )),
              BsRow(
                children: [
                  BsCol(
                    sizes: ColScreen(sm: Col.col_2),
                    child: Container(
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Colors.green,
                        unselectedLabelColor: _navigation.darkTheme.value
                            ? Colors.white
                            : Colors.black,
                        tabs: [
                          Tab(text: 'Apps'),
                          Tab(text: 'Web'),
                        ],
                      ),
                    ),
                  ),
                  BsCol(
                    sizes: ColScreen(sm: Col.col_12),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _AppsMenuPermission(),
                          _WebMenuPermission(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    if (context != null) Navigator.pop(context);
    Snackbar().createSuccess(context!);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    if (context != null) Navigator.pop(context);
    Snackbar().deleteSuccess(context!);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    presenter.datatablesMenu(context!, widget.roleid);
    checkJwtToken();
  }

  @override
  void onErrorRequest(Response response) {
    presenter.setProcessing(false);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    presenter.setProcessing(false);
    List<PermissionModel> menu = [];
    for (var item in response.body) {
      menu.add(PermissionModel.fromJson(item));
    }
    source.permission.value = menu;
  }
}
