import 'package:flutter/material.dart';

import '../configs/palette.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonBGColor;
  final Color buttonTextColor;
  final Widget? buttonLeadingIcon;
  final bool isDisabled;
  final Function? buttonTriggerFunction;

  const ButtonWidget({
    Key? key,
    required this.buttonText,
    this.buttonBGColor = Palette.kprimaryColor,
    this.buttonTextColor = Palette.kWhiteColor,
    this.buttonLeadingIcon,
    this.isDisabled = false,
    this.buttonTriggerFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        child: InkWell(
          onTap: () {
            if (buttonTriggerFunction != null) {
              buttonTriggerFunction!();
            }
          },
          child: Container(
            height: 50.0,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 10.0, 
              horizontal: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (buttonLeadingIcon != null)
                    ? buttonLeadingIcon!
                    : const SizedBox.shrink(),
                (buttonLeadingIcon != null)
                    ? const SizedBox(width: 10)
                    : const SizedBox.shrink(),
                Text(
                  buttonText,
                  style: TextStyle(
                    color: buttonTextColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        color: Colors.transparent,
      ),
      decoration: BoxDecoration(
        color: buttonBGColor,
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 3,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
