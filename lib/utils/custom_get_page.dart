import 'package:boilerplate/presenters/auth_presenter.dart';
import 'package:get/get.dart';

import '../middleware/auth_middleware.dart';

class CustomGetPage extends GetPage {
  CustomGetPage({
    required String name,
    required WidgetCallback page,
    bool isGuest = false,
    Bindings? binding,
    List<Bindings> bindings = const [],
  }) : super(
            name: name,
            page: page,
            transition: Transition.noTransition,
            binding: BindingsBuilder(() {
              Get.lazyPut(() => AuthPresenter());
            }),
            bindings: bindings,
            middlewares: [
              AuthMiddleware(),
            ]);
}
