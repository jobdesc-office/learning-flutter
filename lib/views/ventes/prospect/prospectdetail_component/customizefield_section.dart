part of '../prospect_detail.dart';

class CustomfieldSection extends StatelessWidget {
  const CustomfieldSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var permis = authPresenter.rolepermis.value;
    final presenter = Get.find<ProspectPresenter>();
    final source = Get.put(ProspectDetailsSource());
    final cfieldForm = CustomFieldSource().obs;
    final GlobalKey<FormState> formState = GlobalKey<FormState>();
    final GlobalKey<FormState> formStateCF = GlobalKey<FormState>();
    final customFieldPresenter = Get.find<CustomFieldPresenter>();
    final prospectCustomFieldPresenter =
        Get.find<ProspectCustomFieldPresenter>();
    final _navigation = Get.find<NavigationPresenter>();

    late ProspectCustomFieldForm prospectCustomFieldForm;
    late CustomFieldForm customFieldForm;

    void onClickSaveModal(BuildContext context) async {
      source.isAdd.value = false;
      prospectCustomFieldPresenter.setProcessing(true);
      if (source.isUpdate.value) {
        if (formState.currentState!.validate()) {
          prospectCustomFieldPresenter.update(
              context, await cfForm.toJson(), source.cfid.value);
          source.isUpdate.value = false;
          source.cfid.value = 0;
          cfForm.value.reset();
        } else {
          prospectCustomFieldPresenter.setProcessing(false);
          source.isUpdate.value = false;
          cfForm.value.reset();
        }
      } else {
        if (formState.currentState!.validate()) {
          prospectCustomFieldPresenter.save(context, await cfForm.toJson());
          cfForm.value.reset();
        } else {
          prospectCustomFieldPresenter.setProcessing(false);
          cfForm.value.reset();
        }
      }
    }

    void onClickCancelModal(BuildContext context) {
      source.isAdd.value = false;
      source.isUpdate.value = false;
      cfForm.value.inputValue.text = '';
      cfForm.value.selectCustomfield.clear();
    }

    void onClickSave(BuildContext context) async {
      source.isAddCF.value = false;
      customFieldPresenter.setProcessing(true);
      if (formStateCF.currentState!.validate()) {
        if (!cfieldForm.value.onlythisprospect.value &&
            !cfieldForm.value.allprospect.value) {
          Get.defaultDialog(
              title: 'Attention', middleText: 'Checkbox Required !');
          source.isAddCF.value = true;
        } else
          customFieldPresenter.save(context, await cfieldForm.toJson());
      } else
        customFieldPresenter.setProcessing(false);
    }

    void onClickCancel(BuildContext context) {
      source.isAddCF.value = false;
      cfieldForm.value.inputName.text = '';
      cfieldForm.value.selectType.clear();
      cfieldForm.value.allprospect.value = false;
      cfieldForm.value.onlythisprospect.value = false;
    }

