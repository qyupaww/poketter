import 'package:flutter/material.dart';
import 'package:poketter/core/components/atoms/atom_text.dart';
import 'package:poketter/core/constants/constant_radius.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/core/themes/morpheme_colors/src/morpheme_color.dart';

enum TypeBadge {
  primary,
  info,
  success,
  warning,
  error,
  grey;

  Color color(BuildContext context) => switch (this) {
    TypeBadge.primary => context.color.primary,
    TypeBadge.info => context.color.info,
    TypeBadge.success => context.color.success,
    TypeBadge.warning => context.color.warning,
    TypeBadge.error => context.color.error,
    TypeBadge.grey => context.color.grey,
  };

  Color bgColor(BuildContext context) => switch (this) {
    TypeBadge.primary => context.color.primary.withValues(alpha: .2),
    TypeBadge.info => context.color.bgInfo,
    TypeBadge.success => context.color.bgSuccess,
    TypeBadge.warning => context.color.bgWarning,
    TypeBadge.error => context.color.bgError,
    TypeBadge.grey => context.color.bgGrey,
  };
}

class AtomBadge extends StatelessWidget {
  const AtomBadge.primary({super.key, required this.text})
    : type = TypeBadge.primary;
  const AtomBadge.info({super.key, required this.text}) : type = TypeBadge.info;
  const AtomBadge.success({super.key, required this.text})
    : type = TypeBadge.success;
  const AtomBadge.warning({super.key, required this.text})
    : type = TypeBadge.warning;
  const AtomBadge.error({super.key, required this.text})
    : type = TypeBadge.error;
  const AtomBadge.grey({super.key, required this.text}) : type = TypeBadge.grey;

  final String text;
  final TypeBadge type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ConstantSizes.s8),
      decoration: BoxDecoration(
        color: type.bgColor(context),
        borderRadius: BorderRadius.circular(ConstantRadius.full),
      ),
      child: AtomText.bodySmall(text, color: type.color(context)),
    );
  }
}
