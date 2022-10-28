import 'dart:convert';

import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import '../../../../constants/base_text.dart';
import '../../../../helpers/function.dart';
import '../../../../models/session_model.dart';
import '../../../../models/settings/stbptype_model.dart';
import '../../../../presenters/auth_presenter.dart';
import '../../../../presenters/ventes/prospect_detail_presenter.dart';
import '../../../../presenters/ventes/prospect_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../utils/session_manager.dart';
import '../../../../widgets/confirm_dialog.dart';
import '../_detail_source.dart';
import '../_text.dart';

final authPresenter = Get.find<AuthPresenter>();

abstract class MenuTypeViewDetailContract {
  void onLoadSuccess(Response response);
}

class MenuTypeOptionsController {
  MenuTypeOptionsController({
    this.options = const [],
    this.selected,
    this.processing = false,
  });

  List<StbptypeModel> options;

  StbptypeModel? selected;

  bool processing;

  StbptypeModel? getSelected() => selected;

  String? getSelectedToString() =>
      selected != null ? selected!.sbtid.toString() : null;
}

class MenuTypeOptions extends StatefulWidget {
  const MenuTypeOptions({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final MenuTypeOptionsController controller;

  @override
  State<StatefulWidget> createState() {
    return _MenuTypeOptions();
  }
}

class _MenuTypeOptions extends State<MenuTypeOptions> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<ProspectDetailPresenter>();
    final source = Get.put(ProspectDetailsSource());
    if (widget.controller.processing) return loadingState();
    return BsRow(
      children: widget.controller.options.map((type) {
        Widget indicator = Container();
        if (widget.controller.selected!.sbtseq ==
            widget.controller.options.length) {
          // col = Col.col_4;
          indicator = SizedBox(
            width: 500,
            child: TimelineNode(
              direction: Axis.horizontal,
              indicator: DotIndicator(
                  size: 24,
                  color: ColorPallates.primary,
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 18,
                  )),
              startConnector: SolidLineConnector(color: ColorPallates.primary),
              endConnector: SolidLineConnector(color: ColorPallates.primary),
            ),
          );
        } else if (widget.controller.selected != null &&
            widget.controller.selected!.sbtid == type.sbtid) {
          // col = Col.col_4;
          indicator = SizedBox(
            width: 500,
            child: TimelineNode(
              direction: Axis.horizontal,
              indicator: DotIndicator(
                  size: 24,
                  color: ColorPallates.primary,
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 18,
                  )),
              startConnector: SolidLineConnector(color: ColorPallates.primary),
              endConnector: DashedLineConnector(color: ColorPallates.primary),
            ),
          );
        } else if (widget.controller.selected!.sbtseq! > type.sbtseq!) {
          // col = Col.col_4;
          indicator = SizedBox(
            width: 500,
            child: TimelineNode(
              direction: Axis.horizontal,
              indicator: DotIndicator(
                  size: 24,
                  color: ColorPallates.primary,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18,
                  )),
              startConnector: SolidLineConnector(color: ColorPallates.primary),
              endConnector: SolidLineConnector(color: ColorPallates.primary),
            ),
          );
        } else {
          // col = Col.col_4;
          indicator = SizedBox(
            width: 500,
            child: TimelineNode(
              direction: Axis.horizontal,
              indicator: OutlinedDotIndicator(
                size: 24,
                color: ColorPallates.primary,
              ),
              startConnector: DashedLineConnector(color: ColorPallates.primary),
              endConnector: DashedLineConnector(color: ColorPallates.primary),
            ),
          );
        }

        // int index = widget.controller.options.indexOf(type);
        // if (index == 0) {
        // } else if (index == widget.controller.options.length - 1) {}
        // ignore: invalid_use_of_protected_member
        var permis = authPresenter.rolepermis.value;
        return BsCol(
          margin: EdgeInsets.only(top: 10),
          sizes: ColScreen(sm: Col.col_2),
          child: InkWell(
            onTap: () async {
              if (source.status.value != ProspectText.closedWon &&
                  source.status.value != ProspectText.closedLost &&
                  source.status.value !=
                      ProspectText.forceClosed) if (permis
                  .where((element) => element.menunm == 'Ventes Datas')
                  .first
                  .children!
                  .where((element) => element.menunm == 'Prospect')
                  .first
                  .features!
                  .where((element) => element.featslug == 'update')
                  .first
                  .permissions!
                  .hasaccess!) {
                SessionModel session = await SessionManager.current();
                Map<String, dynamic> body = {
                  'prospectstageid': type.sbtid,
                  'createdby': session.userid,
                  'updatedby': session.userid,
                };
                showDialog(
                  context: context,
                  builder: (context) => ConfirmDialog(
                    title: BaseText.confirmTitle,
                    message:
                        'Are You Sure Want to Change to ${type.sbttypename} Stage ?',
                    onPressed: (_, value) async {
                      if (value == ConfirmDialogOption.YES_OPTION) {
                        if (type.sbtremark != null) {
                          Map<String, dynamic> prospectvalue =
                              jsonDecode(type.sbtremark ?? '');
                          source.changeprospectvalue.value =
                              parseBool(prospectvalue['prospectvalue']);
                        } else {
                          source.changeprospectvalue.value = false;
                        }
                        source.showPipeline.value = false;
                        source.prospectStageController.value.selected = type;
                        presenter.update(
                            context, body, source.prospectid.value);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                );
              }
            },
            child: Column(
              children: [
                indicator,
                Text(type.sbttypename ?? ''),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget loadingState() {
    return SizedBox(
      width: 10,
      height: 10,
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
        color: ColorPallates.dark,
      ),
    );
  }
}
