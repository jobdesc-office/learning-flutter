import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:flutter/cupertino.dart';

class MenuFormView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BsModal(
      context: context,
      dialog: BsModalDialog(
        child: BsModalContent(children: [
          BsModalContainer(
            title: Text('123'),
            closeButton: true,
          )
        ]),
      ),
    );
  }
}
