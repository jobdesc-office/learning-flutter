import 'package:boilerplate/models/masters/user_model.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../presenters/masters/user_presenter.dart';
import '../../../widgets/button/theme_button_cancel.dart';
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
                              children: [
                                Text('Username')
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
                            ),
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
                                Text(c.username.value)
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
    UserModel dt = UserModel.fromJson(response.body);
    c.name.value = dt.userfullname;
    c.username.value = dt.username;
    c.email.value = dt.useremail;
    c.phone.value = dt.userphone;
    c.active.value = dt.isactive;
  }
}
