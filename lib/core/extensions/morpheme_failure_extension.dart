import 'dart:convert';

import 'package:flutter/material.dart' show BuildContext;
import 'package:poketter/core/components/molecules/morpheme_snackbar.dart';
import 'package:poketter/core/extensions/build_context_extension.dart';
import 'package:poketter/core/extensions/localization_extension.dart';
import 'package:morpheme_http/morpheme_http.dart';

extension MorphemeFailureExtension on MorphemeFailure {
  String errorMessage(BuildContext context) {
    String message = context.s.somethingWentWrong;

    if (this is NoInternetFailure) {
      message = context.s.noInternet;
    } else {
      try {
        final json = jsonDecode(jsonBody ?? '{}');
        message = json['meta']['message'] is String
            ? json['meta']['message']
            : message;
      } catch (error, _) {
        // ignore: empty_catches
      }
    }

    return message;
  }

  void showSnackbar(BuildContext context) => context.showSnackBar(
    MorphemeSnackBar.error(context: context, message: errorMessage(context)),
  );
}
