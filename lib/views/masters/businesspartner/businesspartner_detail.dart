import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/masters/businesspartner_model.dart';
import '../../../presenters/masters/businesspartner_presenter.dart';
import '_details_source.dart';
import '_text.dart';

class BusinessPartnerDetails extends GetView implements DetailViewContract {
  final BusinessPartnerPresenter presenter = Get.find<BusinessPartnerPresenter>();
  final BusinessPartnerDetailsSource c = Get.put(BusinessPartnerDetailsSource());

  BusinessPartnerDetails() {
    presenter.businessPartnerFetchDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.md,
          child: BsModalContent(children: [
            BsModalContainer(
              title: Text(BusinessPartnerText.title + ' Details'),
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
                                Text('Name'),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text('Type')
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text('PIC')
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text('Email')
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text('Phone')
                              ],
                            )
                          ],
                        )
                      ),
                      BsCol(
                        sizes: ColScreen(lg: Col.col_1),
                        child: Column(
                          children: [
                            Row( 
                              children: [
                                Text(' : ')
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(' : ')
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(' : ')
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(' : ')
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(' : ')
                              ],
                            )
                          ],
                        ),
                      ),
                      BsCol(
                        sizes: ColScreen(lg: Col.col_9),
                        child: Column(
                          children: [
                            Row( 
                              children: [
                                Text(c.name.value)
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(c.type.value)
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(c.pic.value)
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(c.email.value)
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row( 
                              children: [
                                Text(c.phone.value)
                              ],
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
    BusinessPartnerModel dt = BusinessPartnerModel.fromJson(response.body);
    c.name.value = dt.bpname;
    c.type.value = dt.typename;
    c.pic.value = dt.bppicname;
    c.email.value = dt.bpemail;
    c.phone.value = dt.bpphone;
  }
}
