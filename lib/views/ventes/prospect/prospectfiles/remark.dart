import 'package:boilerplate/widgets/button/theme_button_cancel.dart';
import 'package:boilerplate/widgets/button/theme_button_save.dart';
import 'package:boilerplate/widgets/input/custom_input.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/session_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/prospectfile_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../utils/session_manager.dart';
import '../../../../widgets/form_group.dart';

final _navigation = Get.find<NavigationPresenter>();

class Remark extends GetView {
  final Function(Map<String, dynamic> body) onSave;
  final String filename;
  final String remark;
  Remark({required this.onSave, required this.filename, required this.remark});

  final presenter = Get.find<ProspectFilePresenter>();
  @override
  Widget build(BuildContext context) {
    TextEditingController inputRemark = TextEditingController();
    inputRemark.text = remark;
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
                  title: Text('Remark $filename',
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
                          child: FormGroup(
                              label: Obx(() => Text('Remark',
                                  style: TextStyle(
                                      color: _navigation.darkTheme.value
                                          ? Colors.white
                                          : Colors.black))),
                              child: CustomInput(controller: inputRemark))),
                      BsCol(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ThemeButtonSave(onPressed: () async {
                                SessionModel session =
                                    await SessionManager.current();
                                onSave({
                                  'remark': inputRemark.text,
                                  'createdby': session.userid,
                                  'updatedby': session.userid
                                });
                              }),
                              ThemeButtonCancel(
                                  margin: EdgeInsets.only(left: 5),
                                  onPressed: () => Navigator.pop(context))
                            ],
                          )),
                    ],
                  ),
                )
              ]),
        ));
  }
}
