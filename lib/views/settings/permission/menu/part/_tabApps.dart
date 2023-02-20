part of '../permission_menu.dart';

class _AppsMenuPermission extends StatelessWidget {
  const _AppsMenuPermission({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int x = 0;
    return Obx(() => SingleChildScrollView(
          child: Column(
            children: source.permission
                .where((p0) => p0.menutype!.typecd == ConfigType.menuTypeApp)
                .map((element) {
              x++;
              return Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: _navigation.darkTheme.value
                      ? x % 2 == 0
                          ? ColorPallates.datatableDarkEvenRowColor
                          : ColorPallates.datatableDarkOddRowColor
                      : x % 2 == 0
                          ? ColorPallates.datatableLightEvenRowColor
                          : ColorPallates.datatableLightOddRowColor,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: BsRow(
                  children: [
                    BsCol(
                      margin: EdgeInsets.only(top: 10, left: 10),
                      sizes: ColScreen(sm: Col.col_4),
                      child: Text(
                        '${element.menunm}',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (permis
                        .where((element) => element.menunm == 'Settings')
                        .first
                        .children!
                        .where((element) => element.menunm == 'Permission')
                        .first
                        .features!
                        .where((element) => element.featslug == 'update')
                        .first
                        .permissions!
                        .hasaccess!)
                      BsCol(
                        sizes: ColScreen(sm: Col.col_7),
                        child: BsRow(
                          height: 52,
                          children: element.features!.map((e) {
                            return BsCol(
                              sizes: ColScreen(sm: Col.col_2),
                              child: Column(
                                children: [
                                  if (e.hasaccess!)
                                    Column(
                                      children: [
                                        Text(e.feattitle ?? ''),
                                        InkWell(
                                          child: Icon(
                                            Icons.toggle_on,
                                            size: 30,
                                            color: _navigation.darkTheme.value
                                                ? ColorPallates.onDarkMode
                                                : ColorPallates.onLightMode,
                                          ),
                                          onTap: () async {
                                            x = 1;
                                            SessionModel session =
                                                await SessionManager.current();
                                            Map<String, dynamic> body = {
                                              'hasaccess': false,
                                              'updatedby': session.userid
                                            };
                                            presenter.update(
                                                context, body, e.permisid!);
                                          },
                                        ),
                                      ],
                                    )
                                  else
                                    Column(
                                      children: [
                                        Text(e.feattitle ?? ''),
                                        InkWell(
                                            child: Icon(
                                              Icons.toggle_off,
                                              size: 30,
                                              color: _navigation.darkTheme.value
                                                  ? ColorPallates.offDarkMode
                                                  : ColorPallates.offLightMode,
                                            ),
                                            onTap: () async {
                                              x = 1;
                                              SessionModel session =
                                                  await SessionManager
                                                      .current();
                                              Map<String, dynamic> body = {
                                                'hasaccess': true,
                                                'updatedby': session.userid
                                              };
                                              presenter.update(
                                                  context, body, e.permisid!);
                                            }),
                                      ],
                                    ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    if (element.children != null)
                      BsCol(
                        sizes: ColScreen(sm: Col.col_12),
                        child: Column(
                          children: element.children!.map((e) {
                            x++;
                            return BsRow(
                              decoration: BoxDecoration(
                                color: _navigation.darkTheme.value
                                    ? x % 2 == 0
                                        ? ColorPallates
                                            .datatableDarkEvenRowColor
                                        : ColorPallates.datatableDarkOddRowColor
                                    : x % 2 == 0
                                        ? ColorPallates
                                            .datatableLightEvenRowColor
                                        : ColorPallates
                                            .datatableLightOddRowColor,
                              ),
                              margin: EdgeInsets.only(top: 5),
                              children: [
                                BsCol(
                                  sizes: ColScreen(sm: Col.col_1),
                                ),
                                BsCol(
                                    margin: EdgeInsets.only(top: 10, left: 10),
                                    sizes: ColScreen(sm: Col.col_4),
                                    child: Text(e.menunm ?? '')),
                                BsCol(
                                  sizes: ColScreen(sm: Col.col_7),
                                  child: BsRow(
                                    children: e.features!
                                        .map((el) => BsCol(
                                              margin: EdgeInsets.only(top: 5),
                                              sizes: ColScreen(sm: Col.col_2),
                                              child: Column(
                                                children: [
                                                  Text(el.feattitle!),
                                                  if (el.hasaccess!)
                                                    InkWell(
                                                      child: Icon(
                                                        Icons.toggle_on,
                                                        size: 30,
                                                        color: _navigation
                                                                .darkTheme.value
                                                            ? ColorPallates
                                                                .onDarkMode
                                                            : ColorPallates
                                                                .onLightMode,
                                                      ),
                                                      onTap: () async {
                                                        x = 1;
                                                        SessionModel session =
                                                            await SessionManager
                                                                .current();
                                                        Map<String, dynamic>
                                                            body = {
                                                          'hasaccess': false,
                                                          'updatedby':
                                                              session.userid
                                                        };
                                                        presenter.update(
                                                            context,
                                                            body,
                                                            el.permisid!);
                                                      },
                                                    )
                                                  else
                                                    InkWell(
                                                        child: Icon(
                                                          Icons.toggle_off,
                                                          size: 30,
                                                          color: _navigation
                                                                  .darkTheme
                                                                  .value
                                                              ? ColorPallates
                                                                  .offDarkMode
                                                              : ColorPallates
                                                                  .offLightMode,
                                                        ),
                                                        onTap: () async {
                                                          x = 1;
                                                          SessionModel session =
                                                              await SessionManager
                                                                  .current();
                                                          Map<String, dynamic>
                                                              body = {
                                                            'hasaccess': true,
                                                            'updatedby':
                                                                session.userid
                                                          };
                                                          presenter.update(
                                                              context,
                                                              body,
                                                              el.permisid!);
                                                          presenter.update(
                                                              context,
                                                              body,
                                                              element.features!
                                                                  .where((element) =>
                                                                      element
                                                                          .feattitle ==
                                                                      'Viewable')
                                                                  .first
                                                                  .permisid!);
                                                        }),
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                                if (e.children != null)
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_12),
                                    child: Column(
                                      children: e.children!.map((c) {
                                        x++;
                                        return BsRow(
                                          height: 57,
                                          decoration: BoxDecoration(
                                            color: _navigation.darkTheme.value
                                                ? x % 2 == 0
                                                    ? ColorPallates
                                                        .datatableDarkEvenRowColor
                                                    : ColorPallates
                                                        .datatableDarkOddRowColor
                                                : x % 2 == 0
                                                    ? ColorPallates
                                                        .datatableLightEvenRowColor
                                                    : ColorPallates
                                                        .datatableLightOddRowColor,
                                          ),
                                          margin: EdgeInsets.only(top: 5),
                                          children: [
                                            BsCol(
                                              sizes: ColScreen(sm: Col.col_2),
                                            ),
                                            BsCol(
                                                margin: EdgeInsets.only(
                                                    top: 10, left: 10),
                                                sizes: ColScreen(sm: Col.col_3),
                                                child: Text(c.menunm ?? '')),
                                            BsCol(
                                              sizes: ColScreen(sm: Col.col_7),
                                              child: BsRow(
                                                children: c.features!
                                                    .map((el) => BsCol(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          sizes: ColScreen(
                                                              sm: Col.col_2),
                                                          child: Column(
                                                            children: [
                                                              Text(el
                                                                  .feattitle!),
                                                              if (el.hasaccess!)
                                                                InkWell(
                                                                  child: Icon(
                                                                    Icons
                                                                        .toggle_on,
                                                                    size: 30,
                                                                    color: _navigation
                                                                            .darkTheme
                                                                            .value
                                                                        ? ColorPallates
                                                                            .onDarkMode
                                                                        : ColorPallates
                                                                            .onLightMode,
                                                                  ),
                                                                  onTap:
                                                                      () async {
                                                                    x = 1;
                                                                    SessionModel
                                                                        session =
                                                                        await SessionManager
                                                                            .current();
                                                                    Map<String,
                                                                            dynamic>
                                                                        body = {
                                                                      'hasaccess':
                                                                          false,
                                                                      'updatedby':
                                                                          session
                                                                              .userid
                                                                    };
                                                                    presenter.update(
                                                                        context,
                                                                        body,
                                                                        el.permisid!);
                                                                  },
                                                                )
                                                              else
                                                                InkWell(
                                                                    child: Icon(
                                                                      Icons
                                                                          .toggle_off,
                                                                      size: 30,
                                                                      color: _navigation
                                                                              .darkTheme
                                                                              .value
                                                                          ? ColorPallates
                                                                              .offDarkMode
                                                                          : ColorPallates
                                                                              .offLightMode,
                                                                    ),
                                                                    onTap:
                                                                        () async {
                                                                      x = 1;
                                                                      SessionModel
                                                                          session =
                                                                          await SessionManager
                                                                              .current();
                                                                      Map<String,
                                                                              dynamic>
                                                                          body =
                                                                          {
                                                                        'hasaccess':
                                                                            true,
                                                                        'updatedby':
                                                                            session.userid
                                                                      };
                                                                      presenter.update(
                                                                          context,
                                                                          body,
                                                                          el.permisid!);
                                                                      presenter.update(
                                                                          context,
                                                                          body,
                                                                          e.features!
                                                                              .where((element) => element.feattitle == 'Viewable')
                                                                              .first
                                                                              .permisid!);
                                                                      presenter.update(
                                                                          context,
                                                                          body,
                                                                          element
                                                                              .features!
                                                                              .where((element) => element.feattitle == 'Viewable')
                                                                              .first
                                                                              .permisid!);
                                                                    }),
                                                            ],
                                                          ),
                                                        ))
                                                    .toList(),
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  )
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ));
  }
}
