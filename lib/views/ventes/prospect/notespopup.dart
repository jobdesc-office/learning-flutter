import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/session_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/ventes/prospectfile_presenter.dart';
import '../../../styles/color_palattes.dart';
import '../../../utils/session_manager.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';
import '../../../widgets/form_group.dart';
import '../../../widgets/input/custom_input.dart';
import '_detail_source.dart';

final _navigation = Get.find<NavigationPresenter>();

class NotesPopup extends GetView {
  final Function(Map<String, dynamic> body) onSave;
  final String note;
  NotesPopup({required this.onSave, required this.note});

  final presenter = Get.find<ProspectFilePresenter>();
  @override
  Widget build(BuildContext context) {
    TextEditingController inputNotesPopup = TextEditingController();
    final source = Get.put(ProspectDetailsSource());
    inputNotesPopup.text = note;
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
                  title: Text('Notes',
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
                              label: Obx(() => Text('Notes',
                                  style: TextStyle(
                                      color: _navigation.darkTheme.value
                                          ? Colors.white
                                          : Colors.black))),
                              child: CustomInput(controller: inputNotesPopup))),
                      BsCol(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ThemeButtonSave(onPressed: () async {
                                SessionModel session =
                                    await SessionManager.current();
                                onSave({
                                  'prospectdescription': inputNotesPopup.text,
                                  'createdby': session.userid,
                                  'updatedby': session.userid
                                });
                                source.desc.value = inputNotesPopup.text;
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
