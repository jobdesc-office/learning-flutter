import 'package:boilerplate/models/masters/type_model.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/base_text.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../presenters/ventes/prospect_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../widgets/confirm_dialog.dart';
import '../_detail_source.dart';
import '_stagePipeline.dart';

BsCol prospectDetailTitleSection(context) {
  final _navigation = Get.find<NavigationPresenter>();
  final presenter = Get.find<ProspectPresenter>();
  final source = Get.put(ProspectDetailsSource());
  final currencyFormatter = NumberFormat('#,##0.00', 'ID');
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
                                    fontSize: 18, fontWeight: FontWeight.bold));
                        }
                        return Row(
                          children: [
                            Text(
                              '${source.prospectname.value} | ',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            card
                          ],
                        );
                      }),
                      if (source.status.value == 'Closed Lost')
                        Row(
                          children: [
                            Column(
                              children: [
                                Text('This Prospect Lost !'),
                                BsButton(
                                  margin: EdgeInsets.only(top: 3),
                                  onPressed: () => presenter.losePopup(context),
                                  label: Text('Details'),
                                  size: BsButtonSize.btnSm,
                                )
                              ],
                            )
                          ],
                        )
                      else if (source.status.value == 'Closed Won')
                        Row(
                          children: [Text('This Prospect Won !')],
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            BsButton(
                              style: BsButtonStyle.success,
                              onPressed: () async {
                                int data = await presenter.wonStatus();
                                TypeModel stage =
                                    await presenter.completePipeline();
                                showDialog(
                                  context: context,
                                  builder: (context) => ConfirmDialog(
                                    title: BaseText.confirmTitle,
                                    message:
                                        'are you sure winning this prospect ?',
                                    onPressed: (_, value) async {
                                      if (value ==
                                          ConfirmDialogOption.YES_OPTION) {
                                        presenter.update(
                                            context,
                                            {
                                              'prospectstatusid': data,
                                              'prospectstageid': stage.typeid,
                                            },
                                            source.prospectid.value);
                                        source.status.value = 'Closed Won';
                                        source.prospectStageController
                                            .selected = stage;
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
                        )
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Obx(() => BsRow(
                    children: [
                      BsCol(
                          sizes: ColScreen(sm: Col.col_2),
                          child: Text('Rp ' +
                              currencyFormatter
                                  .format(
                                      double.parse(source.prospectvalue.value))
                                  .replaceAll(',00', '')
                                  .replaceAll('.', ','))),
                      BsCol(
                        sizes: ColScreen(sm: Col.col_10),
                        child: Container(
                          child: BsRow(
                            children: [
                              BsCol(
                                sizes: ColScreen(sm: Col.col_4),
                                child: Row(
                                  children: [
                                    Icon(Icons.person),
                                    Text(source.userfullname.value)
                                  ],
                                ),
                              ),
                              BsCol(
                                sizes: ColScreen(sm: Col.col_5),
                                child: Row(
                                  children: [
                                    Icon(Icons.domain),
                                    Text(source.bpname.value)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                child: BsRow(
                  margin: EdgeInsets.only(top: 10),
                  children: [
                    BsCol(
                      sizes: ColScreen(sm: Col.col_12),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: MenuTypeOptions(
                          controller: source.prospectStageController,
                        ),
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
