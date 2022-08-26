part of '../../prospect_detail.dart';

final source = Get.put(ProspectDetailsSource());

class _TabContact extends StatelessWidget {
  const _TabContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: invalid_use_of_protected_member
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
                children: source.contact
                    .map((element) => Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Color.fromARGB(255, 207, 202, 202),
                          )),
                          margin: EdgeInsets.only(top: 5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    element.contactname ?? '',
                                    style: TextStyle(fontSize: 21),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                          onTap: () => contactPresenter.detail(
                                              context,
                                              element.contactpersonid!),
                                          child: Icon(Icons.remove_red_eye)),
                                      InkWell(
                                          onTap: () => contactPresenter.edit(
                                              context,
                                              element.contactpersonid!,
                                              element.contactcustomerid!),
                                          child: Icon(Icons.edit)),
                                      InkWell(
                                          onTap: () => contactPresenter.delete(
                                              context,
                                              element.contactpersonid!,
                                              element.contactname ?? ''),
                                          child: Icon(Icons.delete))
                                    ],
                                  )
                                ],
                              ),
                              BsRow(
                                margin: EdgeInsets.only(top: 5),
                                children: [
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_4),
                                    child: Text(
                                        '${element.contacttype?.typename ?? ''} :'),
                                  ),
                                  BsCol(
                                      sizes: ColScreen(sm: Col.col_8),
                                      child: Text(element.contactvalueid ?? ''))
                                ],
                              ),
                            ],
                          ),
                        ))
                    .toList())
          ],
        ),
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
