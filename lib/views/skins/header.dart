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
                              child: Text(box.read('name')),
                            ),
                            children: [
                              BsDropdownItem(
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
                              // BsDropdownItem(
                              //   child: Row(
                              //     children: [
                              //       Icon(
                              //         Icons.key_outlined,
                              //         size: 16,
                              //       ),
                              //       Container(
                              //         margin: EdgeInsets.only(left: 5),
                              //         child: Text('Change Password'),
                              //       )
                              //     ],
                              //   ),
                              // ),
                              BsDropdownDivider(),
                              BsDropdownItem(
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
