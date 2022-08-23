part of '../company.dart';

class _TabActivities extends StatelessWidget {
  const _TabActivities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List data = ['data', 'data', 'data'];
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Activities Types',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Text(
                    'Here You can Customize Which Type of Activities can Used in Your Company.'),
                Text(
                  ' You can Rearrange Them By Dragging and Dropping',
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.toggle_off),
                  BsButton(
                    size: BsButtonSize.btnSm,
                    onPressed: () {},
                    style: BsButtonStyle.success,
                    label: Text('Add Activity Type'),
                  )
                ],
              )),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: data
                  .map((e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(e,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold)),
                              Container(
                                margin: EdgeInsets.only(left: 200),
                                child: Row(
                                  children: [Icon(Icons.abc), Text('Example')],
                                ),
                              )
                            ],
                          ),
                          Text(
                            'Edit | Deactive',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
