import 'package:boilerplate/widgets/button/theme_button_cancel.dart';
import 'package:boilerplate/widgets/button/theme_button_save.dart';
import 'package:boilerplate/widgets/form_group.dart';
import 'package:boilerplate/widgets/input/custom_input.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/prospectfile_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../_detail_source.dart';

final _navigation = Get.find<NavigationPresenter>();

class ChoosedPopup extends GetView {
  final source = Get.find<ProspectDetailsSource>();
  final filePresenter = Get.find<ProspectFilePresenter>();
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
                BsModalContainer(child: Obx(() {
                  List<TextEditingController> inputRemark = [];
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          children: source.pickedFile.map((e) {
                            var ctrl = TextEditingController();
                            inputRemark.add(ctrl);
                            return BsRow(
                              children: [
                                BsCol(
                                  margin: EdgeInsets.all(3),
                                  sizes: ColScreen(sm: Col.col_3),
                                  child: Image.memory(
                                    e,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        FontAwesomeIcons.filePdf,
                                        size: 150,
                                      );
                                    },
                                  ),
                                ),
                                BsCol(
                                  margin: EdgeInsets.all(3),
                                  sizes: ColScreen(sm: Col.col_9),
                                  child: FormGroup(
                                      label: Obx(() => Text('Remark',
                                          style: TextStyle(
                                              color: _navigation.darkTheme.value
                                                  ? Colors.white
                                                  : Colors.black))),
                                      child: CustomInput(
                                        controller: ctrl,
                                        minLines: 3,
                                      )),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      Obx(() => Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ThemeButtonSave(
                                    disabled: filePresenter.isProcessing.value,
                                    processing:
                                        filePresenter.isProcessing.value,
                                    onPressed: () async {
                                      source.markFile.value = inputRemark;
                                      filePresenter.setProcessing(true);
                                      filePresenter.save(context,
                                          FormData(await source.toJson()));
                                    }),
                                ThemeButtonCancel(
                                    disabled: filePresenter.isProcessing.value,
                                    margin: EdgeInsets.only(left: 5),
                                    onPressed: () => Navigator.pop(context))
                              ],
                            ),
                          ))
                    ],
                  );
                }))
              ]),
        ));
  }
}
