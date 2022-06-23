import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/masters/customer_model.dart';
import '../../../models/ventes/bpcustomer_model.dart';
import '../../../presenters/masters/customer_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/ventes/bpcustomer_presenter.dart';
import '../../../styles/color_palattes.dart';
import '_details_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class BpCustomerDetails extends GetView implements DetailViewContract {
  final BpCustomerPresenter presenter = Get.find<BpCustomerPresenter>();
  final BpCustomerDetailsSource controller = Get.put(BpCustomerDetailsSource());

  BpCustomerDetails() {
    presenter.bpCustomerDetailViewContract = this;
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
                  title: Text(BpCustomerText.title + ' Details',
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
                            sizes: ColScreen(lg: Col.col_4),
                            child: Container(
                              child: Image.network(controller.pic.value),
                            ),
                          ),
                          BsCol(
                            sizes: ColScreen(lg: Col.col_8),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: BsRow(
                                children: [
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_3),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Name',
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Phone',
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Address',
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_1),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              ':',
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              ':',
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              ':',
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_8),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              controller.name.value,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              controller.phone.value,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        BsRow(
                                          children: [
                                            BsCol(
                                              child: Text(
                                                controller.address.value,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BsCol(
                            sizes: ColScreen(lg: Col.col_12),
                            // child: Container(
                            //     color: Colors.amber, width: 200, height: 200),
                          ),
                        ],
                      )),
                )
              ]),
        ));
  }

  @override
  void onSuccessFetchData(Response response) {
    BusinessPartnerCustomerModel dt =
        BusinessPartnerCustomerModel.fromJson(response.body);
    controller.name.value = dt.sbccstmname.toString();
    controller.phone.value = dt.sbccstmphone.toString();
    controller.address.value = dt.sbccstmaddress.toString();
    controller.pic.value = dt.sbccstmpic ??
        'https://cdn.icon-icons.com/icons2/1674/PNG/512/person_110935.png';
    presenter.setProcessing(false);
  }
}
