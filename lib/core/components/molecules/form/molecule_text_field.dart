import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poketter/core/components/atoms/atom_spacing.dart';
import 'package:poketter/core/components/atoms/atom_text.dart';
import 'package:poketter/core/components/atoms/atom_validator_status.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/core/themes/morpheme_colors/src/morpheme_color.dart';

extension GlobalKeyMoleculeTextFieldStateExtension
    on GlobalKey<MoleculeTextFieldState> {
  String get text => currentState?.controller.text ?? '';

  set text(String value) => currentState?.setText(value);

  bool get isValid => currentState?.isValid ?? false;

  bool validate({String? value, bool withChangeValueState = true}) =>
      currentState?.validate(
        value: value,
        withChangeValueState: withChangeValueState,
      ) ??
      true;

  void requestFocus() => currentState?.requestFocus();

  void clear() => currentState?.setText('');

  void resetValidate() => currentState?.resetValidate();

  void clearAndReset() {
    clear();
    resetValidate();
  }

  void setError([String? message]) =>
      currentState?.setValidatorValue(ValidatorValue.error(message));
}

class MoleculeTextField extends StatefulWidget {
  const MoleculeTextField({
    super.key,
    this.textfieldKey,
    this.obscureIconKey,
    this.title,
    this.decoration = const InputDecoration(),
    this.controller,
    this.inputFormatters,
    this.focusNode,
    this.keyboardType,
    this.autofocus = false,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.onTap,
    this.readOnly = false,
    this.style,
    this.styleTitle,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.isPassword = false,
    this.textInputAction = TextInputAction.done,
    this.isAutoValidate = false,
    this.isDisabled = false,
    this.value,
    this.contextMenuBuilder,
    this.cursorColor,
    this.cursorErrorColor,
    this.isDense = false,
  });

  final Key? textfieldKey;
  final Key? obscureIconKey;
  final String? title;
  final InputDecoration decoration;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool autofocus;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final GestureTapCallback? onTap;
  final bool readOnly;
  final TextStyle? style;
  final TextStyle? styleTitle;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final ValidatorValue? Function(BuildContext context, String value)? validator;
  final bool isPassword;
  final TextInputAction textInputAction;
  final bool isAutoValidate;
  final bool isDisabled;
  final String? value;
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final bool isDense;

  @override
  State<MoleculeTextField> createState() => MoleculeTextFieldState();
}

class MoleculeTextFieldState extends State<MoleculeTextField> {
  late TextEditingController controller;
  late FocusNode focusNode;

  bool obscureText = false;
  bool isAutoValidate = false;

  ValidatorValue validatorValue = const ValidatorValue.none();

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();
    if (widget.isPassword) {
      obscureText = true;
    }

    isAutoValidate = widget.isAutoValidate;

    unawaited(
      WidgetsBinding.instance.endOfFrame.then((value) {
        if (context.mounted && widget.value != null) setText(widget.value!);
      }),
    );
  }

  @override
  void didUpdateWidget(covariant MoleculeTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && context.mounted) {
      setText(widget.value ?? '');
    }
  }

  @override
  void dispose() {
    try {
      focusNode.dispose();
      controller.dispose();
    } catch (_) {}
    super.dispose();
  }

  void requestFocus() {
    focusNode.requestFocus();
  }

  bool get isValid => validatorValue.isValid();

  bool validate({String? value, bool withChangeValueState = true}) {
    final validatorValue = widget.validator?.call(
      context,
      value ?? controller.text,
    );

    if (validatorValue?.statusMessage == StatusMessage.error) {
      if (withChangeValueState) {
        requestFocus();
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

  void setText(String value) {
    controller.text = value;
    if (isAutoValidate) validate(value: value);
    setState(() {});
  }

  void onChanged(String value) {
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
        TextField(
          key: widget.textfieldKey,
          controller: controller,
          contextMenuBuilder:
              widget.contextMenuBuilder ??
              (context, editableTextState) =>
                  AdaptiveTextSelectionToolbar.editableText(
                    editableTextState: editableTextState,
                  ),
          decoration: widget.decoration.copyWith(
            hintText: widget.decoration.hintText,
            hintStyle: TextStyle(color: context.color.grey),
            hintMaxLines: widget.minLines ?? 1,
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
            suffixIcon: widget.isPassword
                ? IconButton(
                    key: widget.obscureIconKey,
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: context.color.grey,
                    ),
                  )
                : widget.decoration.suffixIcon,
          ),
          cursorColor: widget.cursorColor,
          cursorErrorColor: widget.cursorErrorColor,
          onChanged: onChanged,
          inputFormatters: widget.inputFormatters,
          focusNode: focusNode,
          keyboardType: widget.keyboardType,
          autofocus: widget.autofocus,
          maxLength: widget.maxLength,
          maxLines: widget.isPassword ? 1 : widget.maxLines ?? 1,
          minLines: widget.minLines,
          obscureText: obscureText,
          onSubmitted: widget.onSubmitted,
          onEditingComplete: widget.onEditingComplete,
          onTap: widget.onTap,
          readOnly: widget.isDisabled || widget.readOnly,
          style: widget.style,
          textAlign: widget.textAlign,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
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
