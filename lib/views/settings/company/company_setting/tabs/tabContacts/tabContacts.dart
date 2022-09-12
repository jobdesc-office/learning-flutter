part of '../../company.dart';

class _TabContact extends StatelessWidget
    implements IndexViewContract, EditViewContract {
  CPContactPresenter presenter = Get.find();
  ContactDataTableSource datatable = ContactDataTableSource();
  ContactFormSource source = ContactFormSource();

  _TabContact() {
    presenter.contactContract = this;
    presenter.contactEditContract = this;
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
                  if (source.isFormActive.value) _ContactForm(source),
                  CustomDatabales(
                    source: datatable,
                    columns: datatable.columns,
                    headerActions: [
                      ThemeButtonCreate(
                        prefix: "Add Contact",
                        onPressed: () => source.isFormActive.value = true,
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
    source.isProcessing.value = false;
    Snackbar().createSuccess();
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    datatable.controller.reload();
    presenter.setProcessing(false);
    source.clear();
    source.isProcessing.value = false;
    Snackbar().deleteSuccess();
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    datatable.controller.reload();
    presenter.setProcessing(false);
    source.clear();
    source.isProcessing.value = false;
    Snackbar().editSuccess();
  }

  @override
  void onErrorRequest(Response response) {
    presenter.setProcessing(false);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener = (contactid) {};
    datatable.onEditListener =
        (contactid) => presenter.edit(context, contactid);
    datatable.onDeleteListener =
        (contactid, name) => presenter.delete(context, contactid, name);
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);
    ContactModel model = ContactModel.fromJson(response.body);
    source.fromModel(model);
  }
}
