part of '../chat.dart';

Widget chatComponent(context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.7,
    child: SingleChildScrollView(
      child: BsRow(
        children: source.chats
            .map((e) => BsCol(
                  margin: EdgeInsets.all(5),
                  alignment: e.createdby == box.read('id')
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.5),
                    decoration: BoxDecoration(
                        color: _navigation.darkTheme.value
                            ? e.createdby == box.read('id')
                                ? ColorPallates.secondary
                                : Color(0xff454D55)
                            : e.createdby == box.read('id')
                                ? ColorPallates.primary
                                : Color(0xfff1f1f1),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.all(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (e.chatrefid != null)
                          if (e.chatreftype!.typename == 'Prospect')
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: _navigation.darkTheme.value
                                        ? e.chatmessage != null
                                            ? Color(0xff454D55)
                                            : Colors.transparent
                                        : e.chatmessage != null
                                            ? Color(0xfff1f1f1)
                                            : Colors.transparent),
                              ),
                              child: BsRow(
                                children: [
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_4),
                                    child: Container(
                                      child: Text(
                                        'Prospect Name',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_1),
                                    child: Container(
                                      child: Text(':',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_7),
                                    child: Container(
                                      child: Text(
                                          e.refprospect?.prospectname ?? '',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_4),
                                    child: Container(
                                      child: Text(
                                        'Customer Name',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_1),
                                    child: Container(
                                      child: Text(':',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_7),
                                    child: Container(
                                      child: Text(
                                          e.refprospect?.prospectcust
                                                  ?.sbccstmname ??
                                              '',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_4),
                                    child: Container(
                                      child: Text(
                                        'Start Date',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_1),
                                    child: Container(
                                      child: Text(':',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_7),
                                    child: Container(
                                      child: Text(
                                          e.refprospect?.prospectstartdate ??
                                              '',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: _navigation.darkTheme.value
                                        ? e.chatmessage != null
                                            ? Color(0xff454D55)
                                            : Colors.transparent
                                        : e.chatmessage != null
                                            ? Color(0xfff1f1f1)
                                            : Colors.transparent),
                              ),
                              child: BsRow(
                                children: [
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_4),
                                    child: Container(
                                      child: Text('Person',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_1),
                                    child: Container(
                                      child: Text(':',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_7),
                                    child: Container(
                                      child: Text(
                                          e.refactivity?.dayactuser
                                                  ?.userfullname ??
                                              '',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_4),
                                    child: Container(
                                      child: Text('Date',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_1),
                                    child: Container(
                                      child: Text(':',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_7),
                                    child: Container(
                                      child: Text(
                                          e.refactivity?.dayactdate ?? '',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_4),
                                    child: Container(
                                      child: Text('Category',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_1),
                                    child: Container(
                                      child: Text(':',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_7),
                                    child: Container(
                                      child: Text(
                                          e.refactivity?.dayactcat
                                                  ?.sbttypename ??
                                              '',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_4),
                                    child: Container(
                                      child: Text('Location',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_1),
                                    child: Container(
                                      child: Text(':',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_7),
                                    child: Container(
                                      child: Tooltip(
                                        message: 'Tap to Copy',
                                        child: InkWell(
                                            onTap: () {
                                              Clipboard.setData(
                                                ClipboardData(
                                                    text: e.refactivity
                                                            ?.dayactloc ??
                                                        ''),
                                              );
                                              Snackbar().copySuccess();
                                            },
                                            child: Text(
                                                e.refactivity?.dayactloc ?? '',
                                                style: TextStyle(
                                                    color: Colors.white))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        if (e.chatfile != null)
                          if (e.chatfile!.filename!.substring(
                                  e.chatfile!.filename!.length - 4) !=
                              '.pdf')
                            Image.network(e.chatfile!.url!)
                          else
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(FontAwesomeIcons.filePdf),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () => chatPresenter
                                            .viewFile(e.chatfile!.url!),
                                        child: Icon(Icons.visibility),
                                      ),
                                      InkWell(
                                        onTap: () => chatPresenter
                                            .downloadFile(e.chatfile!.url!),
                                        child: Icon(Icons.download),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                        if (e.chatmessage != null)
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 2, 0, 2),
                            child: Text(
                              e.chatmessage ?? '',
                              style: TextStyle(
                                color: _navigation.darkTheme.value
                                    ? Colors.white
                                    : e.createdby == box.read('id')
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    ),
  );
}
