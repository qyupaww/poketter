import 'package:go_router/go_router.dart';
import 'package:poketter/core/global_variable.dart';

String joinRoutes(List<String> paths) {
  final path = paths
      .map((segment) => segment.replaceAll('/', ''))
      .join('/')
      .replaceAll(RegExp(r'(^\/+)|(\/+$)'), '');
  return '/$path';
}

String dynamicRoutes(String nextRoutes) {
  final goRouter = locator<GoRouter>();
  Uri uri = goRouter.routerDelegate.currentConfiguration.uri;
  uri = uri.replace(
    path: joinRoutes([...uri.path.split('/'), nextRoutes]),
    queryParameters: {},
  );
  return uri.toString();
}
