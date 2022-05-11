import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../presenters/ventes/prospect_presenter.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '_form_source.dart';

class ProspectFormView extends StatelessWidget implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final ProspectPresenter presenter = Get.find<ProspectPresenter>();
  final source = ProspectSource().obs;
  final Function(Map<String, dynamic> body) onSave;

  late ProspectForm prospectForm;

  ProspectFormView({required this.onSave}) {
    // presenter.ProspectFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        child: Obx(() {
          prospectForm = ProspectForm(source.value);
          return Form(
            key: formState,
            child: BsRow(
              children: [
                BsCol(
                  margin: EdgeInsets.only(right: 5),
                  sizes: ColScreen(sm: Col.col_4),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade300)),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          prospectForm.inputOrganization(),
                          prospectForm.inputContact(),
                          prospectForm.inputTitle(),
                          prospectForm.inputValue(),
                          prospectForm.inputPipeline(),
                          prospectForm.inputPipelineStage(),
                          prospectForm.inputExpected(),
                          prospectForm.inputVisible(),
                        ],
                      ),
                    ),
                  ),
                ),
                BsCol(
                  margin: EdgeInsets.only(left: 5),
                  sizes: ColScreen(sm: Col.col_8),
                  child: BsRow(
                    children: [
                      BsCol(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Container(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  prospectForm.inputEmail(
                                      onRemoveEmail: onClickRemoveEmail),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: GestureDetector(
                                        onTap: () {
                                          source.update((val) {
                                            source.value.inputEmails
                                                .add(TextEditingController());
                                            source.value.selectsPrivationEmail
                                                .add(BsSelectBoxController(
                                                    options: [
                                                  BsSelectBoxOption(
                                                      value: '{1}',
                                                      text: Text("Work")),
                                                  BsSelectBoxOption(
                                                      value: '{2}',
                                                      text: Text('Private'))
                                                ]));
                                          });
                                        },
                                        child: Text('+ Add More Emails')),
                                  ),
                                  prospectForm.inputPhone(
                                      onRemovePhone: onClickRemovePhone),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: GestureDetector(
                                        onTap: () {
                                          source.update((val) {
                                            source.value.inputPhones
                                                .add(TextEditingController());
                                            source.value.selectsPrivationPhone
                                                .add(BsSelectBoxController(
                                                    options: [
                                                  BsSelectBoxOption(
                                                      value: '{1}',
                                                      text: Text("Work")),
                                                  BsSelectBoxOption(
                                                      value: '{2}',
                                                      text: Text('Private'))
                                                ]));
                                          });
                                        },
                                        child: Text('+ Add More Phones')),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      BsCol(
                        margin: EdgeInsets.only(top: 5),
                        child: Container(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  prospectForm.inputProduct(
                                      onRemoveItem: onClickRemoveItem),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              source.update((val) {
                                                source.value.inputItems.add(
                                                    TextEditingController());
                                                source.value.inputPrices.add(
                                                    TextEditingController());
                                                source.value.inputQuantities.add(
                                                    TextEditingController());
                                                source.value.inputAmounts.add(
                                                    TextEditingController());
                                              });
                                            },
                                            child: Text('+ Add More Items')),
                                        prospectForm.total()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      BsCol(
                        margin: EdgeInsets.only(top: 20),
                        child: Obx(
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
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void onClickRemoveEmail(int index) {
    source.update((val) {
      source.value.inputEmails.removeAt(index);
      source.value.selectsPrivationEmail.removeAt(index);
    });
  }

  void onClickRemovePhone(int index) {
    source.update((val) {
      source.value.inputPhones.removeAt(index);
      source.value.selectsPrivationPhone.removeAt(index);
    });
  }

  void onClickRemoveItem(int index) {
    source.update((val) {
      source.value.inputItems.removeAt(index);
      source.value.inputPrices.removeAt(index);
      source.value.inputQuantities.removeAt(index);
      source.value.inputAmounts.removeAt(index);
    });
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
    // presenter.setProcessing(false);

    // source.update((val) {
    //   ProspectModel bp = ProspectModel.fromJson(response.body);
    //   source.value.inputCompanyName.text = bp.bpname;
    //   source.value.inputName.text = bp.bppicname;
    //   source.value.inputEmail.text = bp.bpemail;
    //   source.value.inputPhone.text = bp.bpphone;
    // });
  }
}
