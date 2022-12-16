part of '../chat.dart';

BsCol userComponent(context) {
  return BsCol(
    // height: MediaQuery.of(context).size.height * 0.8,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
      border: Border.all(
        width: 5.0,
        // assign the color to the border color
        color: _navigation.darkTheme.value ? Color(0xff454D55) : Color(0xfff1f1f1),
      ),
    ),
    sizes: ColScreen(sm: Col.col_2),
    child: Container(
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.79),
      child: SingleChildScrollView(
        child: Column(
          children: source.users
              .map((e) => InkWell(
                    onTap: () {
                      source.chats.clear();
                      source.useridactive.value = e.userid ?? 0;
                      source.usersocketactive.value = e.usersocketid ?? '';

                      chatPresenter.conversation(context, source.useridactive.value);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: _navigation.darkTheme.value
                              ? source.useridactive.value == e.userid
                                  ? ColorPallates.secondary
                                  : Color(0xff454D55)
                              : source.useridactive.value == e.userid
                                  ? ColorPallates.primary
                                  : null,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            width: 3.0,
                            // assign the color to the border color
                            color: _navigation.darkTheme.value
                                ? source.useridactive.value == e.userid
                                    ? ColorPallates.secondary
                                    : Color(0xff454D55)
                                : source.useridactive.value == e.userid
                                    ? ColorPallates.primary
                                    : Color(0xfff1f1f1),
                          )),
                      padding: EdgeInsets.all(3),
                      margin: EdgeInsets.all(10),
                      child: BsRow(
                        children: [
                          BsCol(
                              sizes: ColScreen(sm: Col.col_4),
                              child: Icon(
                                Icons.person,
                                size: 42,
                                color: _navigation.darkTheme.value
                                    ? Colors.white
                                    : source.useridactive.value == e.userid
                                        ? Colors.white
                                        : source.useridactive.value == e.userid
                                            ? Colors.white
                                            : Colors.black,
                              )),
                          BsCol(
                            sizes: ColScreen(sm: Col.col_8),
                            child: Column(
                              children: [
                                Text(
                                  e.userfullname ?? '',
                                  style: TextStyle(
                                    color: _navigation.darkTheme.value
                                        ? Colors.white
                                        : source.useridactive.value == e.userid
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                                Obx(() {
                                  return Text(
                                    source.idOnline.contains(e.userid.toString()) ? "Online" : "Offline",
                                    style: TextStyle(
                                      color: _navigation.darkTheme.value
                                          ? Colors.white
                                          : source.useridactive.value == e.userid
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  );
                                }),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    ),
  );
}
