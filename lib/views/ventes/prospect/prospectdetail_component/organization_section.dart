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
          height: 100,
          decoration: BoxDecoration(
            color: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Rp ' +
                          currencyFormatter
                              .format(double.parse(source.prospectvalue.value))
                              .replaceAll(',00', '')
                              .replaceAll('.', ',')),
                      Row(
                        children: [
                          Icon(Icons.person),
                          Text(source.userfullname.value)
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.domain),
                            Text(source.bpname.value)
                          ],
                        ),
                        Text(source.custname.value),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}
