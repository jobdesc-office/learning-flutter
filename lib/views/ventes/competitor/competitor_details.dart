import 'package:boilerplate/constants/base_text.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gallery_3d/gallery3d.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/masters/competitor_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/ventes/competitor_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_back.dart';
import '../../skins/template.dart';
import '_details_source.dart';
import '_text.dart';
import 'image_picture_competitor.dart';

final _navigation = Get.find<NavigationPresenter>();

class CompetitorDetails extends GetView implements DetailViewContract {
  final CompetitorPresenter presenter = Get.find<CompetitorPresenter>();
  final CompetitorDetailsSource controller = Get.put(CompetitorDetailsSource());

  CompetitorDetails() {
    Get.delete<CompetitorDetailsSource>();
    presenter.competitorDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Competitor Details',
        breadcrumbs: [
          BreadcrumbWidget('Venteses'),
          BreadcrumbWidget('Competitors', back: true),
          BreadcrumbWidget('Competitor Details', active: true),
        ],
        activeRoutes: [
          RouteList.ventes.index,
          RouteList.ventesCompetitor.index
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ThemeButtonBack(
              onPressed: () => Navigator.pop(context),
              margin: EdgeInsets.only(bottom: 5),
            ),
            Obx(() => Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _navigation.darkTheme.value
                        ? ColorPallates.elseDarkColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: BsRow(
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
                                          message: BaseText.seePicture,
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
                                    InkWell(
                                      onTap: () => showDialog(
                                        context: context,
                                        builder: (context) =>
                                            ImagePictureCompetitor(
                                          title: controller.title.last,
                                          image: controller.pic.first,
                                        ),
                                      ),
                                      child: Tooltip(
                                        message: BaseText.seePicture,
                                        child: Image.network(
                                          controller.pic.first,
                                          width: 150,
                                          height: 130,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => showDialog(
                                        context: context,
                                        builder: (context) =>
                                            ImagePictureCompetitor(
                                          title: controller.title.last,
                                          image: controller.pic.first,
                                        ),
                                      ),
                                      child: Tooltip(
                                        message: BaseText.seePicture,
                                        child: Image.network(
                                          controller.pic.last,
                                          width: 150,
                                          height: 130,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (controller.pic.length == 1)
                              BsCol(
                                child: InkWell(
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (context) =>
                                        ImagePictureCompetitor(
                                      title: controller.title.last,
                                      image: controller.pic.first,
                                    ),
                                  ),
                                  child: Tooltip(
                                    message: 'Tap to See Full Image',
                                    child: Image.network(
                                      controller.pic.first,
                                      width: 250,
                                      height: 120,
                                    ),
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
                                              sizes: ColScreen(lg: Col.col_4),
                                              child: Text('Type')),
                                          BsCol(
                                              sizes: ColScreen(lg: Col.col_1),
                                              child: Text(':')),
                                          BsCol(
                                              sizes: ColScreen(lg: Col.col_7),
                                              child:
                                                  Text(controller.type.value))
                                        ],
                                      )),
                                  BsCol(
                                      margin: EdgeInsets.only(top: 10),
                                      sizes: ColScreen(lg: Col.col_12),
                                      child: BsRow(
                                        children: [
                                          BsCol(
                                              sizes: ColScreen(lg: Col.col_4),
                                              child: Text('Description')),
                                          BsCol(
                                              sizes: ColScreen(lg: Col.col_1),
                                              child: Text(':')),
                                          BsCol(
                                              sizes: ColScreen(lg: Col.col_7),
                                              child:
                                                  Text(controller.desc.value))
                                        ],
                                      )),
                                ],
                              )),
                        ]),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
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
