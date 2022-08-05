import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../presenters/navigation_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../_detail_source.dart';

final _navigation = Get.find<NavigationPresenter>();

class ChoosedPopup extends GetView {
  final source = Get.find<ProspectDetailsSource>();
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
                    : Color(0xfff1f1f1),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              children: [
                BsModalContainer(
                  title: Text('Choosed Files',
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black)),
                  closeButton: true,
                ),
                BsModalContainer(
                    child: Obx(() => BsRow(
                          margin: EdgeInsets.only(top: 10),
                          children: source.pickedFile.map((e) {
                            if (source.pickedFile.length == 1) {
                              return BsCol(
                                margin: EdgeInsets.all(3),
                                sizes: ColScreen(sm: Col.col_12),
                                child: Tooltip(
                                  message: 'Tap to Remove',
                                  child: InkWell(
                                    onTap: () => source.pickedFile
                                        .removeWhere((element) => element == e),
                                    child: Image.memory(
                                      e,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(
                                          FontAwesomeIcons.filePdf,
                                          size: 150,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            } else if (source.pickedFile.length == 3) {
                              return BsCol(
                                margin: EdgeInsets.all(3),
                                sizes: ColScreen(sm: Col.col_4),
                                child: Tooltip(
                                  message: 'Tap to Remove',
                                  child: InkWell(
                                    onTap: () => source.pickedFile
                                        .removeWhere((element) => element == e),
                                    child: Image.memory(
                                      e,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(
                                          FontAwesomeIcons.filePdf,
                                          size: 150,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            } else if (source.pickedFile.length == 2) {
                              return BsCol(
                                margin: EdgeInsets.all(3),
                                sizes: ColScreen(sm: Col.col_6),
                                child: Tooltip(
                                  message: 'Tap to Remove',
                                  child: InkWell(
                                    onTap: () => source.pickedFile
                                        .removeWhere((element) => element == e),
                                    child: Image.memory(
                                      e,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(
                                          FontAwesomeIcons.filePdf,
                                          size: 150,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return BsCol(
                                margin: EdgeInsets.all(3),
                                sizes: ColScreen(sm: Col.col_3),
                                child: Tooltip(
                                  message: 'Tap to Remove',
                                  child: InkWell(
                                    onTap: () => source.pickedFile
                                        .removeWhere((element) => element == e),
                                    child: Image.memory(
                                      e,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(
                                          FontAwesomeIcons.filePdf,
                                          size: 150,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            }
                          }).toList(),
                        )))
              ]),
        ));
  }
}
