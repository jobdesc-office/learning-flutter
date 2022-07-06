import 'package:boilerplate/styles/color_palattes.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/masters/user_model.dart';
import '../../../models/masters/userdt_model.dart';
import '../../../presenters/auth_presenter.dart';
import '../../../presenters/masters/user_presenter.dart';
import '_profile_profile_source.dart';

class ProfileProfileView extends GetView implements DetailViewContract {
  final presenter = Get.find<UserPresenter>();
  final _auth = Get.find<AuthPresenter>();
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
            sizes: ColScreen(sm: Col.col_5),
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
                          child: Icon(
                            Icons.person,
                            size: 200,
                          ),
                          backgroundColor: ColorPallates.primary,
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
                          margin: EdgeInsets.only(top: 10),
                          children: [
                            // BsCol(
                            //   sizes: ColScreen(sm: Col.col_12),
                            //   child: ListView.builder(
                            //       shrinkWrap: true,
                            //       itemCount: _auth.detail.length,
                            //       itemBuilder: ((context, index) {
                            //         var details = _auth.detail[index];
                            //         return InkWell(
                            //           onTap: () {
                            //             Get.defaultDialog(
                            //                 actions: [
                            //                   BsButton(
                            //                     style: BsButtonStyle.success,
                            //                     onPressed: () {
                            //                       Navigator.pop(context);
                            //                     },
                            //                     label: Text('Ok'),
                            //                   )
                            //                 ],
                            //                 title: 'Warning',
                            //                 middleText:
                            //                     'Your Current Role is ${_auth.roleActive.value}\nYour Current Business Partner is ${_auth.bpActive.value}');
                            //           },
                            //           child: Container(
                            //             margin: _auth.detail[index] == 0
                            //                 ? EdgeInsets.zero
                            //                 : EdgeInsets.only(top: 10),
                            //             child: Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.spaceBetween,
                            //               children: [
                            //                 Text(details!.usertype!.typename),
                            //                 Text(details!
                            //                     .businesspartner!.bpname),
                            //               ],
                            //             ),
                            //           ),
                            //         );
                            //       })),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BsCol(
            margin: EdgeInsets.only(left: 10),
            sizes: ColScreen(sm: Col.col_7),
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
                                        style: TextStyle(fontSize: 18))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text('Phone',
                                        style: TextStyle(fontSize: 18))
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
                                    Text(':', style: TextStyle(fontSize: 18))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(':', style: TextStyle(fontSize: 18))
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
                                            style: TextStyle(fontSize: 18))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(control.userphone.value,
                                            style: TextStyle(fontSize: 18))
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
    UserModel dt = UserModel.fromJson(response.body);
    control.userfullname.value = dt.userfullname!;
    control.username.value = dt.username!;
    control.useremail.value = dt.useremail!;
    control.userphone.value = dt.userphone!;
    control.userrole.value = dt.userdetails!.first.usertype!.typename!;
    control.userbp.value = dt.userdetails!.first.businesspartner!.bpname!;
  }
}
