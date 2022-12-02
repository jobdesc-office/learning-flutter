part of '../../company.dart';

// ignore: must_be_immutable
class _TabCustomerActivity extends StatelessWidget implements IndexViewContract, EditViewContract {
  final datatable = CustomersActivityDataTableSource();
  final String typename;

  late PCustomersForm pCustomerForm;

  BusinessPartnerPresenter get bpPresenter => Get.put(BusinessPartnerPresenter());
  final source = PCustomersSource().obs;
  final custsource = _CustomerFormSource().obs;

  _TabCustomerActivity(this.typename) {
    bpPresenter.businessPartnerViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    pCustomerForm = PCustomersForm(source.value);
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              children: [
                CustomDatabales(
                  source: datatable,
                  columns: datatable.columns,
                  serverSide: (params) => bpPresenter.datatables(context, params),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    datatable.controller.reload();
    source.value.reset();
    custsource.value.isForm.value = false;
    bpPresenter.setProcessing(false);
    Snackbar().createSuccess(context!);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    bpPresenter.setProcessing(false);
    source.value.reset();
    datatable.controller.reload();
    custsource.value.isForm.value = false;
    Get.back();
    Snackbar().deleteSuccess(context!);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    datatable.controller.reload();
    source.value.reset();
    bpPresenter.setProcessing(false);
    custsource.value.isForm.value = false;
    Snackbar().editSuccess(context!);
  }

  @override
  void onErrorRequest(Response response) {
    bpPresenter.setProcessing(false);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    source.value.reset();
    custsource.value.isForm.value = false;
    bpPresenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDayActAllow = (value) => bpPresenter.update(context, {'bpdayactanytime': true}, value);
    datatable.onDayActDisallow = (value) => bpPresenter.update(context, {'bpdayactanytime': false}, value);
    datatable.onProsActAllow = (value) => bpPresenter.update(context, {'bpprosactanytime': true}, value);
    datatable.onProsActDisallow = (value) => bpPresenter.update(context, {'bpprosactanytime': false}, value);
  }

  @override
  void onSuccessFetchData(Response response) {
    bpPresenter.setProcessing(false);
  }
}
