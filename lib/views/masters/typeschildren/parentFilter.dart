import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../presenters/masters/typechildren_presenter.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_search.dart';
import '_parent_controller.dart';
import '_text.dart';

class TypeChildrenFilter extends StatelessWidget {
  final source = ParentSource().obs;
  final TypesChildrenPresenter presenter = Get.find<TypesChildrenPresenter>();

  late ParentForm tpForm;

  @override
  Widget build(BuildContext context) {
    return BsModal(
      context: context,
      dialog: BsModalDialog(
        size: BsModalSize.sm,
        child: BsModalContent(children: [
          BsModalContainer(
            title: Text('Filter'),
            closeButton: true,
          ),
          BsModalContainer(
            child: Obx(() {
              tpForm = ParentForm(source.value);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tpForm.selectParent(),
                ],
              );
            }),
          ),
          BsModalContainer(
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ThemeButtonSearch(
                    disabled: presenter.isProcessing.value,
                    processing: presenter.isProcessing.value,
                    margin: EdgeInsets.only(right: 5),
                    onPressed: () => onClickSaveModal(context),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  void onClickSaveModal(BuildContext context) async {}
}
