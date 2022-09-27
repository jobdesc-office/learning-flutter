part of '../../company.dart';

class _TabCustomizeFieldProspect extends GetView implements IndexViewContract {
  final presenter = Get.find<CustomFieldPresenter>();
  final datatable = CustomFieldDataTableSource();
  final sources = Get.put(CustomizeFieldSource());

  _TabCustomizeFieldProspect() {
    presenter.customFieldViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            if (sources.isForm.value)
              _FormCustomfield(ConfigType.prospectCustomField, 'Prospect'),
            CustomDatabales(
              source: datatable,
              columns: datatable.columns,
              headerActions: [
                ThemeButtonCreate(
                  prefix: 'Add Prospect Customize Field',
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
              serverSide: (params) => presenter.datatables(context, params),
            )
          ],
        ));
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    sources.isEdit.value = false;
    sources.isForm.value = false;
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
        (userid) => presenter.details(context, userid, 'Prospect');
    datatable.onEditListener = (countryid) {
      presenter.edits(context, countryid);
      // sources.isEdit.value = true;
      // sources.isForm.value = true;
    };
    datatable.onDeleteListener =
        (cstmid, name) => presenter.delete(context, cstmid, name);
  }
}
