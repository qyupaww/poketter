import 'package:flutter/material.dart';
import 'package:poketter/core/components/atoms/atom_spacing.dart';
import 'package:poketter/core/components/atoms/atom_text.dart';
import 'package:poketter/core/components/atoms/atom_validator_status.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/core/themes/morpheme_colors/src/morpheme_color.dart';

extension GlobalKeyMoleculeDropdownStateExtension<T>
    on GlobalKey<MoleculeDropdownState<T>> {
  T? get value => currentState?.value;

  bool get isValid => currentState?.isValid ?? false;

  bool validate({T? value, bool withChangeValueState = true}) =>
      currentState?.validate(
        value: value,
        withChangeValueState: withChangeValueState,
      ) ??
      true;

  void resetValidate() => currentState?.resetValidate();

  void setError([String? message]) =>
      currentState?.setValidatorValue(ValidatorValue.error(message));
}

class MoleculeDropdown<T> extends StatefulWidget {
  const MoleculeDropdown({
    super.key,
    this.title,
    this.decoration = const InputDecoration(),
    this.minLines,
    this.onChanged,
    this.onTap,
    this.style,
    this.styleTitle,
    this.validator,
    this.isAutoValidate = false,
    this.isDisabled = false,
    this.contentPadding,
    this.contextMenuBuilder,
    this.cursorColor,
    this.cursorErrorColor,
    this.isDense = false,
    this.initialValue,
    required this.items,
  });

  final String? title;
  final InputDecoration decoration;
  final int? minLines;
  final ValueChanged<T?>? onChanged;
  final GestureTapCallback? onTap;
  final TextStyle? style;
  final TextStyle? styleTitle;
  final ValidatorValue? Function(BuildContext context, T? value)? validator;
  final bool isAutoValidate;
  final bool isDisabled;
  final EdgeInsetsGeometry? contentPadding;
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final bool isDense;
  final T? initialValue;
  final List<DropdownMenuItem<T>> items;

  @override
  State<MoleculeDropdown<T>> createState() => MoleculeDropdownState<T>();
}

class MoleculeDropdownState<T> extends State<MoleculeDropdown<T>> {
  T? value;
  bool isAutoValidate = false;

  ValidatorValue validatorValue = const ValidatorValue.none();

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;

    isAutoValidate = widget.isAutoValidate;
  }

  @override
  void didUpdateWidget(covariant MoleculeDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue && context.mounted) {
      value = widget.initialValue;
    }
  }

  bool get isValid => validatorValue.isValid();

  bool validate({T? value, bool withChangeValueState = true}) {
    final validatorValue = widget.validator?.call(context, value ?? this.value);

    if (validatorValue?.statusMessage == StatusMessage.error) {
      if (withChangeValueState) {
        setState(() {
          if (widget.isAutoValidate) isAutoValidate = true;
        });
      }
    }

    if (validatorValue != null) {
      if (this.validatorValue != validatorValue) {
        setState(() {
          if (withChangeValueState) this.validatorValue = validatorValue;
        });
      }
    } else if (this.validatorValue.statusMessage != StatusMessage.none) {
      setState(() {
        if (withChangeValueState) {
          this.validatorValue = const ValidatorValue.none();
        }
      });
    }

    return validatorValue.isValid();
  }

  void resetValidate() {
    setState(() {
      isAutoValidate = false;
      validatorValue = const ValidatorValue.none();
    });
  }

  void onChanged(T? value) {
    this.value = value;
    if (isAutoValidate) validate(value: value);
    widget.onChanged?.call(value);
  }

  void setValidatorValue(ValidatorValue validatorValue) {
    setState(() {
      if (this.validatorValue != validatorValue) {
        this.validatorValue = validatorValue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) ...[
          AtomText.bodyMedium(
            widget.title ?? '',
            color: context.color.grey,
            style: widget.styleTitle,
          ),
          const AtomSpacing.vertical8(),
        ],
        DropdownButtonFormField<T>(
          initialValue: widget.initialValue,
          items: widget.items,
          isDense: widget.isDense,
          itemHeight: ConstantSizes.s56,
          dropdownColor: context.color.fillTextField,
          hint: Text(
            widget.decoration.hintText ?? '',
            style: TextStyle(color: context.color.grey),
          ),
          onChanged: onChanged,
          decoration: widget.decoration.copyWith(
            contentPadding: EdgeInsets.symmetric(horizontal: ConstantSizes.s12),
            filled: true,
            isDense: widget.isDense,
            fillColor: context.color.fillTextField,
            enabledBorder:
                widget.decoration.enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ConstantSizes.s12),
                  borderSide: BorderSide.none,
                ),
            focusedBorder:
                widget.decoration.focusedBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ConstantSizes.s12),
                  borderSide: BorderSide(
                    color: context.color.primary,
                    width: 2,
                  ),
                ),
            errorBorder:
                widget.decoration.errorBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ConstantSizes.s12),
                  borderSide: BorderSide(color: context.color.error),
                ),
            focusedErrorBorder:
                widget.decoration.focusedErrorBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ConstantSizes.s12),
                  borderSide: BorderSide(color: context.color.error, width: 2),
                ),
            error: validatorValue.statusMessage == StatusMessage.error
                ? const SizedBox.shrink()
                : null,
          ),
          onTap: widget.onTap,
          style: widget.style,
        ),
        switch (validatorValue.statusMessage) {
          StatusMessage.error => AtomValidatorStatus.error(
            context: context,
            text: validatorValue.message,
          ),
          StatusMessage.info => AtomValidatorStatus.info(
            context: context,
            text: validatorValue.message,
          ),
          StatusMessage.success => AtomValidatorStatus.success(
            context: context,
            text: validatorValue.message,
          ),
          StatusMessage.warning => AtomValidatorStatus.warning(
            context: context,
            text: validatorValue.message,
          ),
          _ => const SizedBox.shrink(),
        },
      ],
    );
  }
}
