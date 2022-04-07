import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/masters/type_model.dart';
import '../../../presenters/masters/typechildren_presenter.dart';
import '_detail_source.dart';
import '_text.dart';

class TypeChildrenDetails extends GetView implements DetailViewContract {
  final TypesChildrenPresenter presenter = Get.find<TypesChildrenPresenter>();
  final TypeChildrenDetailsSource c = Get.put(TypeChildrenDetailsSource());

  TypeChildrenDetails() {
    presenter.typeChildrenDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.md,
          child: BsModalContent(children: [
            BsModalContainer(
              title: Text(TypeChildrenText.title + ' Details'),
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
                          ],
                        ),
                      ),
                      BsCol(
                        sizes: ColScreen(lg: Col.col_9),
                        child: Column(
                          children: [
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
                            ),
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
    c.name.value = dt.typename;
    c.desc.value = dt.description;
    c.seq.value = dt.typeseq.toString();
  }
}
