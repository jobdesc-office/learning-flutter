import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/base_text.dart';
import '../../../helpers/function.dart';
import '../../../presenters/masters/typechildren_presenter.dart';
import '../../../widgets/button/theme_button_search.dart';
import '../../../widgets/form_group.dart';
import '../../../widgets/selectbox/custom_selectbox.dart';
import '../../../utils/select_api.dart';
import '_parent_controller.dart';

class TypeChildrenFilter extends StatelessWidget {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final controller = Get.find<ParentSource>();
  final BsSelectBoxController selectParent = BsSelectBoxController();
  final sources = ParentSource().obs;
  final TypesChildrenPresenter presenter = Get.find<TypesChildrenPresenter>();

  late final ParentForm tpForm;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: BsModal(
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
                tpForm = ParentForm(sources.value);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormGroup(
                      child: CustomSelectBox(
                        searchable: true,
                        controller: selectParent,
                        hintText: BaseText.hiintSelect(field: 'Parent'),
                        serverSide: (params) => selectApiTypeParents(params),
                      ),
                    ),
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
      ),
    );
  }

  void onClickSaveModal(BuildContext context) {
    controller.chosed.value = parseInt(selectParent.getSelectedAsString());
    controller.isProcessing.toggle();
    Navigator.pop(context);
  }
}
