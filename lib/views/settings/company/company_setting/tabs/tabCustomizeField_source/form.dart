part of '../../company.dart';

// ignore: must_be_immutable
class _FormCustomfield extends StatelessWidget implements EditViewContract {
  String configg, data;
  _FormCustomfield(this.configg, this.data) {
    presenter.customFielddFetchDataContract = this;
    presenters.customFielddFetchDataContract = this;
  }

  final presenter = Get.find<CustomFieldPresenter>();
  final optPresenter = Get.find<OptionPresenter>();
  final presenters = Get.find<CustomFieldsPresenter>();
  final _navigation = Get.find<NavigationPresenter>();
  final sources = Get.put(CustomizeFieldSource());

  @override
  Widget build(BuildContext context) {
    sources.config.value = this.configg;
    return Obx(() {
      return BsRow(
        children: [
          BsCol(
            sizes: ColScreen(
              sm: Col.col_6,
            ),
            child: Form(
              key: sources.formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      sources.inputNames(),
                      sources.selectTypes(),
                      sources.checkBoxForm(data),
                      if (sources.visible.value && data == 'Prospect')
                        sources.selectProspect(),
                      if (sources.visible.value && data == 'Activity')
                        sources.selectActivity(),
                      if (sources.isselectbox.value)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => sources.inputOptions
                                  .add(TextEditingController()),
                              child: Text(
                                'Add More Option',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            sources.formDetail(context,
                                onRemoveItem: onClickRemoveRoleItem),
                          ],
                        ),
                    ],
                  ),
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
                  ),
                ],
              ),
            ),
          ),
          if (sources.isEdit.value)
            BsCol(
              margin: EdgeInsets.only(left: 5),
              sizes: ColScreen(lg: Col.col_6),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _navigation.darkTheme.value
                      ? ColorPallates.elseDarkColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: BsRow(
                  children: [
                    BsCol(
                      child: BsRow(
                        children: [
                          BsCol(
                            child: FormGroupEdit(
                                label: Text('Created By',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(sources.createdby.value),
                                    Divider()
                                  ],
                                )),
                          ),
                          BsCol(
                            margin: EdgeInsets.only(top: 10),
                            child: FormGroupEdit(
                                label: Text('Created At',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(sources.createddate.value),
                                    Divider()
                                  ],
                                )),
                          ),
                          BsCol(
                            margin: EdgeInsets.only(top: 10),
                            child: FormGroupEdit(
                                label: Text('Last Updated By',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(sources.updatedby.value),
                                    Divider()
                                  ],
                                )),
                          ),
                          BsCol(
                            margin: EdgeInsets.only(top: 10),
                            child: FormGroupEdit(
                                label: Text('Last Updated At',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(sources.updateddate.value),
                                    Divider()
                                  ],
                                )),
                          ),
                          BsCol(
                            margin: EdgeInsets.only(top: 10),
                            child: FormGroupEdit(
                                label: Text('Is Active',
                                    style: TextStyle(
                                        color: _navigation.darkTheme.value
                                            ? Colors.white
                                            : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (sources.isactive.value)
                                      InkWell(
                                        child: Icon(
                                          Icons.toggle_on,
                                          size: 35,
                                          color: _navigation.darkTheme.value
                                              ? ColorPallates.onDarkMode
                                              : ColorPallates.onLightMode,
                                        ),
                                        onTap: () => sources.isactive.toggle(),
                                      )
                                    else
                                      InkWell(
                                        child: Icon(
                                          Icons.toggle_off,
                                          size: 35,
                                          color: _navigation.darkTheme.value
                                              ? ColorPallates.offDarkMode
                                              : ColorPallates.offLightMode,
                                        ),
                                        onTap: () => sources.isactive.toggle(),
                                      ),
                                    Divider()
                                  ],
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
        ],
      );
    });
  }

  void onClickSaveModal(BuildContext context) async {
    if (sources.formState.currentState!.validate()) {
      presenters.setProcessing(true);
      if (data == 'Prospect') {
        if (sources.isEdit.value) {
          SessionModel session = await SessionManager.current();
          for (var element in sources.optid) {
            optPresenter.update(
                context,
                {
                  'optvalue':
                      sources.inputOptions[sources.optid.indexOf(element)].text,
                  'createdby': session.userid,
                },
                element);
          }
          if (sources.inputOptions.length > sources.optid.length) {
            List<TextEditingController> newopt =
                sources.inputOptions.skip(sources.optid.length).toList();
            for (var element in newopt) {
              optPresenter.save(context,
                  {'optcustfid': sources.id.value, 'optvalue': element.text});
            }
          }
          presenters.update(context, await sources.toJson(), sources.id.value);
          sources.reset();
        } else {
          if (sources.formState.currentState!.validate()) {
            presenters.save(context, await sources.toJson());
            sources.reset();
          } else
            presenters.setProcessing(false);
        }
      } else {
        presenter.setProcessing(true);
        if (sources.isEdit.value) {
          SessionModel session = await SessionManager.current();
          for (var element in sources.optid) {
            optPresenter.update(
                context,
                {
                  'optvalue':
                      sources.inputOptions[sources.optid.indexOf(element)].text,
                  'createdby': session.userid,
                },
                element);
          }
          if (sources.inputOptions.length > sources.optid.length) {
            List<TextEditingController> newopt =
                sources.inputOptions.skip(sources.optid.length).toList();
            for (var element in newopt) {
              optPresenter.save(context,
                  {'optcustfid': sources.id.value, 'optvalue': element.text});
            }
          }
          presenter.update(context, await sources.toJson(), sources.id.value);
          sources.reset();
        } else {
          if (sources.formState.currentState!.validate()) {
            presenter.save(context, await sources.toJson());
            sources.reset();
          } else
            presenter.setProcessing(false);
        }
      }
    } else
      presenter.setProcessing(false);
  }

  void onClickCancelModal(BuildContext context) {
    sources.isForm.value = false;
    sources.reset();
  }

  onClickRemoveRoleItem(BuildContext context, int index) {
    if (sources.isEdit.value) {
      optPresenter.delete(
          context, sources.optid[index], sources.optname[index], index);
    } else
      sources.inputOptions.removeAt(index);
  }

  @override
  void onSuccessFetchData(Response response) {
    sources.isForm.value = true;
    sources.isEdit.value = true;
    presenter.setProcessing(false);

    CustomFieldModel customField = CustomFieldModel.fromJson(response.body);
    sources.id.value = customField.custfid ?? 0;
    sources.selectType.setSelected(BsSelectBoxOption(
        value: customField.custftype!.typeid,
        text: Text(customField.custftype!.typename.toString())));
    sources.newprospect.value = customField.alldata ?? false;
    sources.visible.value = customField.onlythisdata ?? false;
    sources.inputName.text = customField.custfname ?? '';
    if (customField.custfreftype?.typename == 'Prospect')
      _FormCustomfield(ConfigType.prospectCustomField, 'Prospect').data =
          'Prospect';
    else
      _FormCustomfield(ConfigType.activityCustomField, 'Activity').data =
          'Activity';

    if (customField.selectoption!.isNotEmpty) {
      sources.inputOptions.clear();
      sources.isselectbox.value = true;
      sources.inputOptions.addAll(customField.selectoption!
          .map((e) => TextEditingController(text: e.optvalue))
          .toList());
      for (var element in customField.selectoption!) {
        sources.optid.add(element.optid);
        sources.optname.add(element.optvalue);
      }
    }
    if (customField.onlythisdata == true) {
      sources.selectprospect.clear();
      if (customField.custfreftype?.typename == 'Prospect') {
        sources.selectprospect.setSelected(BsSelectBoxOption(
            value: customField.refprospect?.prospectid,
            text: Text(
                '${customField.refprospect?.prospectname ?? ''} || ${customField.refprospect?.prospectcust?.sbccstmname ?? ''}')));
      } else {
        sources.selectprospect.setSelected(BsSelectBoxOption(
            value: customField.refactivity?.dayactid,
            text: Text(
                '${customField.refactivity?.dayactloclabel ?? ''} || ${customField.refactivity?.dayactdate ?? ''}')));
      }
    }

    sources.createdby.value = customField.custfcreatedby?.userfullname ?? '';
    sources.createddate.value = customField.createddate ?? '';
    sources.updatedby.value = customField.custfupdatedby?.userfullname ?? '';
    sources.updateddate.value = customField.updateddate ?? '';
    sources.isactive.value = customField.isactive ?? true;
  }
}
