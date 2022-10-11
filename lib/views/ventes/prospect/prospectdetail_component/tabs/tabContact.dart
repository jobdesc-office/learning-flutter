part of '../../prospect_detail.dart';

final source = Get.put(ProspectDetailsSource());

class _TabContact extends StatelessWidget {
  const _TabContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var permis = authPresenter.rolepermis.value;
    // ignore: invalid_use_of_protected_member
    source.contactname.value = '';
    final contactPresenter = Get.find<ProspectContactPresenter>();
    if (source.contact.length != 0)
      return SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Contacts of ' + source.custname.value + ' :',
                  style: TextStyle(fontSize: 18),
                ),
                if (source.status.value != ProspectText.closedWon &&
                    source.status.value != ProspectText.closedLost &&
                    source.status.value != ProspectText.forceClosed)
                  if (permis
                      .where((element) => element.menunm == 'Ventes Datas')
                      .first
                      .children!
                      .where((element) => element.menunm == 'Prospect')
                      .first
                      .features!
                      .where((element) => element.featslug == 'create')
                      .first
                      .permissions!
                      .hasaccess!)
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
            Column(
                children: source.contact.map((element) {
              if (source.contactname.value == element.contactname) {
                return Container();
              } else {
                source.contactname.value = element.contactname ?? '';
                return Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Color.fromARGB(255, 207, 202, 202),
                  )),
                  margin: EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        element.contactname ?? '',
                        style: TextStyle(fontSize: 21),
                      ),
                      Column(
                          children: source.contact
                              .where(
                                  (p0) => p0.contactname == element.contactname)
                              .toList()
                              .map(
                                (e) => BsRow(
                                  margin: EdgeInsets.only(top: 5),
                                  children: [
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_2),
                                      child: Text(
                                          '${e.contacttype?.typename ?? ''} :'),
                                    ),
                                    BsCol(
                                        sizes: ColScreen(sm: Col.col_8),
                                        child: Text(e.contactvalueid ?? '')),
                                    BsCol(
                                        sizes: ColScreen(sm: Col.col_2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Tooltip(
                                              message: BaseText.detailHintDatatable(
                                                  field:
                                                      '${e.contactname}\'s ${e.contacttype?.typename}'),
                                              child: InkWell(
                                                  onTap: () =>
                                                      contactPresenter.detail(
                                                          context,
                                                          e.contactpersonid!),
                                                  child: Icon(
                                                      Icons.remove_red_eye)),
                                            ),
                                            if (source.status.value !=
                                                    ProspectText.closedWon &&
                                                source.status.value !=
                                                    ProspectText.closedLost &&
                                                source.status.value !=
                                                    ProspectText.forceClosed)
                                              if (permis
                                                  .where((element) =>
                                                      element.menunm ==
                                                      'Ventes Datas')
                                                  .first
                                                  .children!
                                                  .where((element) =>
                                                      element.menunm ==
                                                      'Prospect')
                                                  .first
                                                  .features!
                                                  .where((element) =>
                                                      element.featslug ==
                                                      'update')
                                                  .first
                                                  .permissions!
                                                  .hasaccess!)
                                                Tooltip(
                                                  message: BaseText
                                                      .editHintDatatable(
                                                          field:
                                                              '${e.contactname}\'s ${e.contacttype?.typename}'),
                                                  child: InkWell(
                                                      onTap: () =>
                                                          contactPresenter.edit(
                                                              context,
                                                              e.contactpersonid!,
                                                              e.contactbpcustomerid!),
                                                      child: Icon(Icons.edit)),
                                                ),
                                            if (source.status.value !=
                                                    ProspectText.closedWon &&
                                                source.status.value !=
                                                    ProspectText.closedLost &&
                                                source.status.value !=
                                                    ProspectText.forceClosed)
                                              if (permis
                                                  .where((element) =>
                                                      element.menunm ==
                                                      'Ventes Datas')
                                                  .first
                                                  .children!
                                                  .where((element) =>
                                                      element.menunm ==
                                                      'Prospect')
                                                  .first
                                                  .features!
                                                  .where((element) =>
                                                      element.featslug ==
                                                      'delete')
                                                  .first
                                                  .permissions!
                                                  .hasaccess!)
                                                Tooltip(
                                                  message: BaseText
                                                      .deleteHintDatatable(
                                                          field:
                                                              '${e.contactname}\'s ${e.contacttype?.typename}'),
                                                  child: InkWell(
                                                      onTap: () =>
                                                          contactPresenter.delete(
                                                              context,
                                                              e.contactpersonid!,
                                                              '${e.contactname}\'s ${e.contacttype?.typename}'),
                                                      child: Icon(Icons.delete)),
                                                )
                                          ],
                                        ))
                                  ],
                                ),
                              )
                              .toList()),
                    ],
                  ),
                );
              }
            }).toList())
          ],
        ),
      );
    else
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Contacts isn\'t Defined'),
          if (source.status.value != ProspectText.closedWon &&
              source.status.value != ProspectText.closedLost &&
              source.status.value != ProspectText.forceClosed)
            if (permis
                .where((element) => element.menunm == 'Ventes Datas')
                .first
                .children!
                .where((element) => element.menunm == 'Prospect')
                .first
                .features!
                .where((element) => element.featslug == 'create')
                .first
                .permissions!
                .hasaccess!)
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
