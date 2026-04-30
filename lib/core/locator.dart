import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:poketter/core/environment.dart';
import 'package:poketter/core/global_variable.dart';
import 'package:morpheme_http/morpheme_http.dart';

void setupLocatorCore() {
  locator.registerLazySingleton(() => const FlutterSecureStorage());
  // locator.registerLazySingleton(() => FirebaseRemoteConfig.instance);
  if (!kIsWeb) {
    locator.registerLazySingleton(
      () => MorphemeInspector(
        showInspectorOnShake: Environment.isNotProd,
        showNotification: Environment.isNotProd,
        saveInspectorToLocal: Environment.isNotProd,
      ),
    );
  }
  locator.registerLazySingleton(
    () => MorphemeHttp(
      timeout: 30000,
      showLog: false,
      morphemeInspector: kIsWeb ? null : locator(),
      headers: {'content-type': 'application/json'},
    ),
  );
}
