import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../presenters/navigation_presenter.dart';
import '../../../../styles/color_palattes.dart';

final _navigation = Get.find<NavigationPresenter>();

class ImagePictureFiles extends GetView {
  final title;
  final image;
  ImagePictureFiles({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.lg,
          child: BsModalContent(
              decoration: BoxDecoration(
                color: _navigation.darkTheme.value
                    ? ColorPallates.elseDarkColor
                    : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              children: [
                BsModalContainer(
                  title: Text(title,
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black)),
                  closeButton: true,
                ),
                BsModalContainer(
                  child: BsRow(
                    children: [
                      BsCol(
                          sizes: ColScreen(sm: Col.col_12),
                          child: Image.network(image))
                    ],
                  ),
                )
              ]),
        ));
  }
}
