part of '../prospect_detail.dart';

BsCol prospectDetailTitleSection(context) {
  var permis = authPresenter.rolepermis.value;
  final _navigation = Get.find<NavigationPresenter>();
  final presenter = Get.find<ProspectPresenter>();
  final source = Get.put(ProspectDetailsSource());

  return BsCol(
    margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
    sizes: ColScreen(sm: Col.col_12),
    child: Obx(() => Container(
          decoration: BoxDecoration(
            color: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(children: [
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            return Row(
                              children: [
                                Text(
                                  '${source.prospectname.value}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text(' | '),
                                    Text(
                                      '${source.custname.value}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(' | '),
                                    Container(
                                      child: Text(
                                        '${source.custlabel.value}',
                                        style: TextStyle(
                                            color: source
                                                .custlabeltextcolor.value),
                                      ),
                                      padding: EdgeInsets.fromLTRB(3, 2, 3, 2),
                                      decoration: BoxDecoration(
                                          color: source.custlabelcolor.value,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  ],
                                )
                              ],
                            );
                          }),
                          if (source.status.value != 'Closed Lost' &&
                              source.status.value != 'Closed Won' &&
                              source.status.value != 'Force Closed')
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(source.status.value),
                            )
                        ],
                      ),
                      if (source.status.value == 'Closed Lost')
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 207, 202, 202),
                                  )),
                              child: Text(
                                  'Rp ' +
                                      currencyFormatter
                                          .format(double.parse(
                                              source.prospectvalue.value))
                                          .replaceAll(',00', '')
                                          .replaceAll('.', ','),
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                children: [
                                  Text(
                                    'This Prospect Lost !',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(source.losttype.value,
                                      style: TextStyle(fontSize: 14)),
                                  Text(source.lostdesc.value,
                                      style: TextStyle(fontSize: 12))
                                ],
                              ),
                            )
                          ],
                        )
                      else if (source.status.value == 'Closed Won')
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 207, 202, 202),
                                  )),
                              child: Text(
                                  'Rp ' +
                                      currencyFormatter
                                          .format(double.parse(
                                              source.prospectvalue.value))
                                          .replaceAll(',00', '')
                                          .replaceAll('.', ','),
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Obx(() {
                              Widget card = Text('${source.status.value}');
                              switch (source.status.value) {
                                case 'Closed Lost':
                                  card = Container(
                                    child: Text(
                                      '${source.status.value}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    padding: EdgeInsets.fromLTRB(3, 2, 3, 2),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5)),
                                  );
                                  break;
                                case 'Closed Won':
                                  card = Container(
                                    child: Text(
                                      '${source.status.value}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    padding: EdgeInsets.fromLTRB(3, 2, 3, 2),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(5)),
                                  );
                                  break;
                                default:
                                  Text('${source.status.value}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold));
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 10, bottom: 7),
                                      child: card),
                                  Container(
                                    child: Text(''),
                                  )
                                ],
                              );
                            })
                          ],
                        )
                      else if (source.status.value == 'Force Closed')
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 207, 202, 202),
                                  )),
                              child: Text(
                                  'Rp ' +
                                      currencyFormatter
                                          .format(double.parse(
                                              source.prospectvalue.value))
                                          .replaceAll(',00', '')
                                          .replaceAll('.', ','),
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Obx(() {
                              Widget card = Text('${source.status.value}');
                              switch (source.status.value) {
                                case 'Closed Lost':
                                  card = Container(
                                    child: Text(
                                      '${source.status.value}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    padding: EdgeInsets.fromLTRB(3, 2, 3, 2),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5)),
                                  );
                                  break;
                                case 'Closed Won':
                                  card = Container(
                                    child: Text(
                                      '${source.status.value}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    padding: EdgeInsets.fromLTRB(3, 2, 3, 2),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(5)),
                                  );
                                  break;
                                case 'Force Closed':
                                  card = Container(
                                    child: Text(
                                      '${source.status.value}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    padding: EdgeInsets.fromLTRB(3, 2, 3, 2),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5)),
                                  );
                                  break;
                                default:
                                  Text('${source.status.value}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold));
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 10, bottom: 7),
                                      child: card),
                                  Container(
                                    child: Text(''),
                                  )
                                ],
                              );
                            })
                          ],
                        )
                      else if (permis
                          .where((element) => element.menunm == 'Ventes Datas')
                          .first
                          .children!
                          .where((element) => element.menunm == 'Prospect')
                          .first
                          .features!
                          .where((element) => element.featslug == 'update')
                          .first
                          .permissions!
                          .hasaccess!)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 207, 202, 202),
                                  )),
                              child: Text(
                                  'Rp ' +
                                      currencyFormatter
                                          .format(double.parse(
                                              source.prospectvalue.value))
                                          .replaceAll(',00', '')
                                          .replaceAll('.', ','),
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  BsButton(
                                    style: BsButtonStyle.success,
                                    onPressed: () async {
                                      int data = await presenter.wonStatus();
                                      print(data);
                                      // TypeModel stage =
                                      //     await presenter.completePipeline();
                                      showDialog(
                                        context: context,
                                        builder: (context) => ConfirmDialog(
                                          title: BaseText.confirmTitle,
                                          message:
                                              'are you sure winning this prospect ?',
                                          onPressed: (_, value) async {
                                            if (value ==
                                                ConfirmDialogOption
                                                    .YES_OPTION) {
                                              presenter.update(
                                                  context,
                                                  {
                                                    'prospectenddate':
                                                        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
                                                    'prospectstatusid': data,
                                                    // 'prospectstageid':
                                                    //     stage.typeid,
                                                  },
                                                  source.prospectid.value);
                                              source.status.value =
                                                  'Closed Won';
                                              // source.prospectStageController
                                              //     .value.selected = stage;
                                            } else {
                                              Navigator.pop(context);
                                            }
                                          },
                                        ),
                                      );
                                    },
                                    label: Text('Won'),
                                  ),
                                  BsButton(
                                    margin: EdgeInsets.only(left: 10),
                                    style: BsButtonStyle.danger,
                                    onPressed: () {
                                      presenter.lose(
                                          context, source.prospectid.value);
                                    },
                                    label: Text('Lost'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                child: BsRow(
                  children: [
                    if (source.showPipeline.value)
                      BsCol(
                        sizes: ColScreen(sm: Col.col_12),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Obx(() => MenuTypeOptions(
                                controller:
                                    source.prospectStageController.value,
                              )),
                        ),
                      ),
                  ],
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(source.status.value),
              //     Text(source.prospectstartdate.value),
              //   ],
              // )
            ]),
          ),
        )),
  );
}
