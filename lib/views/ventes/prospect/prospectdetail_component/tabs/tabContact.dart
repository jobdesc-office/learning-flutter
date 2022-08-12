part of '../../prospect_detail.dart';

class _tabContact extends StatelessWidget {
  const _tabContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final datatable = ProspectContactDataTableSource(source.contact.value);
    final contactPresenter = Get.find<ProspectContactPresenter>();
    if (source.contact.length != 0)
      return SingleChildScrollView(
        child: CustomDatabales(
          source: datatable,
          columns: datatable.columns,
          searchable: false,
        ),
      );
    else
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Contacts is\'n Defined'),
          BsButton(
            style: BsButtonStyle.success,
            margin: EdgeInsets.only(top: 10),
            onPressed: () {
              contactPresenter.add(context, source.custid.value);
            },
            prefixIcon: Icons.phone,
            label: Text('Add Contact'),
          )
        ],
      );
  }
}
