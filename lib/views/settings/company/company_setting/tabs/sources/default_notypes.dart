part of '../../company.dart';

class _DefautlNoTypes extends StatelessWidget {
  final String tabname;
  _DefautlNoTypes(this.tabname);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('There\'s no $tabname'),
          ],
        ),
      ),
    );
  }
}
