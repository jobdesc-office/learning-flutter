part of '../prospect_detail.dart';

BsCol prospectDetailTitleSection(context) {
  // ignore: invalid_use_of_protected_member
  var permis = authPresenter.rolepermis.value;
  final _navigation = Get.find<NavigationPresenter>();
  final presenter = Get.find<ProspectDetailPresenter>();
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
                              child: Text(
                                source.status.value,
                                style: TextStyle(
                                    color: source.statustextcolor.value),
                              ),
                              padding: EdgeInsets.fromLTRB(3, 2, 3, 2),
                              decoration: BoxDecoration(
                                  color: source.statuscolor.value,
                                  borderRadius: BorderRadius.circular(5)),
                            )
                        ],
                      ),
                      if (source.status.value == 'Closed Lost')
                        Row(
                          children: [
                            Obx(() => InkWell(
                                  onTap: () => source.status.value !=
                                              'Closed Lost' &&
                                          source.status.value != 'Closed Won' &&
                                          source.status.value != 'Force Closed'
                                      ? source.changeprospectvalue.value
                                          ? presenter.changevalue(
                                              context, source.prospectid.value)
                                          : null
                                      : null,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color:
                                              source.changeprospectvalue.value
                                                  ? ColorPallates.primary
                                                  : Color.fromARGB(
                                                      255, 207, 202, 202),
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
                                )),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'This Prospect Lost !',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  if (source.losttype.value != '')
                                    Text(source.losttype.value,
                                        style: TextStyle(fontSize: 14)),
                                  if (source.lostdesc.value != '')
                                    Text(source.lostdesc.value,
                                        style: TextStyle(fontSize: 12)),
                                  BsButton(
                                    size: BsButtonSize.btnSm,
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) => ConfirmDialog(
                                        title: BaseText.confirmTitle,
                                        message:
                                            'Are You Sure Want to Re-Open This Prospect ?',
                                        onPressed: (_, value) async {
                                          if (value ==
                                              ConfirmDialogOption.YES_OPTION) {
                                            StbptypeModel status =
                                                await presenter.status();
                                            SessionModel session =
                                                await SessionManager.current();
                                            Map<String, dynamic> body = {
                                              'prospectstatusid': status.sbtid,
                                              'createdby': session.userid,
                                              'updatedby': session.userid,
                                            };
                                            source.status.value =
                                                status.sbttypename ?? '';
                                            if (status.sbtremark != null) {
                                              Map<String, dynamic> color =
                                                  jsonDecode(
                                                      status.sbtremark ?? '');
                                              source.statuscolor.value = Color(
                                                  parseInt(color['color']));
                                              source.statustextcolor.value =
                                                  Color(parseInt(
                                                      color['textcolor']));
                                            } else {
                                              source.statuscolor.value =
                                                  Color.fromARGB(
                                                      0, 255, 255, 255);
                                              source.statustextcolor.value =
                                                  Color.fromARGB(255, 0, 0, 0);
                                            }
                                            presenter.update(context, body,
                                                source.prospectid.value);
                                            Navigator.pop(context);
                                          } else {
                                            presenter.setProcessing(false);
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    ),
                                    label: Text('Re-Open'),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      else if (source.status.value == 'Closed Won')
                        Row(
                          children: [
                            Obx(() => InkWell(
                                  onTap: () => source.status.value !=
                                              'Closed Lost' &&
                                          source.status.value != 'Closed Won' &&
                                          source.status.value != 'Force Closed'
                                      ? source.changeprospectvalue.value
                                          ? presenter.changevalue(
                                              context, source.prospectid.value)
                                          : null
                                      : null,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color:
                                              source.changeprospectvalue.value
                                                  ? ColorPallates.primary
                                                  : Color.fromARGB(
                                                      255, 207, 202, 202),
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
                                )),
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
                            Obx(() => InkWell(
                                  onTap: () => source.status.value !=
                                              'Closed Lost' &&
                                          source.status.value != 'Closed Won' &&
                                          source.status.value != 'Force Closed'
                                      ? source.changeprospectvalue.value
                                          ? presenter.changevalue(
                                              context, source.prospectid.value)
                                          : null
                                      : null,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color:
                                              source.changeprospectvalue.value
                                                  ? ColorPallates.primary
                                                  : Color.fromARGB(
                                                      255, 207, 202, 202),
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
                                )),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 10, bottom: 7),
                                      child: card),
                                  BsButton(
                                    size: BsButtonSize.btnSm,
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) => ConfirmDialog(
                                        title: BaseText.confirmTitle,
                                        message:
                                            'Are You Sure Want to Re-Open This Prospect ?',
                                        onPressed: (_, value) async {
                                          if (value ==
                                              ConfirmDialogOption.YES_OPTION) {
                                            StbptypeModel status =
                                                await presenter.status();
                                            SessionModel session =
                                                await SessionManager.current();
                                            Map<String, dynamic> body = {
                                              'prospectstatusid': status.sbtid,
                                              'createdby': session.userid,
                                              'updatedby': session.userid,
                                            };
                                            source.status.value =
                                                status.sbttypename ?? '';
                                            if (status.sbtremark != null) {
                                              Map<String, dynamic> color =
                                                  jsonDecode(
                                                      status.sbtremark ?? '');
                                              source.statuscolor.value = Color(
                                                  parseInt(color['color']));
                                              source.statustextcolor.value =
                                                  Color(parseInt(
                                                      color['textcolor']));
                                            } else {
                                              source.statuscolor.value =
                                                  Color.fromARGB(
                                                      0, 255, 255, 255);
                                              source.statustextcolor.value =
                                                  Color.fromARGB(255, 0, 0, 0);
                                            }
                                            presenter.update(context, body,
                                                source.prospectid.value);
                                            Navigator.pop(context);
                                          } else {
                                            presenter.setProcessing(false);
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    ),
                                    label: Text('Re-Open'),
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
                            Obx(() => InkWell(
                                  onTap: () => source.status.value !=
                                              'Closed Lost' &&
                                          source.status.value != 'Closed Won' &&
                                          source.status.value != 'Force Closed'
                                      ? source.changeprospectvalue.value
                                          ? presenter.changevalue(
                                              context, source.prospectid.value)
                                          : null
                                      : null,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color:
                                              source.changeprospectvalue.value
                                                  ? ColorPallates.primary
                                                  : Color.fromARGB(
                                                      255, 207, 202, 202),
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
                                )),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      BsButton(
                                        style: BsButtonStyle.success,
                                        onPressed: () async {
                                          int data =
                                              await presenter.wonStatus();
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
                                                        'prospectstatusid':
                                                            data,
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
                                  BsButton(
                                    margin: EdgeInsets.only(top: 3),
                                    style: BsButtonStyle.danger,
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) => ConfirmDialog(
                                        title: BaseText.confirmTitle,
                                        message:
                                            'Are You Sure Want to Force Closed This Prospect ?',
                                        onPressed: (_, value) async {
                                          if (value ==
                                              ConfirmDialogOption.YES_OPTION) {
                                            int status = await presenter
                                                .forceClosedStatus();
                                            SessionModel session =
                                                await SessionManager.current();
                                            Map<String, dynamic> body = {
                                              'prospectstatusid': status,
                                              'createdby': session.userid,
                                              'updatedby': session.userid,
                                            };
                                            source.status.value =
                                                'Force Closed';
                                            presenter.update(context, body,
                                                source.prospectid.value);
                                            Navigator.pop(context);
                                          } else {
                                            presenter.setProcessing(false);
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    ),
                                    label: Text('Force Closed'),
                                  )
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
