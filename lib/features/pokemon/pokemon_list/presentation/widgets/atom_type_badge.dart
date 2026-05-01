import 'package:flutter/material.dart';
import 'package:poketter/core/components/components.dart';
import 'package:poketter/core/constants/constant_radius.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/core/extensions/string_extensions.dart';
import 'package:poketter/core/themes/morpheme_colors/morpheme_colors.dart';

class AtomTypeBadge extends StatelessWidget {
  const AtomTypeBadge({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ConstantSizes.s8,
        vertical: ConstantSizes.s4,
      ),
      decoration: BoxDecoration(
        color: context.color.pureWhite.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(ConstantRadius.r16),
      ),
      child: AtomText.bodySmallBold(
        type.toCapitalized(),
        color: context.color.pureWhite,
      ),
    );
  }
}
