part of '../../company.dart';

class _DefautlNoTypes extends StatelessWidget {
  const _DefautlNoTypes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('There\'s no Types'),
          ],
        ),
      ),
    );
  }
}
