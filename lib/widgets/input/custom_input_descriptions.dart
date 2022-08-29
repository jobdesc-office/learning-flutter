import 'dart:convert';

import 'package:boilerplate/styles/color_palattes.dart';
import 'package:flutter/material.dart';
import 'package:zefyrka/zefyrka.dart';

/// Type definition for custom bs form validator
typedef ZefyrEditorValidatorValue<T> = String? Function(T? value);

class ZefyrEditorValidator {
  const ZefyrEditorValidator({
    required this.validator,
  });

  /// validator function to check value is valid or not
  final ZefyrEditorValidatorValue validator;
}

class ZefyrEditorValidators {
  /// define required validation
  static ZefyrEditorValidator get required => ZefyrEditorValidator(
        validator: (value) {
          if (value == null) return "Field is required";

          if (value != null) {
            List documents = jsonDecode(value);
            if (value != null &&
                documents.first['insert'].toString().trim() == '')
              return "Field is required";
          }

          return null;
        },
      );
}

class ZefyrEditorComponent extends StatefulWidget {
  ZefyrEditorComponent({
    Key? key,
    required this.controller,
    this.validators = const [],
  }) : super(key: key);

  @override
  State<ZefyrEditorComponent> createState() => _ZefyrEditorComponentState();

  final ZefyrController controller;

  final List<ZefyrEditorValidator> validators;
}

class _ZefyrEditorComponentState extends State<ZefyrEditorComponent> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {});
      }
    });
    super.initState();
  }

  String? _errorText;

  bool get isEmpty {
    List documents = jsonDecode(jsonEncode(widget.controller.document));
    return documents.first['insert'].toString().trim() == '';
  }

  bool hasError = false;

  Border get _border => hasError
      ? Border.all(color: ColorPallates.danger)
      : Border.all(color: ColorPallates.primary);

  List<BoxShadow> get _boxShadow => hasError
      ? [
          BoxShadow(
            color: ColorPallates.danger,
            offset: Offset(0, 0),
            spreadRadius: 2.5,
          )
        ]
      : [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: _border,
              borderRadius: BorderRadius.circular(5),
              boxShadow: _boxShadow,
            ),
            child: SizedBox(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ZefyrToolbar.basic(
                    controller: widget.controller,
                    hideCodeBlock: true,
                    // hideHeadingStyle: true,
                    hideHorizontalRule: true,
                  ),
                  Expanded(
                    child: ZefyrEditor(
                      controller: widget.controller,
                      autofocus: false,
                      scrollable: true,
                      maxHeight: 300,
                      minHeight: 300,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      textCapitalization: TextCapitalization.sentences,
                      focusNode: _focusNode,
                    ),
                  ),
                ],
              ),
            ),
          ),
          FormField(
            initialValue: '',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              _errorText = null;
              widget.validators.map((validator) {
                if (_errorText == null) _errorText = validator.validator(value);
              }).toList();
              return _errorText;
            },
            builder: (field) {
              Future.delayed(Duration(milliseconds: 100), () {
                if (field.mounted) {
                  field.didChange(jsonEncode(widget.controller.document));
                }
              });

              hasError = field.hasError;

              return Container(
                child: Column(
                  children: [
                    !field.hasError
                        ? Container()
                        : Container(
                            margin: EdgeInsets.only(top: 5.0, left: 2.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              field.errorText!,
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black),
                            ),
                          )
                  ],
                ),
              );
            },
            onSaved: (value) {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
