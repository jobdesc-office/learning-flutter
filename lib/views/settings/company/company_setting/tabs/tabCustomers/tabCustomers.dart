part of '../../company.dart';

class _TabCustomers extends StatelessWidget
    implements IndexViewContract, EditViewContract {
  CPCustomerPresenter get presenter => Get.find<CPCustomerPresenter>();
  final datatable = CustomerDataTableSource();
  late CustomerFormSource source;
  final String typename;

  _TabCustomers(this.typename) {
    presenter.customerContract = this;
    presenter.customerEditContract = this;
    source = CustomerFormSource(typename);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Obx(() {
              return Column(
                children: [
                  if (source.isFormActive) _CustomersForm(source),
                  CustomDatabales(
                    source: datatable,
                    columns: datatable.columns,
                    headerActions: [
                      ThemeButtonCreate(
                        prefix: "Add $typename",
                        // onPressed: () => presenter.add(context),
                        onPressed: () => source.isFormActive = true,
                      )
                    ],
                    serverSide: (params) =>
                        presenter.datatables(context, params),
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
    presenter.setProcessing(false);
    source.clear();
    source.isProcessing = false;
    Snackbar().createSuccess();
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    Snackbar().deleteSuccess();
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    datatable.controller.reload();
    source.clear();
    presenter.setProcessing(false);
    source.isProcessing = false;
    Snackbar().editSuccess();
  }

  @override
  void onErrorRequest(Response response) {
    presenter.setProcessing(false);
    source.isProcessing = false;
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    presenter.setProcessing(false);
    List data = response.body['data']
        .where((e) => e['sbccstmstatus']['typename'] == source.typename)
        .toList();
    response.body['data'] = data;
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener = (userid) {};
    datatable.onEditListener = presenter.show;
    datatable.onDeleteListener =
        (cstmid, cstmname) => presenter.delete(context, cstmid, cstmname);
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);
    BusinessPartnerCustomerModel model =
        BusinessPartnerCustomerModel.fromJson(response.body);
    source.fromModel(model);
  }
}
