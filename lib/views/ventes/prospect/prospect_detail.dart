import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/button/button_info_account.dart';

class ProspectDetails extends StatefulWidget {
  const ProspectDetails({Key? key}) : super(key: key);

  @override
  State<ProspectDetails> createState() => _ProspectDetailsState();
}

class _ProspectDetailsState extends State<ProspectDetails>
    with TickerProviderStateMixin
    implements DetailViewContract {
  late TabController _tabController;
  late TabController _tabControllerTimeline;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _tabControllerTimeline = TabController(length: 8, vsync: this);
  }

  final _navigation = Get.find<NavigationPresenter>();

  @override
  Widget build(BuildContext context) {
    BsSelectBoxController selectOwnership = BsSelectBoxController(options: [
      BsSelectBoxOption(value: '{1}', text: Text("Artemis's (You)")),
      BsSelectBoxOption(value: '{2}', text: Text('Not You'))
    ]);

    return Scaffold(
      body: TemplateView(
        activeRoutes: [RouteList.ventes.index, RouteList.ventesProspect.index],
        child: Column(
          children: [
            BsRow(
              children: [
                BsCol(
                  margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
                  sizes: ColScreen(sm: Col.col_12),
                  child: Obx(() => Container(
                        decoration: BoxDecoration(
                          color: _navigation.darkTheme.value
                              ? ColorPallates.elseDarkColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [Text('data'), Icon(Icons.label)],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    BsDropdownButton(
                                      toggleMenu: (_) => ButtonInfoAccount(
                                        'Kholifan Alfon',
                                        onPressed: () => _.toggle(),
                                      ),
                                      dropdownMenuSize:
                                          BsDropdownMenuSize(minWidth: 200),
                                      dropdownMenuStyle: BsDropdownMenuStyle(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      dropdownMenu: BsDropdownMenu(
                                        header: BsDropdownHeader(),
                                        children: [
                                          BsDropdownItem(
                                            child: Text('Tranfer Ownership'),
                                          ),
                                          BsDropdownItem(
                                              // child: BsSelectBox(
                                              //   searchable: false,
                                              //   controller: selectOwnership,
                                              //   hintText: BaseText.hiintSelect(),
                                              // ),
                                              ),
                                          BsDropdownDivider(),
                                          BsDropdownItem(
                                              padding: EdgeInsets.all(15),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  BsButton(
                                                      label: Text('Save'),
                                                      onPressed: () {},
                                                      style: BsButtonStyle(
                                                          color: _navigation
                                                                  .darkTheme
                                                                  .value
                                                              ? ColorPallates
                                                                  .elseDarkColor
                                                              : Colors.white,
                                                          backgroundColor:
                                                              ColorPallates
                                                                  .primary)),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  BsButton(
                                                    label: Text('Cancel'),
                                                    onPressed: () {},
                                                    style: BsButtonStyle(
                                                        color: _navigation
                                                                .darkTheme.value
                                                            ? ColorPallates
                                                                .elseDarkColor
                                                            : Colors.white,
                                                        backgroundColor:
                                                            ColorPallates
                                                                .cancel),
                                                  )
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text('data')),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text('data')),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text('data')),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Text('data')),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Rp. 9.000.000'),
                                Container(
                                  width: 300,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text('Add Product'),
                                      Row(
                                        children: [
                                          Icon(Icons.person),
                                          Text('Andy')
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.domain),
                                          Text('HSM')
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 1100,
                              height: 20,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Contact Made'),
                                Text('22-April-2022'),
                              ],
                            )
                          ]),
                        ),
                      )),
                ),
                BsCol(
                  margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
                  sizes: ColScreen(sm: Col.col_4),
                  child: BsRow(
                    children: [
                      BsCol(
                        child: Obx(() => Container(
                              decoration: BoxDecoration(
                                color: _navigation.darkTheme.value
                                    ? ColorPallates.elseDarkColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 100,
                              width: 200,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Detail'),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            BsButton(
                                                onPressed: () {},
                                                label: Icon(
                                                  Icons.edit,
                                                  size: 13,
                                                )),
                                            BsButton(
                                                onPressed: () {},
                                                label: Text('Customize Files'))
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Text('Description'),
                                                Text('Cost'),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(':'),
                                                Text(':'),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text('Description'),
                                                Text('Rp. 999'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                      BsCol(
                        margin: EdgeInsets.only(top: 10),
                        child: Obx(() => Container(
                              decoration: BoxDecoration(
                                color: _navigation.darkTheme.value
                                    ? ColorPallates.elseDarkColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Organization'),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            BsButton(
                                                onPressed: () {},
                                                label: Icon(
                                                  Icons.edit,
                                                  size: 13,
                                                )),
                                            BsButton(
                                                onPressed: () {},
                                                label: Icon(
                                                  Icons.edit,
                                                  size: 13,
                                                )),
                                            BsButton(
                                                onPressed: () {},
                                                label: Icon(
                                                  Icons.edit,
                                                  size: 13,
                                                )),
                                            BsButton(
                                                onPressed: () {},
                                                label: Icon(
                                                  Icons.edit,
                                                  size: 13,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                  child: Icon(Icons.domain),
                                                ),
                                                Text('Address')
                                              ],
                                            ),
                                            Text('HSM')
                                          ],
                                        ),
                                        ExpansionTile(
                                          title: Text(
                                            "Title",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          children: <Widget>[
                                            ListTile(
                                              subtitle: Text(
                                                  'data data data data data data data data'),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                BsCol(
                  margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
                  sizes: ColScreen(sm: Col.col_8),
                  child: BsRow(
                    children: [
                      BsCol(
                        child: Obx(() => Container(
                              decoration: BoxDecoration(
                                color: _navigation.darkTheme.value
                                    ? ColorPallates.elseDarkColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Container(
                                      child: TabBar(
                                        controller: _tabController,
                                        labelColor: Colors.green,
                                        unselectedLabelColor: Colors.black,
                                        tabs: [
                                          Tab(
                                              text: 'Notes',
                                              icon: Icon(Icons.note)),
                                          Tab(
                                              text: 'Activity',
                                              icon: Icon(Icons.calendar_month)),
                                          Tab(
                                              text: 'Propose Time',
                                              icon: Icon(Icons.timelapse)),
                                          Tab(
                                              text: 'Call',
                                              icon: Icon(Icons.phone)),
                                          Tab(
                                              text: 'Email',
                                              icon: Icon(Icons.email)),
                                          Tab(
                                              text: 'Files',
                                              icon: Icon(Icons.file_copy)),
                                          Tab(
                                              text: 'Documents',
                                              icon:
                                                  Icon(Icons.document_scanner))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 100,
                                      child: TabBarView(
                                        controller: _tabController,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [Text('Notes')],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [Text('Activity')],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [Text('Propose Time')],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [Text('Call')],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [Text('Email')],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [Text('Files')],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [Text('Documents')],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                      BsCol(
                        margin: EdgeInsets.only(top: 10),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              BsBadge(
                                child: Text('PLANNED'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('You have no upcoming activities.'),
                              SizedBox(
                                height: 10,
                              ),
                              Text('+ Schedule an activity'),
                              SizedBox(
                                height: 20,
                              ),
                              BsBadge(
                                child: Text('DONE'),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                child: TabBar(
                                  controller: _tabControllerTimeline,
                                  labelColor: Colors.green,
                                  unselectedLabelColor: Colors.black,
                                  tabs: [
                                    Tab(text: 'All'),
                                    Tab(text: 'Activity'),
                                    Tab(text: 'Notes'),
                                    Tab(text: 'Email'),
                                    Tab(text: 'Invoices'),
                                    Tab(text: 'Documents'),
                                    Tab(text: 'Files'),
                                    Tab(text: 'Changelog'),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 200,
                                child: TabBarView(
                                  controller: _tabControllerTimeline,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          BsRow(
                                            children: [
                                              BsCol(
                                                  sizes:
                                                      ColScreen(sm: Col.col_1),
                                                  child: Column(
                                                    children: [
                                                      OutlinedDotIndicator(),
                                                      SizedBox(
                                                        height: 50.0,
                                                        child:
                                                            SolidLineConnector(),
                                                      )
                                                    ],
                                                  )),
                                              BsCol(
                                                  sizes:
                                                      ColScreen(sm: Col.col_2),
                                                  child: Text('Today')),
                                              BsCol(
                                                  sizes:
                                                      ColScreen(sm: Col.col_9),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Meeting',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text('at Town Hall'),
                                                    ],
                                                  )),
                                              BsCol(
                                                  sizes:
                                                      ColScreen(sm: Col.col_1),
                                                  child: Column(
                                                    children: [
                                                      OutlinedDotIndicator()
                                                    ],
                                                  )),
                                              BsCol(
                                                  sizes:
                                                      ColScreen(sm: Col.col_2),
                                                  child: Text('Yesterday')),
                                              BsCol(
                                                  sizes:
                                                      ColScreen(sm: Col.col_9),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Meeting',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text('at Town Hall'),
                                                    ],
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text('Activity')],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text('Notes')],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text('Email')],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text('Invoices')],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text('Documents')],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text('Files')],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text('Changelog')],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void onSuccessFetchData(Response response) {}
}
