import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/masters/userdt_model.dart';
import '../../../presenters/masters/user_presenter.dart';
import '_details_source.dart';
import '_text.dart';

class UserDetails extends GetView implements DetailViewContract {
  final UserPresenter presenter = Get.find<UserPresenter>();
  final userDetailsSource c = Get.put(userDetailsSource());

  UserDetails() {
    presenter.userFetchDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.md,
          child: BsModalContent(children: [
            BsModalContainer(
              title: Text(UserText.title + ' Details'),
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
                                children: [Text('Username')],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [Text('Email')],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [Text('Phone')],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [Text('Role')],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [Text('Partner')],
                              ),
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
                              children: [Text(c.username.value)],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(c.email.value)],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(c.phone.value)],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(c.type.value)],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [Text(c.bp.value)],
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
    UserDetailModel dt = UserDetailModel.fromJson(response.body);
    c.name.value = dt.userfullname;
    c.username.value = dt.username;
    c.email.value = dt.useremail;
    c.phone.value = dt.userphone;
    c.type.value = dt.typename;
    c.bp.value = dt.bpname;
    c.active.value = dt.isactive;
  }
}
