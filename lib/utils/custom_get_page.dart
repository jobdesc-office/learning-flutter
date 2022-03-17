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
            binding: binding,
            bindings: bindings,
            middlewares: [
              AuthMiddleware(),
            ]);
}
