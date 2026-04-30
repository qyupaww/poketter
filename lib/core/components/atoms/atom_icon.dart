import 'package:flutter/material.dart';
import 'package:poketter/core/constants/constant_radius.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/core/themes/morpheme_colors/src/morpheme_color.dart';

enum TypeIcon {
  primary,
  info,
  success,
  warning,
  error,
  grey;

  Color color(BuildContext context) => switch (this) {
    TypeIcon.primary => context.color.primary,
    TypeIcon.info => context.color.info,
    TypeIcon.success => context.color.success,
    TypeIcon.warning => context.color.warning,
    TypeIcon.error => context.color.error,
    TypeIcon.grey => context.color.grey,
  };

  Color bgColor(BuildContext context) => switch (this) {
    TypeIcon.primary => context.color.primary.withValues(alpha: .2),
    TypeIcon.info => context.color.bgInfo,
    TypeIcon.success => context.color.bgSuccess,
    TypeIcon.warning => context.color.bgWarning,
    TypeIcon.error => context.color.bgError,
    TypeIcon.grey => context.color.bgGrey,
  };
}

class AtomIcon extends StatelessWidget {
  const AtomIcon.primary({super.key, required this.icon, this.angle})
    : type = TypeIcon.primary;
  const AtomIcon.info({super.key, required this.icon, this.angle})
    : type = TypeIcon.info;
  const AtomIcon.success({super.key, required this.icon, this.angle})
    : type = TypeIcon.success;
  const AtomIcon.warning({super.key, required this.icon, this.angle})
    : type = TypeIcon.warning;
  const AtomIcon.error({super.key, required this.icon, this.angle})
    : type = TypeIcon.error;
  const AtomIcon.grey({super.key, required this.icon, this.angle})
    : type = TypeIcon.grey;

  final IconData icon;
  final TypeIcon type;
  final double? angle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ConstantSizes.s8),
      decoration: BoxDecoration(
        color: type.bgColor(context),
        borderRadius: BorderRadius.circular(ConstantRadius.r8),
      ),
      child: Transform.rotate(
        angle: angle ?? 0,
        child: Icon(icon, color: type.color(context)),
      ),
    );
  }
}
