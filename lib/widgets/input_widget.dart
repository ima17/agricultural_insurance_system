import 'package:flutter/material.dart';

import '../configs/palette.dart';

class InputWidget extends StatefulWidget {
  final String? inputName;
  final String? inputPlaceholder;
  final String? errorHint;
  final String? labelText;
  final String? initialText;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final TextInputType textInputType;
  final String? inputValue;
  final bool isDisabled;
  final bool isFocused;
  final bool isReadonly;
  final bool isRequired;
  final bool isError;
  final bool isObscureText;
  final Function? inputTriggerFunction;
  final TextEditingController? textEditingController;
  final double fontSize;
  final Color bgColor;

  const InputWidget({
    Key? key,
    this.inputName,
    this.inputPlaceholder,
    this.errorHint,
    this.leadingIcon,
    this.trailingIcon,
    this.textInputType = TextInputType.text,
    this.inputValue,
    this.isDisabled = false,
    this.isFocused = false,
    this.isReadonly = false,
    this.isRequired = false,
    this.isError = false,
    this.isObscureText = false,
    this.inputTriggerFunction,
    this.textEditingController,
    this.labelText,
    this.initialText,
    this.bgColor = Palette.kInputBGColor,
    this.fontSize = 12.0,
  }) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        (widget.labelText != null)
            ? Column(
                children: [
                  Text(
                    widget.labelText! + ' :',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Palette.kInputLabelColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                ],
              )
            : const Column(),
        Container(
          height: 50.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.circular(5.0),
            border: (widget.isError)
                ? Border.all(
                    color: Palette.kInvalidInputHintColor.withOpacity(0.5))
                : Border.all(color: Palette.kInputBorderColor),
          ),
          child: TextFormField(
            onChanged: (value) {
              if (widget.inputTriggerFunction != null) {
                widget.inputTriggerFunction!(value);
              }
              validateInput(value);
            },
            initialValue:
                (widget.initialText != null) ? widget.initialText : null,
            textInputAction: TextInputAction.next,
            controller: (widget.textEditingController != null)
                ? widget.textEditingController
                : null,
            cursorColor: Palette.kPrimaryColor,
            textAlignVertical: TextAlignVertical.center,
            obscureText: widget.isObscureText,
            style: const TextStyle(
              color: Palette.kHeadingColor,
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.3,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIconConstraints: (widget.leadingIcon != null)
                  ? null
                  : BoxConstraints.tight(const Size.square(15)),
              prefixIcon: (widget.leadingIcon != null)
                  ? widget.leadingIcon
                  : const SizedBox.shrink(),
              suffixIcon: (widget.trailingIcon != null)
                  ? widget.trailingIcon
                  : const SizedBox.shrink(),
              enabledBorder: InputBorder.none,
              hintText: (widget.inputPlaceholder != null)
                  ? widget.inputPlaceholder
                  : null,
              hintStyle: TextStyle(
                color: Palette.kInputPlaceholderColor,
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w400,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              errorText: errorText,
            ),
          ),
        ),
        const SizedBox(height: 2.5),
        (widget.errorHint != null && widget.isError)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    widget.errorHint!,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Palette.kInvalidInputHintColor,
                      fontSize: 11.0,
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  void validateInput(String value) {
    if (widget.isRequired && (value == null || value.isEmpty)) {
      setState(() {
        errorText = widget.errorHint;
      });
    } else {
      setState(() {
        errorText = null;
      });
    }
  }
}
