// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:boilerplate/services/settings/customfield_service.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../contracts/auth/logout_view_contract.dart';
import '../../helpers/function.dart';
import '../../middleware/verifyToken.dart';
import '../../presenters/auth_presenter.dart';
import '../../presenters/navigation_presenter.dart';
import '../../routes/route_list.dart';
import '../../styles/color_palattes.dart';
import '../../utils/session_manager.dart';
import '../../widgets/button/button_controller.dart';
import '../../widgets/button/button_info_account.dart';
import '../../widgets/header_icon.dart';

class HeaderSkins extends StatelessWidget implements LogoutViewContract {
  final _navigation = Get.find<NavigationPresenter>();
  final _auth = Get.find<AuthPresenter>();

  HeaderSkins() {
    checkJwtToken();
    _auth.logoutViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final controller = Get.put(ButtonController());
    var refresh = true.obs;
    return Obx(() => Container(
          decoration: BoxDecoration(
            color: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : ColorPallates.navbarLightColor,
          ),
          height: 48,
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    HeaderIcon(
                      icon: CupertinoIcons.text_justify,
                      onPressed: () => _navigation.toggleCollapse(),
                    ),
                    HeaderIcon(
                      icon: _navigation.darkTheme.value
                          ? CupertinoIcons.moon
                          : CupertinoIcons.sun_max,
                      onPressed: () => _navigation.darkTheme.toggle(),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // HeaderIcon(
                        //   icon: Icons.notifications,
                        //   onPressed: () {},
                        //   margin: EdgeInsets.only(right: 15),
                        //   badge: Text('99+'),
                        // ),
                        BsDropdownButton(
                          toggleMenu: (_) => ButtonInfoAccount(
                            'Kholifan Alfon',
                            onPressed: () {
                              controller.btnInfoAccountIsTap.toggle();
                              _.toggle();
                            },
                          ),
                          dropdownMenuSize: BsDropdownMenuSize(minWidth: 200),
                          dropdownMenuStyle: BsDropdownMenuStyle(
                            backgroundColor: _navigation.darkTheme.value
                                ? ColorPallates.elseDarkColor
                                : ColorPallates.elseLightColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          dropdownMenu: BsDropdownMenu(
                            header: BsDropdownHeader(
                              decoration: BoxDecoration(
                                  color: _navigation.darkTheme.value
                                      ? ColorPallates.elseDarkColor
                                      : ColorPallates.elseLightColor),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (refresh.value)
                                    Text('${box.read('name')}'),
                                ],
                              ),
                            ),
                            children: [
                              BsDropdownItem(
                                style: BoxDecoration(
                                    color: _navigation.darkTheme.value
                                        ? ColorPallates.elseDarkColor
                                        : ColorPallates.elseLightColor),
                                child: Column(
                                  children: authPresenter.detailUser
                                      .map((element) => Container(
                                            margin: EdgeInsets.all(3),
                                            child: InkWell(
                                              onTap: () {
                                                refresh.value = false;
                                                box.remove('mybpid');
                                                box.remove('role');
                                                box.write(
                                                    'mybpid',
                                                    element
                                                        .businesspartner!.bpid);
                                                box.write('role',
                                                    element.usertype?.typeid);

                                                Get.defaultDialog(
                                                    barrierDismissible: false,
                                                    title: 'Caution',
                                                    middleText:
                                                        'Bp : ${element.businesspartner!.bpname} \n Role : ${element.usertype!.typename}',
                                                    onConfirm: () => html
                                                        .window.location
                                                        .reload());
                                                refresh.value = true;
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(3),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      element.businesspartner!
                                                          .bpname!,
                                                      style: TextStyle(
                                                          color: _navigation
                                                                  .darkTheme
                                                                  .value
                                                              ? Colors.white
                                                              : Colors.black),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                              BsDropdownItem(
                                style: BoxDecoration(
                                    color: _navigation.darkTheme.value
                                        ? ColorPallates.elseDarkColor
                                        : ColorPallates.elseLightColor),
                                onPressed: (() =>
                                    Get.toNamed(RouteList.profile.index)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person_outline,
                                      size: 16,
                                      // color: ColorPallates.tertiary,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Text('My Profile'),
                                    )
                                  ],
                                ),
                              ),
                              BsDropdownDivider(),
                              BsDropdownItem(
                                  style: BoxDecoration(
                                      color: _navigation.darkTheme.value
                                          ? ColorPallates.elseDarkColor
                                          : ColorPallates.elseLightColor),
                                  padding: EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.logout_outlined,
                                        size: 16,
                                        color: ColorPallates.danger,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text(
                                          'Logout',
                                          style: TextStyle(
                                              color: ColorPallates.danger),
                                        ),
                                      )
                                    ],
                                  ),
                                  onPressed: () => onClickLogout())
                            ],
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ));
  }

  void onClickLogout() {
    _auth.signOut();
  }

  @override
  void onLogoutSuccess() {
    SessionManager.destroy();
    toNameRoute(RouteList.sigin.index, pushReplace: true);
  }
}
