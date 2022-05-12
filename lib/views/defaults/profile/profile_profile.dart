import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/masters/userdt_model.dart';
import '../../../presenters/masters/user_presenter.dart';
import '_profile_profile_source.dart';

class ProfileProfileView extends GetView implements DetailViewContract {
  final presenter = Get.find<UserPresenter>();
  final control = Get.put(ProfileProfileSource());
  final box = GetStorage();

  ProfileProfileView() {
    presenter.userFetchDataDetailsContract = this;
    presenter.myProfile(box.read('id'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: BsRow(
        children: [
          BsCol(
            sizes: ColScreen(sm: Col.col_3),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade300)),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/photos/novan.jpg'),
                          radius: 120,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Obx(() => Column(
                                children: [
                                  Text(
                                    control.userfullname.value,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text('a.k.a', style: TextStyle(fontSize: 14)),
                                  Text(
                                    control.username.value,
                                    style: TextStyle(fontSize: 21),
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.shade300)),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        BsRow(
                          alignment: Alignment.center,
                          children: [
                            BsCol(
                              sizes: ColScreen(sm: Col.col_12),
                              child: Obx(() => Column(
                                    children: [
                                      Text(control.userrole.value,
                                          style: TextStyle(fontSize: 22)),
                                    ],
                                  )),
                            ),
                            BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(sm: Col.col_12),
                              child: Obx(() => Column(
                                    children: [
                                      Text(control.userbp.value,
                                          style: TextStyle(fontSize: 14)),
                                    ],
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BsCol(
            margin: EdgeInsets.only(left: 10),
            sizes: ColScreen(sm: Col.col_9),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.shade300)),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: BsRow(
                        children: [
                          BsCol(
                            sizes: ColScreen(sm: Col.col_2),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Email',
                                        style: TextStyle(fontSize: 24))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text('Phone',
                                        style: TextStyle(fontSize: 24))
                                  ],
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Row(
                                //   children: [
                                //     Text('data', style: TextStyle(fontSize: 24))
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Row(
                                //   children: [
                                //     Text('data', style: TextStyle(fontSize: 24))
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Row(
                                //   children: [
                                //     Text('data', style: TextStyle(fontSize: 24))
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Row(
                                //   children: [
                                //     Text('data', style: TextStyle(fontSize: 24))
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Row(
                                //   children: [
                                //     Text('data', style: TextStyle(fontSize: 24))
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Row(
                                //   children: [
                                //     Text('data', style: TextStyle(fontSize: 24))
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                          BsCol(
                            sizes: ColScreen(sm: Col.col_1),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(':', style: TextStyle(fontSize: 24))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(':', style: TextStyle(fontSize: 24))
                                  ],
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Row(
                                //   children: [
                                //     Text(':', style: TextStyle(fontSize: 24))
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Row(
                                //   children: [
                                //     Text(':', style: TextStyle(fontSize: 24))
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Row(
                                //   children: [
                                //     Text(':', style: TextStyle(fontSize: 24))
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Row(
                                //   children: [
                                //     Text(':', style: TextStyle(fontSize: 24))
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Row(
                                //   children: [
                                //     Text(':', style: TextStyle(fontSize: 24))
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Row(
                                //   children: [
                                //     Text(':', style: TextStyle(fontSize: 24))
                                //   ],
                                // )
                              ],
                            ),
                          ),
                          BsCol(
                            sizes: ColScreen(sm: Col.col_9),
                            child: Obx(() => Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(control.useremail.value,
                                            style: TextStyle(fontSize: 24))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(control.userphone.value,
                                            style: TextStyle(fontSize: 24))
                                      ],
                                    ),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text('data', style: TextStyle(fontSize: 24))
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text('data', style: TextStyle(fontSize: 24))
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text('data', style: TextStyle(fontSize: 24))
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text('data', style: TextStyle(fontSize: 24))
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text('data', style: TextStyle(fontSize: 24))
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text('data', style: TextStyle(fontSize: 24))
                                    //   ],
                                    // )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void onSuccessFetchData(Response response) {
    UserDetailModel dt = UserDetailModel.fromJson(response.body);
    control.userfullname.value = dt.userfullname;
    control.username.value = dt.username;
    control.useremail.value = dt.useremail;
    control.userphone.value = dt.userphone;
    control.userrole.value = dt.typename;
    control.userbp.value = dt.bpname;
  }
}
