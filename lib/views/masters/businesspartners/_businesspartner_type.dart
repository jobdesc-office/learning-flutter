import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/masters/type_model.dart';
import '../../../styles/color_palattes.dart';

abstract class BusinessPartnerTypeViewContract {
  void onLoadSuccess(Response response);
}

class BusinessPartnerTypeOptionsController {
  BusinessPartnerTypeOptionsController({
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

class BusinessPartnerTypeOptions extends StatefulWidget {
  const BusinessPartnerTypeOptions({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final BusinessPartnerTypeOptionsController controller;

  @override
  State<StatefulWidget> createState() {
    return _BusinessPartnerTypeOptions();
  }
}

class _BusinessPartnerTypeOptions extends State<BusinessPartnerTypeOptions> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.processing) return loadingState();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: widget.controller.options.map((type) {
        Color backgroundColor = widget.controller.selected != null &&
                widget.controller.selected!.typeid == type.typeid
            ? ColorPallates.dark
            : Colors.grey.withOpacity(.5);

        Color? textColor = widget.controller.selected != null &&
                widget.controller.selected!.typeid == type.typeid
            ? Colors.white
            : null;

        int index = widget.controller.options.indexOf(type);
        BorderRadius? borderRadius;
        if (index == 0)
          borderRadius = BorderRadius.only(
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(5),
          );
        else if (index == widget.controller.options.length - 1) {
          borderRadius = BorderRadius.only(
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(5),
          );
        }

        return Material(
          color: Colors.transparent,
          child: InkWell(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: borderRadius,
              ),
              child: Text(
                type.typename,
                style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                ),
              ),
            ),
            onTap: () {
              widget.controller.selected = type;
              setState(() {});
            },
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
