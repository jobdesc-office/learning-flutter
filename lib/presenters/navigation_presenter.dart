import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/menus/menu_data.dart';
import '../widgets/menus/overlay_collapse_menu.dart';

class NavigationPresenter extends GetxController {
  final isCollapse = false.obs;
  final darkTheme = false.obs;

  void toggleCollapse() {
    isCollapse.value = !isCollapse.value;
    historyMenu.clear();
    dataListOfMenu.update((val) {
      dataListOfMenu.value = MenuData.empty();
    });
  }

  final isHover = false.obs;

  final menuData = MenuData(id: 0, label: '', route: '').obs;

  void hoverMenu(MenuData data, bool hover) {
    menuData.update((val) {
      menuData.value = data;
    });
    isHover.value = hover;
  }

  final dataListOfMenu = MenuData.empty().obs;
  final historyMenu = List<MenuData>.empty(growable: true).obs;

  void listOfMenu(MenuData data, {bool addToHistory = true}) {
    dataListOfMenu.update((val) {
      dataListOfMenu.value = data;
    });

    if (addToHistory) historyMenu.add(data);
  }

  void backToMenu() {
    historyMenu.remove(dataListOfMenu.value);

    dataListOfMenu.update((val) {
      if (historyMenu.length > 0) {
        dataListOfMenu.value = historyMenu.last;
      } else {
        dataListOfMenu.value = MenuData.empty();
      }
    });

    if (historyMenu.length == 0) closeOverlay();
  }

  void closeListOfMenu() {
    historyMenu.clear();
    dataListOfMenu.update((val) => dataListOfMenu.value = MenuData.empty());

    closeOverlay();
  }

  OverlayEntry? overlayCollapseMenu;

  void listOfMenuCollapse(BuildContext context, MenuData data,
      {bool addToHistory = true}) {
    if (overlayCollapseMenu == null) {
      overlayCollapseMenu = OverlayEntry(
        builder: (context) => OverlayCollapseMenu(),
      );

      Overlay.of(context)!.insert(overlayCollapseMenu!);
    }

    listOfMenu(data, addToHistory: addToHistory);
  }

  void closeOverlay() {
    if (overlayCollapseMenu != null) {
      overlayCollapseMenu!.remove();
      overlayCollapseMenu = null;
    }
  }

  void closeOverlayMenu() {
    if (historyMenu.length == 1) {
      closeOverlay();
    }

    historyMenu.clear();
  }

  final activeRoute = ''.obs;

  void to(String routeName, {bool pushReplace = false}) {
    if (historyMenu.length == 1) {
      if (overlayCollapseMenu != null) {
        overlayCollapseMenu!.remove();
        overlayCollapseMenu = null;
      }
    }

    dataListOfMenu.update((val) {
      dataListOfMenu.value = MenuData.empty();
    });

    historyMenu.clear();
    closeOverlay();

    if (pushReplace)
      Get.offAllNamed(routeName);
    else
      Get.toNamed(routeName);
  }

  void setRouteActive(String routeName) {
    activeRoute.value = routeName;
  }
}
