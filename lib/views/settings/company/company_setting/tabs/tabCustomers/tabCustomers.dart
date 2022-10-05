part of '../../company.dart';

// ignore: must_be_immutable
class _TabCustomers extends StatelessWidget implements IndexViewContract, EditViewContract {
  final datatable = CustomersDataTableSource();
  final String typename;

  late PCustomersForm pCustomerForm;

  ProspectPresenter get presenter => Get.find<ProspectPresenter>();
  BpCustomerPresenter get bppresenter => Get.find<BpCustomerPresenter>();
  CustomerPresenter custpresenter = Get.find<CustomerPresenter>();
  final source = PCustomersSource().obs;
  final custsource = _CustomerFormSource().obs;

  _TabCustomers(this.typename) {
    presenter.addCustomerViewContract = this;
    bppresenter.bpCustomerViewContract = this;
    custpresenter.customerViewContract = this;
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
            child: Obx(() {
              return Column(
                children: [
                  if (custsource.value.isForm.value) custsource.value.form(context),
                  CustomDatabales(
                    source: datatable,
                    columns: datatable.columns,
                    headerActions: [
                      ThemeButtonCreate(
                        prefix: "$typename",
                        // onPressed: () => presenter.add(context),
                        onPressed: () {
                          custsource.value.isForm.toggle();
                          source.value.pro.value = false;
                        },
                      )
                    ],
                    serverSide: (params) => bppresenter.datatablesbpcus(context, params),
                  ),
                ],
              );
            }),
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
    custpresenter.setProcessing(false);
    Snackbar().createSuccess(context!);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    bppresenter.setProcessing(false);
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
    custpresenter.setProcessing(false);
    custsource.value.isForm.value = false;
    Snackbar().editSuccess(context!);
  }

  @override
  void onErrorRequest(Response response) {
    bppresenter.setProcessing(false);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    source.value.reset();
    custsource.value.isForm.value = false;
    bppresenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener = (userid) {};
    // datatable.onEditListener = presenter.show;
    datatable.onDeleteListener = (cstmid, cstmname) => bppresenter.delete(context, cstmid, cstmname);
  }

  @override
  void onSuccessFetchData(Response response) {
    bppresenter.setProcessing(false);
  }
}
