part of '../menu_details.dart';

Widget _menuDetailsDesc(MenuDetailsSource source) {
  return Obx(() => BsRow(
        children: [
          BsCol(
              sizes: ColScreen(lg: Col.col_12),
              child: FormGroup(
                  label: Text('Name'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(source.type.value), Divider()],
                  ))),
          BsCol(
              margin: EdgeInsets.only(top: 5),
              sizes: ColScreen(lg: Col.col_12),
              child: FormGroup(
                  label: Text('Parent'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(source.parent.value), Divider()],
                  ))),
          BsCol(
              margin: EdgeInsets.only(top: 5),
              sizes: ColScreen(lg: Col.col_12),
              child: FormGroup(
                  label: Text('Name'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(source.name.value), Divider()],
                  ))),
          BsCol(
              margin: EdgeInsets.only(top: 5),
              sizes: ColScreen(lg: Col.col_12),
              child: FormGroup(
                  label: Text('Icon'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(source.icon.value), Divider()],
                  ))),
          BsCol(
              margin: EdgeInsets.only(top: 5),
              sizes: ColScreen(lg: Col.col_12),
              child: FormGroup(
                  label: Text('Route'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(source.route.value), Divider()],
                  ))),
          BsCol(
              margin: EdgeInsets.only(top: 5),
              sizes: ColScreen(lg: Col.col_12),
              child: FormGroup(
                  label: Text('Color'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(source.color.value), Divider()],
                  ))),
          BsCol(
              margin: EdgeInsets.only(top: 5),
              sizes: ColScreen(lg: Col.col_12),
              child: FormGroup(
                  label: Text('Sequence'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(source.sequence.value), Divider()],
                  ))),
        ],
      ));
}
