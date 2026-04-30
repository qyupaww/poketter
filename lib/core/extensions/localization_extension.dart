import 'package:flutter/material.dart' show BuildContext;
import 'package:poketter/core/l10n/s.dart';
import 'package:poketter/core/l10n/s_id.dart';

extension LocalizationExtension on BuildContext {
  S get s => S.of(this) ?? SId();
}
