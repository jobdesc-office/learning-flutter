import 'package:boilerplate/styles/color_palattes.dart';
import 'package:boilerplate/widgets/button/theme_button_save.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/base_text.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/prospect_detail_presenter.dart';
import '../../../../widgets/button/theme_button_cancel.dart';
import '../../../../widgets/button/theme_button_lost.dart';
import '../../../../widgets/confirm_dialog.dart';
import '../_chat_source.dart';
import '_form_source.dart';

final _navigation = Get.find<NavigationPresenter>();

// ignore: must_be_immutable
class ChatRef extends GetView {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final source = ChatRefSource().obs;
  final sources = Get.put(ChatSource());

  late ChatRefForm prospectForm;

  @override
  Widget build(BuildContext context) {
    prospectForm = ChatRefForm(source.value);
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
                  title: Text('Reference',
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
                              margin: EdgeInsets.only(right: 5, bottom: 10),
                              sizes: ColScreen(sm: Col.col_12),
                              child: Obx(() => Container(
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
                                          if (sources.isProspect.value)
                                            prospectForm
                                                .selectProspect(context),
                                          if (sources.isActivity.value)
                                            prospectForm
                                                .selectActivity(context),
                                        ],
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ]),
        ));
  }
}
