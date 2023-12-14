extension GoRouterPathX on String {
  String withParams(Map<String, dynamic> params) {
    var path = this;
    for (var key in params.keys) {
      path = path.replaceAll(":$key", "${params[key]}");
    }
    return path;
  }
}
