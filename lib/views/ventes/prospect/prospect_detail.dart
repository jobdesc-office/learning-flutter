import 'package:boilerplate/widgets/datatables/custom_datatable.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/masters/businesspartner_model.dart';
import '../../../presenters/masters/businesspartner_presenter.dart';

class ProspectDetails extends GetView implements DetailViewContract {
  // final BusinessPartnerPresenter presenter = Get.find<BusinessPartnerPresenter>();
  // final BusinessPartnerDetailsSource c = Get.put(BusinessPartnerDetailsSource());

  ProspectDetails() {
    // presenter.businessPartnerFetchDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.md,
          child: BsModalContent(children: [
            BsModalContainer(
              title: Text(' Details'),
              closeButton: true,
            ),
            BsModalContainer(
              child: Column(
                children: [
                  Card(
                    color: Colors.grey[350],
                    child: Column(
                      children: [
                        Text(
                          'ABCompany',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text('Londong gg.07')
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]),
        ));
  }

  @override
  void onSuccessFetchData(Response response) {
    // BusinessPartnerModel dt = BusinessPartnerModel.fromJson(response.body);
    // c.name.value = dt.bpname;
    // c.type.value = dt.typename;
    // c.pic.value = dt.bppicname;
    // c.email.value = dt.bpemail;
    // c.phone.value = dt.bpphone;
  }
}
