class RouteData {
  final String? key;
  final String _prefix;

  RouteData({this.key, required String prefix}) : _prefix = prefix;

  String get index => "$_prefix";
}
