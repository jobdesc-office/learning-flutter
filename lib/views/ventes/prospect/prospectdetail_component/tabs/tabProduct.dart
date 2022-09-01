part of '../../prospect_detail.dart';

class _TabProduct extends StatelessWidget {
  const _TabProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productPresenter = Get.find<ProspectProductPresenter>();
    final currencyFormatter = NumberFormat('#,##0.00', 'ID');
    if (source.product.length != 0)
      return SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 15, bottom: 10),
                  child: Text(
                    'Prospect Product : ',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                if (source.status.value != ProspectText.closedWon &&
                    source.status.value != ProspectText.closedLost &&
                    source.status.value != ProspectText.forceClosed)
                  BsButton(
                    style: BsButtonStyle.success,
                    onPressed: () {
                      productPresenter.add(context, source.prospectid.value);
                    },
                    prefixIcon: Icons.shopping_bag,
                    label: Text('Add Product'),
                  )
              ],
            ),
            Obx(() => Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: source.product.length,
                    itemBuilder: (context, index) {
                      var products = source.product[index];
                      return Tooltip(
                        message: source.status.value !=
                                    ProspectText.closedWon &&
                                source.status.value !=
                                    ProspectText.closedLost &&
                                source.status.value != ProspectText.forceClosed
                            ? BaseText.editDelete
                            : '',
                        child: InkWell(
                          onLongPress: () {
                            if (source.status.value != ProspectText.closedWon &&
                                source.status.value !=
                                    ProspectText.closedLost &&
                                source.status.value != ProspectText.forceClosed)
                              Get.defaultDialog(
                                  middleText: '',
                                  title: 'Setting',
                                  actions: [
                                    ButtonEditDatatables(onPressed: () {
                                      productPresenter.edit(
                                          context,
                                          products.prosproductid,
                                          source.prospectid.value);
                                    }),
                                    ButtonDeleteDatatables(onPressed: () {
                                      productPresenter.delete(
                                          context,
                                          products.prosproductid,
                                          '${products.prosproductproduct?.productname}');
                                    }),
                                  ]);
                          },
                          onTap: () {
                            productPresenter.detail(
                                context, products.prosproductid);
                          },
                          child: BsRow(
                            margin: source.product[index] == 0
                                ? EdgeInsets.zero
                                : EdgeInsets.only(top: 20),
                            children: [
                              BsCol(
                                sizes: ColScreen(sm: Col.col_1),
                                child: Text('${index + 1} )'),
                              ),
                              BsCol(
                                sizes: ColScreen(sm: Col.col_11),
                                child: BsRow(
                                  children: [
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_2),
                                      child: Text("Name"),
                                    ),
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_1),
                                      child: Text(':'),
                                    ),
                                    BsCol(
                                      sizes: ColScreen(sm: Col.col_9),
                                      child: Text(products
                                          .prosproductproduct?.productname),
                                    ),
                                    BsCol(
                                      margin: EdgeInsets.only(top: 5),
                                      sizes: ColScreen(sm: Col.col_2),
                                      child: Text("Amount"),
                                    ),
                                    BsCol(
                                      margin: EdgeInsets.only(top: 5),
                                      sizes: ColScreen(sm: Col.col_1),
                                      child: Text(':'),
                                    ),
                                    BsCol(
                                      margin: EdgeInsets.only(top: 5),
                                      sizes: ColScreen(sm: Col.col_9),
                                      child: Text('Rp. ' +
                                          currencyFormatter
                                              .format(double.parse(
                                                  products.prosproductamount))
                                              .replaceAll(',00', '')
                                              .replaceAll('.', ',')),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ))
          ],
        ),
      );
    else
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('This Prospect Don\'t Have Product'),
          if (source.status.value != ProspectText.closedWon &&
              source.status.value != ProspectText.closedLost &&
              source.status.value != ProspectText.forceClosed)
            BsButton(
              style: BsButtonStyle.success,
              margin: EdgeInsets.only(top: 10),
              onPressed: () {
                productPresenter.add(context, source.prospectid.value);
              },
              prefixIcon: Icons.shopping_bag,
              label: Text('Add Product'),
            )
        ],
      );
  }
}
