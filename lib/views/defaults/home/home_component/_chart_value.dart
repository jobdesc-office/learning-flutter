part of '../home.dart';

BsCol chartValue() {
  return BsCol(
    sizes: ColScreen(sm: Col.col_8),
    child: Obx(() => Container(
        child: source.showValueChart.value
            ? ChartByValue(
                color: _navigation.darkTheme.value
                    ? ColorPallates.elseDarkColor
                    : Colors.white,
              )
            : Container())),
  );
}
