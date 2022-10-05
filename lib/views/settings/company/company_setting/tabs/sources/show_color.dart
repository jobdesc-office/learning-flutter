part of '../../company.dart';

class _ShowColor extends StatelessWidget {
  final Color color;
  final Color textcolor;
  final String text;
  _ShowColor(
      {required this.color, required this.textcolor, required this.text});

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
                  title: Text('Color',
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black)),
                  closeButton: true,
                ),
                BsModalContainer(
                  child: Container(
                    color: color,
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text('$text',
                          style: TextStyle(color: textcolor, fontSize: 24)),
                    ),
                  ),
                )
              ]),
        ));
  }
}
