part of '../../company.dart';

class _TabCustomizeFieldDailyActivity extends StatelessWidget
    implements IndexViewContract, EditViewContract {
  final presenter = Get.find<CustomFieldPresenter>();
  final datatable = CustomFieldDataTableSource();
  final sources = Get.put(CustomizeFieldSource());

  _TabCustomizeFieldDailyActivity() {
    presenter.customFielddayactViewContract = this;
    presenter.customFielddFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
      child: Column(
            children: [
              if (sources.isForm.value)
                _FormCustomfield(ConfigType.activityCustomField, 'Activity'),
              CustomDatabales(
                source: datatable,
                columns: datatable.columns,
                headerActions: [
                  if (permis
                      .where((element) => element.menunm == 'Settings')
                      .first
                      .children!
                      .where((element) => element.menunm == 'Company Setting')
                      .first
                      .features!
                      .where((element) => element.featslug == 'create')
                      .first
                      .permissions!
                      .hasaccess!)
                    ThemeButtonCreate(
                      prefix: 'Add Daily Activity Customize Field',
                      onPressed: () {
                        if (sources.isEdit.value) {
                          sources.isEdit.value = false;
                          sources.reset();
                        } else {
                          sources.isForm.toggle();
                          sources.reset();
                        }
                      },
                    )
                ],
                serverSide: (params) =>
                    presenter.datatablesdayact(context, params),
              )
            ],
          ),
    ));
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    sources.isEdit.value = false;
    sources.isForm.value = false;
    datatable.controller.reload();
    Snackbar().createSuccess(context!);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    sources.isEdit.value = false;
    sources.isForm.value = false;
    Snackbar().deleteSuccess(context!);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    sources.isEdit.value = false;
    sources.isForm.value = false;
    Snackbar().editSuccess(context!);
  }

  @override
  void onErrorRequest(Response response) {
    presenter.setProcessing(false);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener =
        (userid) => presenter.details(context, userid, 'Daily Activity');
    datatable.onEditListener = (countryid) {
      presenter.edits(context, countryid);
      // sources.isEdit.value = true;
      // sources.isForm.value = true;
    };
    datatable.onDeleteListener =
        (cstmid, name) => presenter.delete(context, cstmid, name);
  }

  @override
  void onSuccessFetchData(Response response) {
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
    sources.isEdit.value = true;
    sources.isForm.value = true;
  }
}
