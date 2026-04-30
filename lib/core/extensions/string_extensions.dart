import 'package:poketter/core/extensions/date_time_extension.dart';

extension StringExtensions on String? {
  String? get nullIfBlank {
    if (this?.trim().isEmpty ?? true) return null;
    return this;
  }

  String getInitials() {
    if (this?.trim().isEmpty ?? true) return '';

    return (this ?? '')
        .trim()
        .split(RegExp(r'\s+'))
        .take(2)
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() : '')
        .join();
  }

  String toLocalTime() {
    if (this?.trim().isEmpty ??
        true && !RegExp(r'\d{2}:\d{2}:\d{2}').hasMatch(this ?? '')) {
      return '--:--';
    }

    final date = DateTime.tryParse('1970-01-01T${this}Z')?.toLocal();
    if (date == null) return '--:--';

    return date.toFormatDateTime('HH:mm');
  }

  String toCapitalized() {
    if (this == null || this!.isEmpty) return '';
    return '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}';
  }
}

