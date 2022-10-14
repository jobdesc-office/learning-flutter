import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../presenters/navigation_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../_detail_source.dart';

final _navigation = Get.find<NavigationPresenter>();
final currencyFormatter = NumberFormat('#,##0.00', 'ID');
final source = Get.put(ProspectDetailsSource());

class OrganizationSection extends StatelessWidget {
  const OrganizationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          // height: 160,
          decoration: BoxDecoration(
            color: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Company and Owner Info',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(source.userfullname.value))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Icon(Icons.domain),
                          Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(source.bpname.value))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Icon(Icons.code),
                          Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(source.prospectCode.value))
                        ],
                      ),
                    ),
                    if (source.prospectRef.value != '')
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Icon(Icons.domain),
                            Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(source.prospectRef.value))
                          ],
                        ),
                      ),
                  ],
                ),
              )),
        ));
  }
}