    return Obx(() => Container(
          decoration: BoxDecoration(
            color: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Additional Information',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Tooltip(
                            //   message: 'View Available Custom Field',
                            //   child: BsButton(
                            //       size: BsButtonSize.btnSm,
                            //       onPressed: () => customFieldPresenter.popup(
                            //             context,
                            //           ),
                            //       label: Icon(
                            //         Icons.info,
                            //         size: 13,
                            //       )),
                            // ),
                            // Tooltip(
                            //   message: 'Write Custom Field',
                            //   child: BsButton(
                            //       margin: EdgeInsets.only(left: 5),
                            //       size: BsButtonSize.btnSm,
                            //       onPressed: () {
                            //         source.isAdd.toggle();
                            //         source.isAddCF.value = false;
                            //       },
                            //       label: Icon(
                            //         Icons.edit,
                            //         size: 13,
                            //       )),
                            // ),
                            if (source.status.value != ProspectText.closedWon &&
                                source.status.value !=
                                    ProspectText.closedLost &&
                                source.status.value != ProspectText.forceClosed)
                              if (permis
                                  .where((element) =>
                                      element.menunm == 'Ventes Datas')
                                  .first
                                  .children!
                                  .where(
                                      (element) => element.menunm == 'Prospect')
                                  .first
                                  .features!
                                  .where(
                                      (element) => element.featslug == 'create')
                                  .first
                                  .permissions!
                                  .hasaccess!)
                                Tooltip(
                                  message: source.status.value !=
                                              ProspectText.closedWon &&
                                          source.status.value !=
                                              ProspectText.closedLost &&
                                          source.status.value !=
                                              ProspectText.forceClosed
                                      ? 'Add Custom Field'
                                      : '',
                                  child: BsButton(
                                    margin: EdgeInsets.only(left: 5),
                                    size: BsButtonSize.btnSm,
                                    onPressed: () {
                                      source.isAddCF.toggle();
                                      source.isAdd.value = false;
                                    },
                                    prefixIcon: Icons.add,
                                    label: Text('Customize Fields'),
                                  ),
                                )
                          ],
                        )),
                  ],
                ),
                if (source.isAddCF.value)
                  AnimatedContainer(
                    margin: EdgeInsets.only(top: 10),
                    duration: Duration(seconds: 3),
                    child: Obx(() {
                      customFieldForm = CustomFieldForm(cfieldForm.value);
                      return Form(
                        key: formStateCF,
                        child: Column(
                          children: [
                            BsRow(
                              children: [
                                BsCol(
                                  margin: EdgeInsets.only(right: 5),
                                  sizes: ColScreen(sm: Col.col_12),
                                  child: Text('Add Custom Field',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black)),
                                ),
                                BsCol(
                                  margin: EdgeInsets.only(right: 5),
                                  sizes: ColScreen(sm: Col.col_12),
                                  child: Container(
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          customFieldForm.inputName(),
                                          customFieldForm.selectTypes(),
                                          customFieldForm.checkBoxForm()
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ThemeButtonSave(
                                    disabled: prospectCustomFieldPresenter
                                        .isProcessing.value,
                                    processing: presenter.isProcessing.value,
                                    margin: EdgeInsets.only(right: 5),
                                    onPressed: () => onClickSave(context),
                                  ),
                                  ThemeButtonCancel(
                                    disabled: prospectCustomFieldPresenter
                                        .isProcessing.value,
                                    margin: EdgeInsets.only(right: 5),
                                    onPressed: () => onClickCancel(context),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                if (source.isAdd.value)
                  AnimatedContainer(
                    margin: EdgeInsets.only(top: 10),
                    duration: Duration(seconds: 3),
                    child: Obx(() {
                      prospectCustomFieldForm =
                          ProspectCustomFieldForm(cfForm.value);
                      return Obx(() => Form(
                            key: formState,
                            child: Column(
                              children: [
                                BsRow(
                                  children: [
                                    BsCol(
                                      margin: EdgeInsets.only(right: 5),
                                      sizes: ColScreen(sm: Col.col_12),
                                      child: Text('Write Custom Field',
                                          style: TextStyle(
                                              color: _navigation.darkTheme.value
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ),
                                    BsCol(
                                      margin: EdgeInsets.only(right: 5),
                                      sizes: ColScreen(sm: Col.col_12),
                                      child: Container(
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              prospectCustomFieldForm
                                                  .selectCf(),
                                              prospectCustomFieldForm
                                                  .inputValue(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Obx(
                                  () => Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ThemeButtonSave(
                                        disabled: prospectCustomFieldPresenter
                                            .isProcessing.value,
                                        processing:
                                            presenter.isProcessing.value,
                                        margin: EdgeInsets.only(right: 5),
                                        onPressed: () =>
                                            onClickSaveModal(context),
                                      ),
                                      ThemeButtonCancel(
                                        disabled: prospectCustomFieldPresenter
                                            .isProcessing.value,
                                        margin: EdgeInsets.only(right: 5),
                                        onPressed: () =>
                                            onClickCancelModal(context),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ));
                    }),
                  ),
                if (!source.isAddCF.value)
                  AnimatedContainer(
                    margin: EdgeInsets.only(top: 10),
                    duration: Duration(seconds: 3),
                    child: Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: source.customField.length,
                            itemBuilder: (context, index) {
                              var customField = source.customField[index];

                              return Tooltip(
                                message: source.status.value !=
                                            ProspectText.closedWon &&
                                        source.status.value !=
                                            ProspectText.closedLost &&
                                        source.status.value !=
                                            ProspectText.forceClosed
                                    ? BaseText.editDelete
                                    : '',
                                child: InkWell(
                                  onLongPress: () {
                                    if (source.status.value !=
                                            ProspectText.closedWon &&
                                        source.status.value !=
                                            ProspectText.closedLost &&
                                        source.status.value !=
                                            ProspectText.forceClosed)
                                      Get.defaultDialog(
                                          middleText: '',
                                          title: 'Setting',
                                          actions: [
                                            if (permis
                                                .where((element) =>
                                                    element.menunm ==
                                                    'Ventes Datas')
                                                .first
                                                .children!
                                                .where((element) =>
                                                    element.menunm ==
                                                    'Prospect')
                                                .first
                                                .features!
                                                .where((element) =>
                                                    element.featslug ==
                                                    'update')
                                                .first
                                                .permissions!
                                                .hasaccess!)
                                              ButtonEditDatatables(
                                                  onPressed: () {
                                                prospectCustomFieldPresenter
                                                    .edit(
                                                        context,
                                                        customField
                                                            .prospectcfid!);
                                                source.cfid.value =
                                                    customField.prospectcfid!;
                                              }),
                                            if (permis
                                                .where((element) =>
                                                    element.menunm ==
                                                    'Ventes Datas')
                                                .first
                                                .children!
                                                .where((element) =>
                                                    element.menunm ==
                                                    'Prospect')
                                                .first
                                                .features!
                                                .where((element) =>
                                                    element.featslug ==
                                                    'delete')
                                                .first
                                                .permissions!
                                                .hasaccess!)
                                              ButtonDeleteDatatables(
                                                  onPressed: () {
                                                prospectCustomFieldPresenter.delete(
                                                    context,
                                                    customField.prospectcfid!,
                                                    '${customField.prospectcfvalue}');
                                              }),
                                          ]);
                                  },
                                  child: BsRow(
                                    margin: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorPallates.primary,
                                    ),
                                    padding: EdgeInsets.all(5),
                                    children: [
                                      BsCol(
                                          alignment: Alignment.center,
                                          sizes: ColScreen(sm: Col.col_5),
                                          child: Text(
                                              customField
                                                  .customfield!.custfname!,
                                              style: TextStyle(
                                                  color: Colors.white))),
                                      BsCol(
                                          alignment: Alignment.center,
                                          sizes: ColScreen(sm: Col.col_2),
                                          child: Text(':',
                                              style: TextStyle(
                                                  color: Colors.white))),
                                      BsCol(
                                          alignment: Alignment.center,
                                          sizes: ColScreen(sm: Col.col_5),
                                          child: Text(
                                              customField.prospectcfvalue!,
                                              style: TextStyle(
                                                  color: Colors.white))),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        // Y
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: source.rawcustomField.length,
                            itemBuilder: (context, index) {
                              var rawcustomField = source.rawcustomField[index];

                              return InkWell(
                                onTap: () {
                                  if (source.status.value !=
                                          ProspectText.closedWon &&
                                      source.status.value !=
                                          ProspectText.closedLost &&
                                      source.status.value !=
                                          ProspectText.forceClosed) {
                                    source.isAdd.value = true;
                                    cfForm.value.format.value =
                                        rawcustomField.custftype!.typename!;
                                    cfForm.value.selectCustomfield.setSelected(
                                        BsSelectBoxOption(
                                            value: rawcustomField.custfid,
                                            text: Text(
                                                rawcustomField.custfname!)));
                                  }
                                },
                                child: BsRow(
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorPallates.tertiary,
                                  ),
                                  padding: EdgeInsets.all(5),
                                  children: [
                                    BsCol(
                                        alignment: Alignment.center,
                                        sizes: ColScreen(sm: Col.col_5),
                                        child: Text(
                                          rawcustomField.custfname!,
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    BsCol(
                                        alignment: Alignment.center,
                                        sizes: ColScreen(sm: Col.col_2),
                                        child: Text(':',
                                            style: TextStyle(
                                                color: Colors.white))),
                                    BsCol(
                                        alignment: Alignment.center,
                                        sizes: ColScreen(sm: Col.col_5),
                                        child: Text('-',
                                            style: TextStyle(
                                                color: Colors.white))),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ));
  }
}
