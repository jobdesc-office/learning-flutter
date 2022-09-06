part of '../company.dart';

class _TabCustomers extends StatelessWidget implements IndexViewContract {
  CPCustomerPresenter get presenter => Get.find<CPCustomerPresenter>();
  final datatable = CustomerDataTableSource();

  _TabCustomers() {
    presenter.customerContract = this;
  }

  @override
  Widget build(BuildContext context) {
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
                  headerActions: [
                    ThemeButtonCreate(
                      prefix: "Add Customer",
                      // onPressed: () => presenter.add(context),
                      onPressed: () {},
                    )
                  ],
                  serverSide: (params) => presenter.datatables(context, params),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {}

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {}

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {}

  @override
  void onErrorRequest(Response response) {}

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    presenter.setProcessing(false);
    List data = response.body['data'].where((e) => e['sbccstmstatus']['typename'] == "Customer").toList();
    response.body['data'] = data;
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener = (userid) {};
    datatable.onEditListener = (countryid) {};
    datatable.onDeleteListener = (cstmid, cstmname) {};
  }
}
