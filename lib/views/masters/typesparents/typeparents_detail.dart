import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/masters/type_model.dart';
import '../../../presenters/masters/typeparent_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../styles/color_palattes.dart';
import '_detail_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class TypeParentDetails extends GetView implements DetailViewContract {
  final TypeParentPresenter presenter = Get.find<TypeParentPresenter>();
  final TypeParentDetailsSource c = Get.put(TypeParentDetailsSource());

  TypeParentDetails() {
    presenter.typeParentDataDetailsContract = this;
  }

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
                    : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              children: [
                BsModalContainer(
                  title: Text(TypeParentsText.title + ' Details',
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black)),
                  closeButton: true,
                ),
                BsModalContainer(
                  child: Obx(() => BsRow(
                        children: [
                          BsCol(
                              sizes: ColScreen(lg: Col.col_2),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Code'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [Text('Name')],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [Text('Seq')],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [Text('Description')],
                                  )
                                ],
                              )),
                          BsCol(
                            sizes: ColScreen(lg: Col.col_1),
                            child: Column(
                              children: [
                                Row(
                                  children: [Text(' : ')],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [Text(' : ')],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [Text(' : ')],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [Text(' : ')],
                                ),
                              ],
                            ),
                          ),
                          BsCol(
                            sizes: ColScreen(lg: Col.col_9),
                            child: Column(
                              children: [
                                Row(
                                  children: [Text(c.cd.value)],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [Text(c.name.value)],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [Text(c.seq.value)],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [Text(c.desc.value)],
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                )
              ]),
        ));
  }

  @override
  void onSuccessFetchData(Response response) {
    TypeModel dt = TypeModel.fromJson(response.body);
    c.cd.value = dt.typecd;
    c.name.value = dt.typename;
    c.desc.value = dt.description;
    c.seq.value = dt.typeseq.toString();
  }
}
