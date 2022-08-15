part of '../menu_details.dart';

Widget _menuDetailsDesc(MenuDetailsSource source) {
  return Obx(() => BsRow(
        children: [
          BsCol(
              sizes: ColScreen(lg: Col.col_12),
              child: BsRow(
                children: [
                  BsCol(sizes: ColScreen(lg: Col.col_3), child: Text('Type')),
                  BsCol(sizes: ColScreen(lg: Col.col_1), child: Text(':')),
                  BsCol(
                      sizes: ColScreen(lg: Col.col_8),
                      child: Text(source.type.value))
                ],
              )),
          BsCol(
              margin: EdgeInsets.only(top: 5),
              sizes: ColScreen(lg: Col.col_12),
              child: BsRow(
                children: [
                  BsCol(sizes: ColScreen(lg: Col.col_3), child: Text('Parent')),
                  BsCol(sizes: ColScreen(lg: Col.col_1), child: Text(':')),
                  BsCol(
                      sizes: ColScreen(lg: Col.col_8),
                      child: Text(source.parent.value))
                ],
              )),
          BsCol(
              margin: EdgeInsets.only(top: 5),
              sizes: ColScreen(lg: Col.col_12),
              child: BsRow(
                children: [
                  BsCol(sizes: ColScreen(lg: Col.col_3), child: Text('Name')),
                  BsCol(sizes: ColScreen(lg: Col.col_1), child: Text(':')),
                  BsCol(
                      sizes: ColScreen(lg: Col.col_8),
                      child: Text(source.name.value))
                ],
              )),
          BsCol(
              margin: EdgeInsets.only(top: 5),
              sizes: ColScreen(lg: Col.col_12),
              child: BsRow(
                children: [
                  BsCol(sizes: ColScreen(lg: Col.col_3), child: Text('Icon')),
                  BsCol(sizes: ColScreen(lg: Col.col_1), child: Text(':')),
                  BsCol(
                      sizes: ColScreen(lg: Col.col_8),
                      child: Text(source.icon.value))
                ],
              )),
          BsCol(
              margin: EdgeInsets.only(top: 5),
              sizes: ColScreen(lg: Col.col_12),
              child: BsRow(
                children: [
                  BsCol(sizes: ColScreen(lg: Col.col_3), child: Text('Route')),
                  BsCol(sizes: ColScreen(lg: Col.col_1), child: Text(':')),
                  BsCol(
                      sizes: ColScreen(lg: Col.col_8),
                      child: Text(source.route.value))
                ],
              )),
          BsCol(
              margin: EdgeInsets.only(top: 5),
              sizes: ColScreen(lg: Col.col_12),
              child: BsRow(
                children: [
                  BsCol(sizes: ColScreen(lg: Col.col_3), child: Text('Color')),
                  BsCol(sizes: ColScreen(lg: Col.col_1), child: Text(':')),
                  BsCol(
                      sizes: ColScreen(lg: Col.col_8),
                      child: Text(source.color.value))
                ],
              )),
          BsCol(
              margin: EdgeInsets.only(top: 5),
              sizes: ColScreen(lg: Col.col_12),
              child: BsRow(
                children: [
                  BsCol(
                      sizes: ColScreen(lg: Col.col_3), child: Text('Sequence')),
                  BsCol(sizes: ColScreen(lg: Col.col_1), child: Text(':')),
                  BsCol(
                      sizes: ColScreen(lg: Col.col_8),
                      child: Text(source.sequence.value))
                ],
              )),
        ],
      ));
}
