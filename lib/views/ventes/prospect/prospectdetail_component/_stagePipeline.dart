import 'package:boilerplate/views/ventes/prospect/prospectactivity/_text.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import '../../../../constants/base_text.dart';
import '../../../../models/masters/type_model.dart';
import '../../../../models/session_model.dart';
import '../../../../presenters/ventes/prospect_presenter.dart';
import '../../../../styles/color_palattes.dart';
import '../../../../utils/session_manager.dart';
import '../../../../widgets/confirm_dialog.dart';
import '../_detail_source.dart';
import '../_text.dart';

abstract class MenuTypeViewDetailContract {
  void onLoadSuccess(Response response);
}

class MenuTypeOptionsController {
  MenuTypeOptionsController({
    this.options = const [],
    this.selected,
    this.processing = false,
  });

  List<TypeModel> options;

  TypeModel? selected;

  bool processing;

  TypeModel? getSelected() => selected;

  String? getSelectedToString() =>
      selected != null ? selected!.typeid.toString() : null;
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
    final presenter = Get.find<ProspectPresenter>();
    final source = Get.put(ProspectDetailsSource());
    if (widget.controller.processing) return loadingState();
    return BsRow(
      children: widget.controller.options.map((type) {
        Widget indicator;

        if (widget.controller.selected!.typeseq ==
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
            widget.controller.selected!.typeid == type.typeid) {
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
        } else if (widget.controller.selected!.typeseq! > type.typeseq!) {
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

        int index = widget.controller.options.indexOf(type);
        if (index == 0) {
        } else if (index == widget.controller.options.length - 1) {}
        return BsCol(
          sizes: ColScreen(sm: Col.col_2),
          child: InkWell(
            onTap: () async {
              print(source.status.value);
              if (source.status.value != ProspectText.closedWon &&
                  source.status.value != ProspectText.closedLost &&
                  source.status.value != ProspectText.forceClosed) {
                SessionModel session = await SessionManager.current();
                Map<String, dynamic> body = {
                  'prospectstageid': type.typeid,
                  'createdby': session.userid,
                  'updatedby': session.userid,
                };
                showDialog(
                  context: context,
                  builder: (context) => ConfirmDialog(
                    title: BaseText.confirmTitle,
                    message:
                        'Are You Sure Want to Change to ${type.typename} Stage ?',
                    onPressed: (_, value) async {
                      if (value == ConfirmDialogOption.YES_OPTION) {
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
                Text(type.typename ?? ''),
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
