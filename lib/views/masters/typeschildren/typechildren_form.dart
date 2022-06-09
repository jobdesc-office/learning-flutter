import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../contracts/master/typechildren_contract.dart';
import '../../../models/masters/type_model.dart';
import '../../../presenters/masters/typechildren_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '_form_source.dart';

class TypeChildrenFormView extends StatelessWidget
    implements EditViewContract, typeChildrenContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final TypesChildrenPresenter presenter = Get.find<TypesChildrenPresenter>();
  final source = TypeChildrenSource().obs;
  final Function(Map<String, dynamic> body) onSave;

  late TypeChildrenForm tpForm;

  TypeChildrenFormView({required this.onSave}) {
    presenter.typeChildrenParentDataContract = this;
    presenter.typeChildrenFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        activeRoutes: [
          RouteList.masterTypeChildren.index,
          RouteList.masterTypeChildren.index
        ],
        child: Obx(() {
          tpForm = TypeChildrenForm(source.value);
          return Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tpForm.inputCode(),
                tpForm.inputName(),
                tpForm.selectParent(),
                tpForm.inputSeq(),
                tpForm.inputDesc(),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ThemeButtonSave(
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
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  void onClickSaveModal(BuildContext context) async {
    presenter.setProcessing(true);
    if (formState.currentState!.validate())
      onSave(await source.toJson());
    else
      presenter.setProcessing(false);
  }

  void onClickCancelModal(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);

    source.update((val) {
      TypeModel menu = TypeModel.fromJson(response.body);
      source.value.inputName.text = menu.typename;
      source.value.inputCode.text = menu.typecd;
      source.value.inputSeq.text = menu.typeseq.toString();
      source.value.inputDesc.text = menu.description;
    });
  }

  @override
  void onLoadParentSuccess(Response response) {
    TypeModel menu = TypeModel.fromJson(response.body);
    source.value.selectParent.setSelected(
        BsSelectBoxOption(value: menu.typeid, text: Text(menu.typename)));
  }
}
