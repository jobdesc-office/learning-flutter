import 'package:boilerplate/styles/color_palattes.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contracts/default/information_view_contract.dart';
import '../../models/default/information_model.dart';
import '../../presenters/default/information_presenter.dart';
import "_source.dart";

final controller = Get.put(LoginSource());
final presenter = Get.put(InformationPresenter());

class BackgroundAuth extends GetView implements InformationViewContract {
  BackgroundAuth() {
    presenter.infoContract = this;
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BsRow(
        margin: EdgeInsets.only(top: 15, bottom: 20),
        children: [
          BsCol(
            margin: EdgeInsets.only(bottom: 20),
            sizes: ColScreen(lg: Col.col_2),
            child: Image.asset('assets/images/ventes-logo.png',
                width: 125, height: 64.5),
          ),
          BsCol(
            sizes: ColScreen(lg: Col.col_4),
          ),
          BsCol(
            margin: EdgeInsets.only(bottom: 20),
            sizes: ColScreen(lg: Col.col_6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    controller.what.toggle();
                    if (controller.about.value && controller.what.value) {
                      controller.about.value = !controller.what.value;
                    }
                    if (controller.what.value) {
                      presenter.getInfo('whatsventes');
                    }
                  },
                  child: Text("What's Ventes ?",
                      style:
                          TextStyle(fontSize: 18, color: ColorPallates.dark)),
                ),
                Text('Testimonials',
                    style: TextStyle(fontSize: 18, color: ColorPallates.dark)),
                InkWell(
                  onTap: () {
                    controller.about.toggle();
                    if (controller.what.value && controller.about.value) {
                      controller.what.value = !controller.about.value;
                    }
                    if (controller.about.value) {
                      presenter.getInfo('abouthyperdata');
                    }
                  },
                  child: Text('About Hyperdata',
                      style:
                          TextStyle(fontSize: 18, color: ColorPallates.dark)),
                )
              ],
            ),
          ),
          BsCol(
            sizes: ColScreen(lg: Col.col_4),
          ),
          BsCol(
            sizes: ColScreen(lg: Col.col_2),
          ),
          BsCol(
            alignment: Alignment.centerLeft,
            sizes: ColScreen(lg: Col.col_5),
            child: Obx(() => Column(
                  children: [
                    if (!controller.about.value && !controller.what.value)
                      Image.asset('assets/images/bg_auth.png'),
                    if (controller.about.value || controller.what.value)
                      Container(child: Text(controller.desc.value)),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  @override
  void onSuccess(Response response) {
    InformationModel model = InformationModel.fromJson(response.body);
    controller.desc.value = model.infodesc ?? '';
  }
}
