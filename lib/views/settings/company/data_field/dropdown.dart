part of 'datafield.dart';

class _CustomFieldDropDown extends StatelessWidget {
  const _CustomFieldDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ButtonController());
    return Obx(() => BsDropdownButton(
          toggleMenu: (_) => ButtonCustomField(
            'Kholifan Alfon',
            onPressed: () {
              ctrl.btnCustomFieldIsTap.toggle();
              _.toggle();
            },
          ),
          dropdownMenuSize: BsDropdownMenuSize(minWidth: 200),
          dropdownMenuStyle: BsDropdownMenuStyle(
            backgroundColor: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : ColorPallates.primary,
            borderRadius: BorderRadius.circular(3),
          ),
          dropdownMenu: BsDropdownMenu(
            header: BsDropdownHeader(
              decoration: BoxDecoration(
                  color: _navigation.darkTheme.value
                      ? ColorPallates.elseDarkColor
                      : ColorPallates.elseLightColor),
            ),
            children: [
              BsDropdownItem(
                style: BoxDecoration(
                    color: _navigation.darkTheme.value
                        ? ColorPallates.elseDarkColor
                        : ColorPallates.elseLightColor),
                onPressed: (() {}),
                child: Text('Prospect Field'),
              ),
              BsDropdownDivider(),
              BsDropdownItem(
                style: BoxDecoration(
                    color: _navigation.darkTheme.value
                        ? ColorPallates.elseDarkColor
                        : ColorPallates.elseLightColor),
                onPressed: (() {}),
                child: Text('Person Field'),
              ),
              BsDropdownDivider(),
              BsDropdownItem(
                style: BoxDecoration(
                    color: _navigation.darkTheme.value
                        ? ColorPallates.elseDarkColor
                        : ColorPallates.elseLightColor),
                onPressed: (() {}),
                child: Text('Organization Field'),
              ),
              BsDropdownDivider(),
              BsDropdownItem(
                style: BoxDecoration(
                    color: _navigation.darkTheme.value
                        ? ColorPallates.elseDarkColor
                        : ColorPallates.elseLightColor),
                onPressed: (() {}),
                child: Text('Product Field'),
              ),
            ],
          ),
        ));
  }
}
