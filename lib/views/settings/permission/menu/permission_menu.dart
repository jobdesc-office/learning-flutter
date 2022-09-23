import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../contracts/base/index_view_contract.dart';
import '../../../../middleware/verifyToken.dart';
import '../../../../models/security/permission_model.dart';
import '../../../../models/session_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/settings/permission_presenter.dart';
import '../../../../routes/route_list.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../utils/session_manager.dart';
import '../../../../widgets/breadcrumb.dart';
import '../../../../widgets/snackbar.dart';
import '../../../skins/template.dart';
import '../_permission_source.dart';

final _navigation = Get.find<NavigationPresenter>();

class PermissionMenuView extends GetView implements IndexViewContract {
  final presenter = Get.find<PermissionPresenter>();
  final source = Get.put(PermissionSource());

  final int roleid;
  final String rolename;

  PermissionMenuView({required this.roleid, required this.rolename}) {
    presenter.permissionViewMenuContract = this;
  }

  @override
  Widget build(BuildContext context) {
    presenter.datatablesMenu(context, roleid);

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
                  child: Text('$rolename',
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
                )),
            Obx(() => Column(
                  children: source.permission.map((element) {
                    int x = 1;
                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: _navigation.darkTheme.value
                            ? ColorPallates.elseDarkColor
                            : Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: BsRow(
                        children: [
                          BsCol(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            sizes: ColScreen(sm: Col.col_4),
                            child: Text(
                              '${element.menunm}',
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            ),
                          ),
                          BsCol(
                            sizes: ColScreen(sm: Col.col_7),
                            child: BsRow(
                              height: 52,
                              children: element.features!.map((e) {
                                return BsCol(
                                  sizes: ColScreen(sm: Col.col_2),
                                  child: Column(
                                    children: [
                                      if (e.hasaccess!)
                                        Column(
                                          children: [
                                            Text(e.feattitle ?? ''),
                                            InkWell(
                                              child: Icon(
                                                Icons.toggle_on,
                                                size: 35,
                                                color: _navigation
                                                        .darkTheme.value
                                                    ? ColorPallates.onDarkMode
                                                    : ColorPallates.onLightMode,
                                              ),
                                              onTap: () async {
                                                x = 1;
                                                SessionModel session =
                                                    await SessionManager
                                                        .current();
                                                Map<String, dynamic> body = {
                                                  'hasaccess': false,
                                                  'updatedby': session.userid
                                                };
                                                presenter.update(
                                                    context, body, e.permisid!);
                                              },
                                            ),
                                          ],
                                        )
                                      else
                                        Column(
                                          children: [
                                            Text(e.feattitle ?? ''),
                                            InkWell(
                                                child: Icon(
                                                  Icons.toggle_off,
                                                  size: 35,
                                                  color: _navigation
                                                          .darkTheme.value
                                                      ? ColorPallates
                                                          .offDarkMode
                                                      : ColorPallates
                                                          .offLightMode,
                                                ),
                                                onTap: () async {
                                                  x = 1;
                                                  SessionModel session =
                                                      await SessionManager
                                                          .current();
                                                  Map<String, dynamic> body = {
                                                    'hasaccess': true,
                                                    'updatedby': session.userid
                                                  };
                                                  presenter.update(context,
                                                      body, e.permisid!);
                                                }),
                                          ],
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          if (element.children != null)
                            BsCol(
                              sizes: ColScreen(sm: Col.col_12),
                              child: Column(
                                children: element.children!.map((e) {
                                  x++;
                                  return BsRow(
                                    decoration: BoxDecoration(
                                      color: _navigation.darkTheme.value
                                          ? x % 2 == 0
                                              ? ColorPallates
                                                  .datatableDarkEvenRowColor
                                              : ColorPallates
                                                  .datatableDarkOddRowColor
                                          : x % 2 == 0
                                              ? ColorPallates
                                                  .datatableLightEvenRowColor
                                              : ColorPallates
                                                  .datatableLightOddRowColor,
                                    ),
                                    margin: EdgeInsets.only(top: 5),
                                    children: [
                                      BsCol(
                                        sizes: ColScreen(sm: Col.col_1),
                                      ),
                                      BsCol(
                                          margin: EdgeInsets.only(
                                              top: 10, left: 10),
                                          sizes: ColScreen(sm: Col.col_4),
                                          child: Text(e.menunm ?? '')),
                                      BsCol(
                                        sizes: ColScreen(sm: Col.col_7),
                                        child: BsRow(
                                          children: e.features!
                                              .map((el) => BsCol(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    sizes: ColScreen(
                                                        sm: Col.col_2),
                                                    child: Column(
                                                      children: [
                                                        Text(el.feattitle!),
                                                        if (el.hasaccess!)
                                                          InkWell(
                                                            child: Icon(
                                                              Icons.toggle_on,
                                                              size: 35,
                                                              color: _navigation
                                                                      .darkTheme
                                                                      .value
                                                                  ? ColorPallates
                                                                      .onDarkMode
                                                                  : ColorPallates
                                                                      .onLightMode,
                                                            ),
                                                            onTap: () async {
                                                              x = 1;
                                                              SessionModel
                                                                  session =
                                                                  await SessionManager
                                                                      .current();
                                                              Map<String,
                                                                      dynamic>
                                                                  body = {
                                                                'hasaccess':
                                                                    false,
                                                                'updatedby':
                                                                    session
                                                                        .userid
                                                              };
                                                              presenter.update(
                                                                  context,
                                                                  body,
                                                                  el.permisid!);
                                                            },
                                                          )
                                                        else
                                                          InkWell(
                                                              child: Icon(
                                                                Icons
                                                                    .toggle_off,
                                                                size: 35,
                                                                color: _navigation
                                                                        .darkTheme
                                                                        .value
                                                                    ? ColorPallates
                                                                        .offDarkMode
                                                                    : ColorPallates
                                                                        .offLightMode,
                                                              ),
                                                              onTap: () async {
                                                                x = 1;
                                                                SessionModel
                                                                    session =
                                                                    await SessionManager
                                                                        .current();
                                                                Map<String,
                                                                        dynamic>
                                                                    body = {
                                                                  'hasaccess':
                                                                      true,
                                                                  'updatedby':
                                                                      session
                                                                          .userid
                                                                };
                                                                presenter.update(
                                                                    context,
                                                                    body,
                                                                    el.permisid!);
                                                                presenter.update(
                                                                    context,
                                                                    body,
                                                                    element
                                                                        .features!
                                                                        .where((element) =>
                                                                            element.feattitle ==
                                                                            'Viewable')
                                                                        .first
                                                                        .permisid!);
                                                              }),
                                                      ],
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                      if (e.children != null)
                                        BsCol(
                                          sizes: ColScreen(sm: Col.col_12),
                                          child: Column(
                                            children: e.children!.map((c) {
                                              x++;
                                              return BsRow(
                                                height: 57,
                                                decoration: BoxDecoration(
                                                  color: _navigation
                                                          .darkTheme.value
                                                      ? x % 2 == 0
                                                          ? ColorPallates
                                                              .datatableDarkEvenRowColor
                                                          : ColorPallates
                                                              .datatableDarkOddRowColor
                                                      : x % 2 == 0
                                                          ? ColorPallates
                                                              .datatableLightEvenRowColor
                                                          : ColorPallates
                                                              .datatableLightOddRowColor,
                                                ),
                                                margin: EdgeInsets.only(top: 5),
                                                children: [
                                                  BsCol(
                                                    sizes: ColScreen(
                                                        sm: Col.col_2),
                                                  ),
                                                  BsCol(
                                                      margin: EdgeInsets.only(
                                                          top: 10, left: 10),
                                                      sizes: ColScreen(
                                                          sm: Col.col_3),
                                                      child:
                                                          Text(c.menunm ?? '')),
                                                  BsCol(
                                                    sizes: ColScreen(
                                                        sm: Col.col_7),
                                                    child: BsRow(
                                                      children: c.features!
                                                          .map((el) => BsCol(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: 5),
                                                                sizes: ColScreen(
                                                                    sm: Col
                                                                        .col_2),
                                                                child: Column(
                                                                  children: [
                                                                    Text(el
                                                                        .feattitle!),
                                                                    if (el
                                                                        .hasaccess!)
                                                                      InkWell(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .toggle_on,
                                                                          size:
                                                                              35,
                                                                          color: _navigation.darkTheme.value
                                                                              ? ColorPallates.onDarkMode
                                                                              : ColorPallates.onLightMode,
                                                                        ),
                                                                        onTap:
                                                                            () async {
                                                                          x = 1;
                                                                          SessionModel
                                                                              session =
                                                                              await SessionManager.current();
                                                                          Map<String, dynamic>
                                                                              body =
                                                                              {
                                                                            'hasaccess':
                                                                                false,
                                                                            'updatedby':
                                                                                session.userid
                                                                          };
                                                                          presenter.update(
                                                                              context,
                                                                              body,
                                                                              el.permisid!);
                                                                        },
                                                                      )
                                                                    else
                                                                      InkWell(
                                                                          child:
                                                                              Icon(
                                                                            Icons.toggle_off,
                                                                            size:
                                                                                35,
                                                                            color: _navigation.darkTheme.value
                                                                                ? ColorPallates.offDarkMode
                                                                                : ColorPallates.offLightMode,
                                                                          ),
                                                                          onTap:
                                                                              () async {
                                                                            x = 1;
                                                                            SessionModel
                                                                                session =
                                                                                await SessionManager.current();
                                                                            Map<String, dynamic>
                                                                                body =
                                                                                {
                                                                              'hasaccess': true,
                                                                              'updatedby': session.userid
                                                                            };
                                                                            presenter.update(
                                                                                context,
                                                                                body,
                                                                                el.permisid!);
                                                                            presenter.update(
                                                                                context,
                                                                                body,
                                                                                e.features!.where((element) => element.feattitle == 'Viewable').first.permisid!);
                                                                            presenter.update(
                                                                                context,
                                                                                body,
                                                                                element.features!.where((element) => element.feattitle == 'Viewable').first.permisid!);
                                                                          }),
                                                                  ],
                                                                ),
                                                              ))
                                                          .toList(),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        )
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                )),
          ],
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
    presenter.datatablesMenu(context!, roleid);
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
