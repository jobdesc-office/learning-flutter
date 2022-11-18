import 'dart:html' as html;

import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../helpers/function.dart';
import '../../../models/settings/file_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/settings/file_presenter.dart';
import '../../../styles/color_palattes.dart';
import '_detail_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class FileDetails extends GetView implements DetailViewContract {
  final presenter = Get.find<FilePresenter>();
  final FileDetailsSource controller = Get.put(FileDetailsSource());

  FileDetails() {
    presenter.fileDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.md,
          child: BsModalContent(
              decoration: BoxDecoration(
                color: _navigation.darkTheme.value
                    ? ColorPallates.elseDarkColor
                    : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              children: [
                BsModalContainer(
                  title: Text(FileText.title + ' Details',
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
                              sizes: ColScreen(lg: Col.col_4),
                              margin: EdgeInsets.only(top: 10),
                              child: controller.name.substring(
                                          controller.name.value.length - 4) ==
                                      '.pdf'
                                  ? InkWell(
                                      onTap: () {
                                        html.window.open(
                                            controller.image.value, "_blank");
                                        html.Url.revokeObjectUrl(
                                            controller.image.value);
                                      },
                                      child: Tooltip(
                                        message: 'Tap to Show Document',
                                        child: Icon(
                                          FontAwesomeIcons.filePdf,
                                          size: 128,
                                        ),
                                      ),
                                    )
                                  : Image.network(controller.image.value)),
                          BsCol(
                            margin: EdgeInsets.only(left: 10),
                            sizes: ColScreen(lg: Col.col_8),
                            child: BsRow(
                              children: [
                                BsCol(
                                    sizes: ColScreen(lg: Col.col_12),
                                    child: BsRow(
                                      children: [
                                        BsCol(
                                            sizes: ColScreen(lg: Col.col_3),
                                            child: Text('Name')),
                                        BsCol(
                                            sizes: ColScreen(lg: Col.col_1),
                                            child: Text(':')),
                                        BsCol(
                                            sizes: ColScreen(lg: Col.col_8),
                                            child: Text(controller.name.value))
                                      ],
                                    )),
                                BsCol(
                                    margin: EdgeInsets.only(top: 10),
                                    sizes: ColScreen(lg: Col.col_12),
                                    child: BsRow(
                                      children: [
                                        BsCol(
                                            sizes: ColScreen(lg: Col.col_3),
                                            child: Text('Type')),
                                        BsCol(
                                            sizes: ColScreen(lg: Col.col_1),
                                            child: Text(':')),
                                        BsCol(
                                            sizes: ColScreen(lg: Col.col_8),
                                            child: Text(controller.type.value))
                                      ],
                                    )),
                                BsCol(
                                    margin: EdgeInsets.only(top: 10),
                                    sizes: ColScreen(lg: Col.col_12),
                                    child: BsRow(
                                      children: [
                                        BsCol(
                                            sizes: ColScreen(lg: Col.col_3),
                                            child: Text('Directory')),
                                        BsCol(
                                            sizes: ColScreen(lg: Col.col_1),
                                            child: Text(':')),
                                        BsCol(
                                            sizes: ColScreen(lg: Col.col_8),
                                            child: Text(
                                                controller.directory.value))
                                      ],
                                    )),
                                BsCol(
                                    margin: EdgeInsets.only(top: 10),
                                    sizes: ColScreen(lg: Col.col_12),
                                    child: BsRow(
                                      children: [
                                        BsCol(
                                            sizes: ColScreen(lg: Col.col_3),
                                            child: Text('Mime')),
                                        BsCol(
                                            sizes: ColScreen(lg: Col.col_1),
                                            child: Text(':')),
                                        BsCol(
                                            sizes: ColScreen(lg: Col.col_8),
                                            child: Text(controller.mime.value))
                                      ],
                                    )),
                                BsCol(
                                    margin: EdgeInsets.only(top: 10),
                                    sizes: ColScreen(lg: Col.col_12),
                                    child: BsRow(
                                      children: [
                                        BsCol(
                                            sizes: ColScreen(lg: Col.col_3),
                                            child: Text('Size')),
                                        BsCol(
                                            sizes: ColScreen(lg: Col.col_1),
                                            child: Text(':')),
                                        BsCol(
                                            sizes: ColScreen(lg: Col.col_6),
                                            child: Text(formatBytes(
                                                parseInt(controller.size.value),
                                                3))),
                                        BsCol(
                                          sizes: ColScreen(sm: Col.col_2),
                                          child: InkWell(
                                            onTap: () {
                                              html.AnchorElement anchorElement =
                                                  new html.AnchorElement(
                                                      href: controller
                                                          .image.value);
                                              anchorElement.download =
                                                  controller.image.value;
                                              anchorElement.click();
                                              Get.snackbar('Success',
                                                  'Download in Progress');
                                            },
                                            child: Tooltip(
                                              message: 'Tap to Download',
                                              child: Icon(
                                                Icons.download,
                                                size: 32,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
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
    FileModel dt = FileModel.fromJson(response.body);
    controller.image.value = dt.url!;
    controller.name.value = dt.filename!;
    controller.type.value = dt.transtype!.typename!;
    controller.directory.value = dt.directories!;
    controller.mime.value = dt.mimetype!;
    controller.size.value = dt.filesize!;
    presenter.setProcessing(false);
  }
}
