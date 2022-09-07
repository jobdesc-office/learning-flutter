part of '../../company.dart';

class _TabActivityType extends StatelessWidget
    implements IndexViewContract, EditViewContract {
  _TabActivityType() {}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Text('data'),
        )
      ]),
    );
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    // TODO: implement onCreateSuccess
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    // TODO: implement onDeleteSuccess
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    // TODO: implement onEditSuccess
  }

  @override
  void onErrorRequest(Response response) {
    // TODO: implement onErrorRequest
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    // TODO: implement onLoadDatatables
  }

  @override
  void onSuccessFetchData(Response response) {
    // TODO: implement onSuccessFetchData
  }
}
