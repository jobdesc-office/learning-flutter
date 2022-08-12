part of '../../prospect_detail.dart';

class _TabContact extends StatelessWidget {
  const _TabContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    final datatable = ProspectContactDataTableSource(source.contact.value);
    final contactPresenter = Get.find<ProspectContactPresenter>();
    datatable.onDetailsListener =
        (userid) => contactPresenter.detail(context, userid);
    datatable.onEditListener = (menuid) =>
        contactPresenter.edit(context, menuid, source.prospectid.value);
    datatable.onDeleteListener =
        (menuid, name) => contactPresenter.delete(context, menuid, name);
    if (source.contact.length != 0)
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Contacts of ' + source.custname.value + ' :',
                style: TextStyle(fontSize: 18),
              ),
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
          ),
          SingleChildScrollView(
            child: CustomDatabales(
              source: datatable,
              columns: datatable.columns,
              searchable: false,
            ),
          ),
        ],
      );
    else
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Contacts isn\'t Defined'),
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
