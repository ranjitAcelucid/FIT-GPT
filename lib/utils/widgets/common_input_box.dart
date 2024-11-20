import 'package:flutter/material.dart';
import 'package:sales/utils/constants/app_style.dart';
import 'package:sales/utils/constants/colors.dart';
import 'package:sales/utils/constants/responsive.dart';
import 'package:sales/utils/constants/strings.dart';

class CommonInputBox extends StatefulWidget {
  final bool isLabelBackgroundColorRequried;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool filled;
  final Color? fillColour;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final TextStyle? hintStyle;
  final String? inputFormatter;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;

  const CommonInputBox(
      {required this.controller,
      this.filled = false,
      this.obscureText = false,
      this.readOnly = false,
      super.key,
      this.validator,
      this.fillColour,
      this.suffixIcon,
      this.hintText,
      this.keyboardType,
      this.hintStyle,
      this.overrideValidator = false,
      this.inputFormatter,
      this.prefixIcon,
      this.isLabelBackgroundColorRequried = false,
      this.onTap,
      this.maxLength,
      this.textInputAction,
      this.minLines,
      this.maxLines,
      this.onChanged});

  @override
  State<CommonInputBox> createState() => _CommonInputBoxState();
}

class _CommonInputBoxState extends State<CommonInputBox> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLength: widget.maxLength,
      textInputAction: widget.textInputAction,
      minLines: widget.minLines ?? 1,
      maxLines: widget.maxLines ?? 1,
      onChanged: widget.onChanged,
      validator: widget.overrideValidator
          ? widget.validator
          : (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.thisFieldRequired;
              }
              return widget.validator?.call(value);
            },
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      onTap: widget.onTap,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      readOnly: widget.readOnly,
      obscuringCharacter: '*',
      cursorColor: AppColors.primary,
      style: getDynamicTextStyle(
          context,
          headLineFontWeight500.copyWith(
              fontSize: Responsive.isMobile(context) ? 15 : 12,
              letterSpacing: 0.4,
              color: AppColors.dark1)),
      decoration: InputDecoration(
        isDense: false,
        alignLabelWithHint: false,
        helperText: ' ',
        hintText: widget.hintText,
        labelText: widget.hintText,
        // labelStyle: getDynamicTextStyle(context, headLine2),
        labelStyle: widget.hintStyle,
        // label: Text(
        //   widget.hintText ?? "",
        //   style: widget.hintStyle,
        // ),

        isCollapsed: false,
        counterText: "",

        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: getDynamicTextStyle(
            context,
            headLineFontWeight400.copyWith(
                fontSize: Responsive.isMobile(context) ? 14 : 12,
                color: AppColors.dark3,
                fontWeight: FontWeight.w400)),
        errorMaxLines: 5,
        errorStyle: getDynamicTextStyle(
            context,
            headLineFontWeight400.copyWith(
              color: Colors.red,
              fontSize: Responsive.isMobile(context) ? 14 : 12,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.visible,
            )),

        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                Responsive.isMobile(context) ? 12.0 : 16.0),
            borderSide: BorderSide(
              color: AppColors.primary,
              width: Responsive.isMobile(context) ? 1.0 : 2.0,
            ),
            gapPadding: 8.0),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(Responsive.isMobile(context) ? 12.0 : 16.0),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: Responsive.isMobile(context) ? 1.5 : 2.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(Responsive.isMobile(context) ? 12.0 : 16.0),
          borderSide: BorderSide(
            color: AppColors.dark8,
            width: Responsive.isMobile(context) ? 1.5 : 2.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(Responsive.isMobile(context) ? 12.0 : 16.0),
          borderSide: BorderSide(
            color: AppColors.primary7,
            width: Responsive.isMobile(context) ? 1.5 : 2.5,
          ),
        ),

        // overwriting the default padding helps with that puffy look
        contentPadding: EdgeInsets.symmetric(
            horizontal: screenHeight(
                context, Responsive.isMobile(context) ? 0.015 : 0.013),
            vertical: screenHeight(
                context, Responsive.isMobile(context) ? 0.020 : 0.015)),
        filled: widget.filled,
        fillColor: widget.fillColour ?? AppColors.white,
        suffixIcon: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.010),
          child: widget.suffixIcon,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.010),
          child: widget.prefixIcon,
        ),
      ),
    );
  }
}
