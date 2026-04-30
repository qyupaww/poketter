import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:morpheme_extension/morpheme_extension.dart';
import 'package:poketter/core/components/atoms/atom_text.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/core/themes/morpheme_colors/src/morpheme_color.dart';

enum StatusMessage { none, error, info, success, warning }

extension ValidatorExtension on ValidatorValue? {
  bool isValid() =>
      this == null ||
      this?.statusMessage == StatusMessage.none ||
      this?.statusMessage == StatusMessage.success;
}

class ValidatorValue extends Equatable {
  const ValidatorValue.none()
    : message = '',
      statusMessage = StatusMessage.none;
  const ValidatorValue.error([this.message])
    : statusMessage = StatusMessage.error;
  const ValidatorValue.warning([this.message])
    : statusMessage = StatusMessage.warning;
  const ValidatorValue.info([this.message])
    : statusMessage = StatusMessage.info;
  const ValidatorValue.success([this.message])
    : statusMessage = StatusMessage.success;

  final String? message;
  final StatusMessage statusMessage;

  @override
  List<Object?> get props => [message, statusMessage];
}

class AtomValidatorStatus extends StatelessWidget {
  AtomValidatorStatus.info({
    super.key,
    required BuildContext context,
    this.text,
  }) : color = context.color.info;

  AtomValidatorStatus.success({
    super.key,
    required BuildContext context,
    this.text,
  }) : color = context.color.success;

  AtomValidatorStatus.error({
    super.key,
    required BuildContext context,
    this.text,
  }) : color = context.color.error;

  AtomValidatorStatus.warning({
    super.key,
    required BuildContext context,
    this.text,
  }) : color = context.color.warning;

  final String? text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (text.isNullOrEmpty) return SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ConstantSizes.s4),
      child: AtomText.bodySmall(
        text ?? '',
        color: color,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
