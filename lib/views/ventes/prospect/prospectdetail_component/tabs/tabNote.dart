part of '../../prospect_detail.dart';

class _TabNote extends StatelessWidget {
  const _TabNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<ProspectPresenter>();
    return Column(
      mainAxisAlignment: source.desc.value != ''
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              if (source.desc.value != '')
                Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              'Notes :',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          BsButton(
                              size: BsButtonSize.btnIconMd,
                              prefixIcon: Icons.edit,
                              onPressed: () => presenter.notes(context,
                                  source.prospectid.value, source.desc.value))
                        ],
                      ),
                      Obx(() => Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(top: 20),
                          child: Text(source.desc.value)))
                    ],
                  ),
                )
              else
                Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text('Notes is Empty'),
                      ),
                      BsButton(
                          size: BsButtonSize.btnIconMd,
                          prefixIcon: Icons.edit,
                          margin: EdgeInsets.only(top: 5),
                          onPressed: () => presenter.notes(context,
                              source.prospectid.value, source.desc.value))
                    ],
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
