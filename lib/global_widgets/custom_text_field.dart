import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thoughts/utils/themes/colors.dart';
import 'package:thoughts/utils/themes/text_theme.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final bool obscureText;
  final TextEditingController editingController;
  // final String? hintText;
  final AutovalidateMode autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType textInputType;
  final int? maxLines;
  final Widget? suffixIcon;
  final TextCapitalization? textCapitalization;
  final Function(String)? onChanged;
  final Widget? hintIcon;
  final FormFieldValidator? formValidator;
  final FormFieldSetter? onFieldSubmitted;
  final Color? enabledBorderColor;
  final int? maxLength;
  final int? minLines;
  final bool enabled;
  final Function()? onTap;
  final bool readOnly;
  final Widget? suffix;
  final double? borderRadius;
  final Widget? prefixIcon;
  final bool autofocus;
  final bool isPassword;

  const CustomTextField({
    this.label,
    this.enabled = true,
    this.isPassword = false,
    super.key,
    this.maxLines,
    this.obscureText = false,
    this.inputFormatters,
    this.onChanged,
    this.borderRadius,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    required this.editingController,
    this.textCapitalization,
    // this.hintText,
    required this.textInputType,
    this.hintIcon,
    this.suffixIcon,
    this.formValidator,
    this.onFieldSubmitted,
    this.enabledBorderColor,
    this.maxLength,
    this.onTap,
    this.minLines,
    this.readOnly = false,
    this.suffix,
    this.prefixIcon,
    this.autofocus = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: widget.autofocus,
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        obscureText: widget.obscureText,
        // obscureText: (widget.isPassword ? passwordVisible : false),
        onChanged: widget.onChanged,
        maxLines: widget.maxLines,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.sentences,
        autovalidateMode: widget.autovalidateMode,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: AppColors.primaryColor,
        inputFormatters: widget.inputFormatters,
        style: TT.f14w700.copyWith(fontFamily: ''),
        controller: widget.editingController,
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
          labelStyle:
              TT.f14w400.copyWith(color: const Color(0xffA1A1A1), height: 1.4),
          labelText: widget.label,
          alignLabelWithHint: true,
          suffix: widget.suffix,
          // hintText: widget.hintText,
          hintStyle:
              TT.f14w400.copyWith(color: const Color(0xffA1A1A1), height: 1.4),
          prefixIcon: widget.prefixIcon,
          filled: true,
          fillColor: widget.enabled ? Colors.white : Colors.grey.shade100,
          suffixIcon: widget.suffixIcon ??
              (widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                      icon: passwordVisible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility))
                  : null),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: const BorderSide(color: AppColors.borderGreyColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: const BorderSide(color: AppColors.warningRed),
          ),
          errorMaxLines: 2,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide:
                const BorderSide(color: AppColors.primaryColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: BorderSide(
                color: widget.enabledBorderColor ?? AppColors.borderGreyColor),
          ),
        ),
        validator: widget.formValidator);
  }
}
