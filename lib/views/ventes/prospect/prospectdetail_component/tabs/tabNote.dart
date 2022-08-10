part of '../../prospect_detail.dart';

class _tabNote extends StatelessWidget {
  const _tabNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  'Notes :',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(source.desc.value))
            ],
          ),
        )
      ],
    );
  }
}
