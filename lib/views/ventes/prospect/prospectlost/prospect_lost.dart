import 'package:boilerplate/styles/color_palattes.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/base_text.dart';
import '../../../../models/masters/type_model.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/prospect_presenter.dart';
import '../../../../widgets/button/theme_button_cancel.dart';
import '../../../../widgets/button/theme_button_lost.dart';
import '../../../../widgets/confirm_dialog.dart';
import '../_detail_source.dart';
import '_form_source.dart';

final _navigation = Get.find<NavigationPresenter>();

// ignore: must_be_immutable
class ProspectLose extends GetView {
  final ProspectPresenter presenter = Get.find<ProspectPresenter>();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final source = ProspectLostSource().obs;
  final Function(Map<String, dynamic> body) onSave;
  final sources = Get.put(ProspectDetailsSource());

  late ProspectLostForm prospectForm;

  ProspectLose({required this.onSave, id}) {
    presenter.isProcessing.value = false;
  }

  @override
  Widget build(BuildContext context) {
    prospectForm = ProspectLostForm(source.value);
    return BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.md,
          child: BsModalContent(
              decoration: BoxDecoration(
                color: _navigation.darkTheme.value
                    ? ColorPallates.elseDarkColor
                    : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              children: [
                BsModalContainer(
                  title: Text('Mark as Lose',
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black)),
                  closeButton: true,
                ),
                BsModalContainer(
                  child: Form(
                    key: formState,
                    child: Column(
                      children: [
                        BsRow(
                          children: [
                            BsCol(
                              margin: EdgeInsets.only(right: 5),
                              sizes: ColScreen(sm: Col.col_12),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.grey.shade300)),
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      prospectForm.selectReport(),
                                      prospectForm.inputDesc(),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ThemeButtonLost(
                              disabled: presenter.isProcessing.value,
                              processing: presenter.isProcessing.value,
                              margin: EdgeInsets.only(right: 5),
                              onPressed: () => onClickSaveModal(context),
                            ),
                            ThemeButtonCancel(
                              disabled: presenter.isProcessing.value,
                              margin: EdgeInsets.only(right: 5),
                              onPressed: () => onClickCancelModal(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ]),
        ));
  }

  void onClickSaveModal(BuildContext context) async {
    presenter.setProcessing(true);
    TypeModel stage = await presenter.completePipeline();
    if (formState.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => ConfirmDialog(
          title: BaseText.confirmTitle,
          message: 'Are You Sure This Prospect is Lose ?',
          onPressed: (_, value) async {
            if (value == ConfirmDialogOption.YES_OPTION) {
              onSave(await source.toJson());
              sources.status.value = 'Closed Lost';
              sources.prospectStageController.selected = stage;
              sources.losttype.value = source.value.selectReason
                  .getSelected()!
                  .getOtherValue()['typename']
                  .toString();
              sources.lostdesc.value = source.value.inputDesc.text;
              Navigator.pop(context);
            } else {
              presenter.setProcessing(false);
              Navigator.pop(context);
            }
          },
        ),
      );
    } else
      presenter.setProcessing(false);
  }

  void onClickCancelModal(BuildContext context) {
    Navigator.pop(context);
  }
}
