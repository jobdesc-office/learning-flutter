import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../presenters/navigation_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../_detail_source.dart';

BsCol prospectDetailOrganizationSection(context) {
  final _navigation = Get.find<NavigationPresenter>();
  final source = Get.put(ProspectDetailsSource());
  return BsCol(
    margin: EdgeInsets.only(top: 5),
    child: Obx(() => Container(
          decoration: BoxDecoration(
            color: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Organization'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BsButton(
                            onPressed: () {},
                            label: Icon(
                              Icons.edit,
                              size: 13,
                            )),
                        // BsButton(
                        //     onPressed: () {},
                        //     label: Icon(
                        //       Icons.edit,
                        //       size: 13,
                        //     )),
                        // BsButton(
                        //     onPressed: () {},
                        //     label: Icon(
                        //       Icons.edit,
                        //       size: 13,
                        //     )),
                        // BsButton(
                        //     onPressed: () {},
                        //     label: Icon(
                        //       Icons.edit,
                        //       size: 13,
                        //     )),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              child: Icon(Icons.domain),
                            ),
                            Text('Address')
                          ],
                        ),
                        Text(source.bpname.value)
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        "Title",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      children: <Widget>[
                        ListTile(
                          subtitle:
                              Text('data data data data data data data data'),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        )),
  );
}
