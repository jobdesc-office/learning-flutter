import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContentSkins extends StatelessWidget {
  const ContentSkins({
    Key? key,
    this.child,
    this.title,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth,
        margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  this.title == null
                      ? Container()
                      : Text(
                          this.title!,
                          style: TextStyle(
                            fontSize: 28,
                          ),
                        ),
                ],
              ),
            ),
            Container(child: child),
          ],
        ),
      ),
    );
  }

  final String? title;

  final String? subTitle;

  final Widget? child;
}
