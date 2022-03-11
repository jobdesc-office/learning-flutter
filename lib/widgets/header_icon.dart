import 'package:flutter/material.dart';

import '../../constants/color_palattes.dart';

class HeaderIcon extends StatelessWidget {
  const HeaderIcon({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.color = Colors.transparent,
    this.margin = EdgeInsets.zero,
    this.badge,
  }) : super(key: key);

  final IconData icon;

  final Color color;

  final EdgeInsetsGeometry margin;

  final Widget? badge;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: this.color,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  this.icon,
                  size: 22,
                ),
              ),
              this.badge == null
                  ? Container()
                  : Positioned(
                      right: 0,
                      child: DefaultTextStyle(
                        style: TextStyle(fontSize: 10, color: Colors.white),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                          decoration: BoxDecoration(
                            color: ColorPallates.danger,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: this.badge,
                        ),
                      ),
                    )
            ],
          ),
          borderRadius: BorderRadius.circular(50),
          onTap: this.onPressed,
        ),
      ),
    );
  }
}
