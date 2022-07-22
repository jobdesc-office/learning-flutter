import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gallery_3d/gallery3d.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/masters/competitor_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/ventes/competitor_presenter.dart';
import '../../../styles/color_palattes.dart';
import '_details_source.dart';
import '_text.dart';
import 'image_picture_competitor.dart';

final _navigation = Get.find<NavigationPresenter>();

class CompetitorDetails extends GetView implements DetailViewContract {
  final CompetitorPresenter presenter = Get.find<CompetitorPresenter>();
  final CompetitorDetailsSource controller = Get.put(CompetitorDetailsSource());

  CompetitorDetails() {
    presenter.competitorDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.lg,
          child: BsModalContent(
              decoration: BoxDecoration(
                color: _navigation.darkTheme.value
                    ? ColorPallates.elseDarkColor
                    : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              children: [
                BsModalContainer(
                  title: Text(CompetitorText.title + ' Details',
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
                            margin: EdgeInsets.only(right: 10),
                            sizes: ColScreen(sm: Col.col_5),
                            child: BsRow(
                              children: [
                                if (controller.pic.length >= 3)
                                  BsCol(
                                      alignment: Alignment.center,
                                      child: Gallery3D(
                                          onClickItem: (value) {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  ImagePictureCompetitor(
                                                title: controller.title[value],
                                                image: controller.pic[value],
                                              ),
                                            );
                                          },
                                          delayTime: 1500,
                                          width: 300,
                                          itemConfig: GalleryItemConfig(
                                            width: 300,
                                            height: 280,
                                            isShowTransformMask: false,
                                          ),
                                          itemCount: controller.pic.length,
                                          itemBuilder: (context, index) {
                                            return Tooltip(
                                              message:
                                                  'Tap to See Full Picture',
                                              child: Image.network(
                                                controller.pic[index],
                                                fit: BoxFit.fill,
                                              ),
                                            );
                                          })),
                                if (controller.pic.length == 2)
                                  BsCol(
                                    child: Row(
                                      children: [
                                        Tooltip(
                                          message: 'Tap to See Full Picture',
                                          child: Image.network(
                                            controller.pic.first,
                                            width: 150,
                                            height: 130,
                                          ),
                                        ),
                                        Tooltip(
                                          message: 'Tap to See Full Picture',
                                          child: Image.network(
                                            controller.pic.last,
                                            width: 150,
                                            height: 130,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (controller.pic.length == 1)
                                  BsCol(
                                    child: Tooltip(
                                      message: 'Tap to See Full Image',
                                      child: Image.network(
                                        controller.pic.first,
                                        width: 250,
                                        height: 120,
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                          BsCol(
                            sizes: ColScreen(sm: Col.col_7),
                            child: BsRow(children: [
                              BsCol(
                                  margin: EdgeInsets.only(top: 10),
                                  sizes: ColScreen(lg: Col.col_12),
                                  child: BsRow(
                                    children: [
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_4),
                                          child: Text('Name')),
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_1),
                                          child: Text(':')),
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_7),
                                          child: Text(controller.name.value))
                                    ],
                                  )),
                              BsCol(
                                  margin: EdgeInsets.only(top: 10),
                                  sizes: ColScreen(lg: Col.col_12),
                                  child: BsRow(
                                    children: [
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_4),
                                          child: Text('Product Name')),
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_1),
                                          child: Text(':')),
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_7),
                                          child: Text(controller.product.value))
                                    ],
                                  )),
                              BsCol(
                                  margin: EdgeInsets.only(top: 10),
                                  sizes: ColScreen(lg: Col.col_12),
                                  child: BsRow(
                                    children: [
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_4),
                                          child: Text('Business Partner')),
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_1),
                                          child: Text(':')),
                                      BsCol(
                                          sizes: ColScreen(lg: Col.col_7),
                                          child: Text(controller.bp.value)),
                                      BsCol(
                                          margin: EdgeInsets.only(top: 10),
                                          sizes: ColScreen(lg: Col.col_12),
                                          child: BsRow(
                                            children: [
                                              BsCol(
                                                  sizes:
                                                      ColScreen(lg: Col.col_4),
                                                  child: Text('Type')),
                                              BsCol(
                                                  sizes:
                                                      ColScreen(lg: Col.col_1),
                                                  child: Text(':')),
                                              BsCol(
                                                  sizes:
                                                      ColScreen(lg: Col.col_7),
                                                  child: Text(
                                                      controller.type.value))
                                            ],
                                          )),
                                      BsCol(
                                          margin: EdgeInsets.only(top: 10),
                                          sizes: ColScreen(lg: Col.col_12),
                                          child: BsRow(
                                            children: [
                                              BsCol(
                                                  sizes:
                                                      ColScreen(lg: Col.col_4),
                                                  child: Text('Description')),
                                              BsCol(
                                                  sizes:
                                                      ColScreen(lg: Col.col_1),
                                                  child: Text(':')),
                                              BsCol(
                                                  sizes:
                                                      ColScreen(lg: Col.col_7),
                                                  child: Text(
                                                      controller.desc.value))
                                            ],
                                          )),
                                    ],
                                  )),
                            ]),
                          )
                        ],
                      )),
                )
              ]),
        ));
  }

  @override
  void onSuccessFetchData(Response response) {
    CompetitorModel dt = CompetitorModel.fromJson(response.body);
    controller.name.value = dt.comptname ?? '';
    controller.product.value = dt.comptproductname ?? '';
    controller.desc.value = dt.description ?? '';
    if (dt.comptreftype != null) {
      controller.type.value = dt.comptreftype!.typename!;
    }
    if (dt.comptpics != null) {
      var pic = [];
      var title = [];
      for (var item in dt.comptpics!) {
        pic.add(item.url);
        title.add(item.filename!.replaceAll('%20', ' '));
      }
      controller.pic.value = pic;
      controller.title.value = title;
    }
    if (dt.comptbp != null) {
      controller.bp.value = dt.comptbp!.bpname!;
    }
    presenter.setProcessing(false);
  }
}
