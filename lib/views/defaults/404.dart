import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Page404 extends StatelessWidget {
  const Page404({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [
              Text(
                '404 Not Found',
                style: TextStyle(fontSize: 28),
              ),
              BsButton(
                margin: EdgeInsets.only(top: 10),
                onPressed: () => Get.back(),
                label: Text('Back'),
              )
            ],
          ),
        )
      ],
    );
  }
}
