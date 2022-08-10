part of '../../prospect_detail.dart';

class _tabContact extends StatelessWidget {
  const _tabContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactPresenter = Get.find<ProspectContactPresenter>();
    if (source.contact.length != 0)
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Contact of ${source.custname.value} : ',
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
            ),
            Obx(() => Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: source.contact.length,
                    itemBuilder: (context, index) {
                      var contacts = source.contact[index];
                      return Tooltip(
                        message: BaseText.editDelete,
                        child: InkWell(
                          onLongPress: () => Get.defaultDialog(
                              middleText: '',
                              title: 'Setting',
                              actions: [
                                ButtonEditDatatables(onPressed: () {
                                  contactPresenter.edit(
                                      context,
                                      contacts.contactpersonid!,
                                      source.custid.value);
                                }),
                                ButtonDeleteDatatables(onPressed: () {
                                  contactPresenter.delete(
                                      context,
                                      contacts.contactpersonid!,
                                      '${contacts.contactname}');
                                }),
                              ]),
                          onTap: () => contactPresenter.detail(
                              context, contacts.contactpersonid!),
                          child: BsRow(
                            margin: source.contact[index] == 0
                                ? EdgeInsets.zero
                                : EdgeInsets.only(top: 20),
                            children: [
                              BsCol(
                                sizes: ColScreen(sm: Col.col_1),
                                child: Text('${index + 1} )'),
                              ),
                              BsCol(
                                sizes: ColScreen(sm: Col.col_11),
                                child: BsRow(
                                  children: [
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_2),
                                      child: Text("Name"),
                                    ),
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_1),
                                      child: Text(':'),
                                    ),
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_9),
                                      child: Text(contacts.contactname ?? ''),
                                    ),
                                    BsCol(
                                      margin: EdgeInsets.only(top: 5),
                                      sizes: ColScreen(sm: Col.col_2),
                                      child: Text("Value"),
                                    ),
                                    BsCol(
                                      margin: EdgeInsets.only(top: 5),
                                      sizes: ColScreen(sm: Col.col_1),
                                      child: Text(':'),
                                    ),
                                    BsCol(
                                      margin: EdgeInsets.only(top: 5),
                                      sizes: ColScreen(sm: Col.col_9),
                                      child:
                                          Text(contacts.contactvalueid ?? ''),
                                    ),
                                    BsCol(
                                      margin: EdgeInsets.only(top: 5),
                                      sizes: ColScreen(sm: Col.col_2),
                                      child: Text("Type"),
                                    ),
                                    BsCol(
                                      margin: EdgeInsets.only(top: 5),
                                      sizes: ColScreen(sm: Col.col_1),
                                      child: Text(':'),
                                    ),
                                    BsCol(
                                      margin: EdgeInsets.only(top: 5),
                                      sizes: ColScreen(sm: Col.col_9),
                                      child: Text(
                                          contacts.contacttype!.typename ?? ''),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ))
          ],
        ),
      );
    else
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Contacts is\' Defined'),
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
