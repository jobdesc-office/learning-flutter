import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:flutter/material.dart';

import '../constants/base_text.dart';
import '../styles/custom_button_size.dart';
import '../styles/custom_button_styles.dart';

enum ConfirmDialogOption { YES_OPTION, NO_OPTION }

enum ConfirmDialogButton { POSITION_BUTTON, NEGATIVE_BUTTON }

class ConfirmDialog extends StatefulWidget {
  const ConfirmDialog({
    this.title = 'Konfirmasi Hapus',
    this.message = 'Apakah anda yakin?',
    this.positiveButton,
    this.negativeButton,
    this.disabled = false,
    this.buttons = const [
      ConfirmDialogButton.POSITION_BUTTON,
      ConfirmDialogButton.NEGATIVE_BUTTON
    ],
    this.onPressed,
  });

  final String title;

  final String message;

  final Widget? positiveButton;

  final Widget? negativeButton;

  final bool disabled;

  final List<ConfirmDialogButton> buttons;

  final Function(_ConfirmDialogState _, ConfirmDialogOption value)? onPressed;

  @override
  State<StatefulWidget> createState() {
    return _ConfirmDialogState();
  }
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  bool _disabled = false;

  @override
  void initState() {
    _disabled = widget.disabled;
    super.initState();
  }

  void updateState(VoidCallback function) {
    if (mounted)
      setState(() {
        function();
      });
  }

  void setDisabled(bool disabled) {
    updateState(() {
      _disabled = disabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BsModal(
      context: context,
      dialog: BsModalDialog(
        size: BsModalSize.sm,
        crossAxisAlignment: CrossAxisAlignment.center,
        child: BsModalContent(
          children: [
            BsModalContainer(title: Text(widget.title), closeButton: true),
            BsModalContainer(
                child: Column(
              children: [
                Text(widget.message),
              ],
            )),
            BsModalContainer(
              mainAxisAlignment: MainAxisAlignment.end,
              actions: [
                !widget.buttons.contains(ConfirmDialogButton.POSITION_BUTTON)
                    ? Container()
                    : widget.positiveButton != null
                        ? widget.positiveButton!
                        : BsButton(
                            disabled: _disabled,
                            margin: EdgeInsets.only(right: 5),
                            label: Text(BaseText.yesConfirm),
                            style: CustomButtonStyle.roundedPrimary,
                            size: CustomButonSize.confirm,
                            onPressed: () {
                              if (widget.onPressed != null)
                                widget.onPressed!(
                                    this, ConfirmDialogOption.YES_OPTION);
                            },
                          ),
                !widget.buttons.contains(ConfirmDialogButton.NEGATIVE_BUTTON)
                    ? Container()
                    : widget.negativeButton != null
                        ? widget.negativeButton!
                        : BsButton(
                            disabled: _disabled,
                            margin: EdgeInsets.only(right: 5),
                            label: Text(BaseText.noConfirm),
                            style: CustomButtonStyle.roundedDanger,
                            size: CustomButonSize.confirm,
                            onPressed: () {
                              if (widget.onPressed != null)
                                widget.onPressed!(
                                    this, ConfirmDialogOption.NO_OPTION);
                            },
                          ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
