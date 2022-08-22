part of '../company.dart';

class _TabLostReasons extends StatelessWidget {
  const _TabLostReasons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List data = ['data', 'data', 'data'];
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Here You can Manage Lost Reasons. When The Deals is Marked as Lost, Users can Choose Between These Option'),
          BsButton(
            margin: EdgeInsets.only(top: 10),
            onPressed: () {},
            style: BsButtonStyle.success,
            label: Text('Add Predefined Lost Reason'),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Allow Entering Free Form Lost Reason to Predefined Option'),
                Icon(Icons.toggle_on)
              ],
            ),
          ),
          Column(
            children: data
                .map((e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(),
                        Container(
                          child: Text(
                            e,
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        Divider(),
                      ],
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
