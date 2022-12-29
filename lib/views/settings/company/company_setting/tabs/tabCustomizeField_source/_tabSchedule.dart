part of '../../company.dart';

class _TabCustomizeFieldSchedule extends StatelessWidget implements IndexViewContract {
  final presenter = Get.find<CustomFieldPresenter>();
  final datatable = CustomFieldDataTableSource();
  final sources = Get.put(CustomizeFieldSource());

  _TabCustomizeFieldSchedule() {
    presenter.customFielddayactViewContract = this;
    presenter.customFieldViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          child: Column(
            children: [
              if (sources.isForm.value) _FormCustomfield(ConfigType.scheduleCustomField, 'Schedule'),
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
                      prefix: 'Add Schedule Customize Field',
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
                serverSide: (params) => presenter.datatablesschedule(context, params),
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
    Navigator.pop(context);
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
    datatable.onDetailsListener = (userid) => presenter.details(context, userid, 'Schedule');
    datatable.onEditListener = (countryid) {
      _FormCustomfield(ConfigType.scheduleCustomField, 'Schedule');
      sources.isForm.value = true;
      presenter.edits(context, countryid);
      // sources.isEdit.value = true;
      // sources.isForm.value = true;
    };
    datatable.onDeleteListener = (cstmid, name) => presenter.delete(context, cstmid, name);
  }
}
