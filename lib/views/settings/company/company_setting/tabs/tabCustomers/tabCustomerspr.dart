part of '../../company.dart';

// ignore: must_be_immutable
class _TabCustomerspr extends StatelessWidget implements IndexViewContract {
  final datatable = CustomerDataTableSource();
  final String typename;

  late ProspectiveCustomersFormSource pCustomerForm;

  ProspectPresenter get presenter => Get.find<ProspectPresenter>();
  BpCustomerPresenter get bppresenter => Get.find<BpCustomerPresenter>();
  ProspectiveCustomerPresenter custpresenter =
      Get.find<ProspectiveCustomerPresenter>();
  final controller = ProspectiveCustomersFormController().obs;
  final pcustsource = _ProspectiveCustomerForm().obs;

  _TabCustomerspr(this.typename) {
    presenter.addCustomerViewContract = this;
    bppresenter.bpCustomerproViewContract = this;
    custpresenter.customerViewContract = this;
  }

  @override
  Widget build(BuildContext context) {
    pCustomerForm = ProspectiveCustomersFormSource(controller.value);
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Obx(() {
              return Column(
                children: [
                  if (pcustsource.value.isForm.value)
                    pcustsource.value.form(context),
                  CustomDatabales(
                    source: datatable,
                    columns: datatable.columns,
                    headerActions: [
                      if (permis
                          .where((element) => element.menunm == 'Settings')
                          .first
                          .children!
                          .where(
                              (element) => element.menunm == 'Company Setting')
                          .first
                          .features!
                          .where((element) => element.featslug == 'create')
                          .first
                          .permissions!
                          .hasaccess!)
                        ThemeButtonCreate(
                          prefix: "$typename",
                          // onPressed: () => presenter.add(context),
                          onPressed: () {
                            pcustsource.value.isForm.toggle();
                            controller.value.pro.value = true;
                          },
                        )
                    ],
                    serverSide: (params) =>
                        bppresenter.datatablesbppro(context, params),
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
    controller.value.reset();
    pcustsource.value.isForm.value = false;
    custpresenter.setProcessing(false);
    Snackbar().createSuccess(context!);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    bppresenter.setProcessing(false);
    controller.value.reset();
    datatable.controller.reload();
    pcustsource.value.isForm.value = false;
    Get.back();
    Snackbar().deleteSuccess(context!);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    datatable.controller.reload();
    controller.value.reset();
    custpresenter.setProcessing(false);
    pcustsource.update((val) {
      pcustsource.value.isForm.value = false;
      pcustsource.value.isEdit.value = false;
    });
    Snackbar().editSuccess(context!);
  }

  @override
  void onErrorRequest(Response response, {context}) {
    bppresenter.setProcessing(false);
    custpresenter.setProcessing(false);
    Snackbar().failed(Get.context!, response.body['message']);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    controller.value.reset();
    pcustsource.value.isForm.value = false;
    bppresenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener =
        (userid) => custpresenter.details(context, userid);
    datatable.onEditListener = (value) {
      custpresenter.show(value);
      pcustsource.value.show.value = false;
    };
    datatable.onDeleteListener =
        (cstmid, cstmname) => bppresenter.delete(context, cstmid, cstmname);
  }
}
