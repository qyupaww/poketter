import 'package:flutter/material.dart';
import 'package:morpheme_extension/morpheme_extension.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/core/themes/morpheme_colors/src/morpheme_color.dart';
import 'package:poketter/core/components/atoms/atom_button.dart';
import 'package:poketter/core/components/atoms/atom_spacing.dart';
import 'package:poketter/core/extensions/localization_extension.dart';

abstract class DialogType {
  Widget build(BuildContext context);
}

class AlertDialogType extends DialogType {
  AlertDialogType({this.positiveText, this.onPositivePressed});

  final String? positiveText;
  final VoidCallback? onPositivePressed;

  @override
  Widget build(BuildContext context) {
    return AtomButton.elevated(
      text: positiveText ?? context.s.oke,
      onPressed: () {
        Navigator.pop(context);
        onPositivePressed?.call();
      },
    );
  }
}

class ConfirmDialogType extends DialogType {
  ConfirmDialogType({
    this.positiveText,
    this.negativeText,
    this.onPositivePressed,
    this.onNegativePressed,
  });

  final String? positiveText;
  final String? negativeText;
  final VoidCallback? onPositivePressed;
  final VoidCallback? onNegativePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: AtomButton.text(
                text: negativeText ?? context.s.cancel,
                textStyle: TextStyle(color: context.color.error),
                onPressed: () {
                  Navigator.pop(context);
                  onNegativePressed?.call();
                },
              ),
            ),
            Expanded(
              child: AtomButton.elevated(
                text: positiveText ?? context.s.agree,
                onPressed: () {
                  Navigator.pop(context);
                  onPositivePressed?.call();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class WidgetDialogType extends DialogType {
  WidgetDialogType({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

extension SnackBarExtension on BuildContext {
  void showSnackBar(SnackBar snackBar) {
    ScaffoldMessenger.maybeOf(this)?.removeCurrentSnackBar();
    ScaffoldMessenger.maybeOf(this)?.showSnackBar(snackBar);
  }

  Future<T?> showMyBottomSheet<T>({
    String? title,
    required Widget child,
  }) async {
    return showModalBottomSheet<T>(
      context: this,
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ConstantSizes.s24),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(ConstantSizes.s16),
        decoration: BoxDecoration(
          color: context.color.background,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ConstantSizes.s24),
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  if (title.isNotNullOrEmpty)
                    Expanded(
                      child: Text(
                        title ?? '',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  else
                    Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    color: context.color.grey,
                  ),
                ],
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }

  Future<T?> showMyDialog<T>({
    required String title,
    required List<TextSpan> content,
    required DialogType type,
  }) async {
    return showDialog<T>(
      context: this,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ConstantSizes.s16),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: ConstantSizes.s16),
        child: Padding(
          padding: const EdgeInsets.all(ConstantSizes.s16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  AtomSpacing.horizontal16(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    color: context.color.grey,
                  ),
                ],
              ),
              AtomSpacing.vertical8(),
              Text.rich(
                TextSpan(children: content),
                style: TextStyle(color: context.color.white),
              ),
              AtomSpacing.vertical16(),
              type.build(context),
            ],
          ),
        ),
      ),
    );
  }
}
