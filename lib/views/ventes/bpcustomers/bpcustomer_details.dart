import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/masters/customer_model.dart';
import '../../../presenters/masters/customer_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../styles/color_palattes.dart';
import '_details_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class CustomerDetails extends GetView implements DetailViewContract {
  final CustomerPresenter presenter = Get.find<CustomerPresenter>();
  final CustomerDetailsSource controller = Get.put(CustomerDetailsSource());

  CustomerDetails() {
    presenter.customerDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.xl,
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
                              sizes: ColScreen(lg: Col.col_3),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Prefix'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [Text('Name')],
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
                                    children: [Text('Address')],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [Text('Type')],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [Text('Province')],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [Text('City')],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [Text('Subdistrict')],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [Text('MUV')],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [Text('Postal Code')],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [Text('Latitude')],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [Text('Longitude')],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [Text('Referal Code')],
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
                            sizes: ColScreen(lg: Col.col_8),
                            child: Column(
                              children: [
                                Row(
                                  children: [Text(controller.prefix.value)],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [Text(controller.name.value)],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [Text(controller.phone.value)],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [Text(controller.address.value)],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [Text(controller.type.value)],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [Text(controller.province.value)],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [Text(controller.city.value)],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text(controller.subdistrict.value)
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [Text(controller.muv.value)],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [Text(controller.postal.value)],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [Text(controller.latitude.value)],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [Text(controller.longitude.value)],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [Text(controller.referal.value)],
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
    CustomerModel dt = CustomerModel.fromJson(response.body);
    controller.prefix.value = dt.cstmprefix;
    controller.name.value = dt.cstmname;
    controller.phone.value = dt.cstmphone;
    controller.address.value = dt.cstmaddress;
    controller.type.value = dt.typename;
    controller.province.value = dt.provname;
    controller.city.value = dt.cityname;
    controller.subdistrict.value = dt.subdistrictname;
    controller.muv.value = dt.cstmuvid.toString();
    controller.postal.value = dt.cstmpostalcode;
    controller.latitude.value = dt.cstmlatitude.toString();
    controller.longitude.value = dt.cstmlongitude.toString();
    controller.referal.value = dt.referalcode;
  }
}
