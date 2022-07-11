import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../presenters/auth_presenter.dart';
import '../../../../presenters/navigation_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../widgets/datatables/custom_datatable.dart';
import '../_detail_source.dart';

final _navigation = Get.find<NavigationPresenter>();

class LostPopup extends GetView {
  final source = Get.find<prospectDetailsSource>();
  @override
  Widget build(BuildContext context) {
    return BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.md,
          child: BsModalContent(
              decoration: BoxDecoration(
                color: _navigation.darkTheme.value
                    ? ColorPallates.elseDarkColor
                    : Color(0xfff1f1f1),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              children: [
                BsModalContainer(
                  title: Text('Lost Details',
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black)),
                  closeButton: true,
                ),
                BsModalContainer(
                    child: Column(
                  children: [
                    BsRow(
                      children: [
                        BsCol(
                          sizes: ColScreen(sm: Col.col_3),
                          child: Text('Lost type'),
                        ),
                        BsCol(
                          sizes: ColScreen(sm: Col.col_1),
                          child: Text(':'),
                        ),
                        BsCol(
                          sizes: ColScreen(sm: Col.col_8),
                          child: Text(source.losttype.value),
                        )
                      ],
                    ),
                    BsRow(
                      margin: EdgeInsets.only(top: 10),
                      children: [
                        BsCol(
                          sizes: ColScreen(sm: Col.col_3),
                          child: Text('Description'),
                        ),
                        BsCol(
                          sizes: ColScreen(sm: Col.col_1),
                          child: Text(':'),
                        ),
                        BsCol(
                          sizes: ColScreen(sm: Col.col_8),
                          child: Text(source.lostdesc.value),
                        )
                      ],
                    )
                  ],
                ))
              ]),
        ));
  }
}
