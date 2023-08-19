import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../configs/palette.dart';
import '../utils/validator.dart';
import 'button_widget.dart';
import 'input_widget.dart';
import 'toast.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  bool _isEmailInputError = false;
  String _emailInputErrorHint = 'Please enter address';

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: mediaQueryData.viewInsets.bottom),
      padding: const EdgeInsets.only(
        left: 30.0,
        right: 30.0,
        bottom: 40.0,
        top: 30.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5.0),
            const Text(
              'We sent you a confirmation code to reset password',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
                color: Palette.kHeadingColor,
              ),
            ),
            const SizedBox(height: 25.0),
            InputWidget(
              inputPlaceholder: 'Enter address',
              textInputType: TextInputType.emailAddress,
              errorHint: _emailInputErrorHint,
              isError: _isEmailInputError,
              textEditingController: _emailController,
            ),
            const SizedBox(height: 10.0),
            ButtonWidget(
              buttonText: "Send",
              buttonBGColor: Palette.kPrimaryColor,
              buttonTextColor: Palette.kLightWhiteColor,
              buttonTriggerFunction: () async {
                if (_emailController.text == '') {
                  setState(() {
                    _emailInputErrorHint = 'Please enter address';
                    _isEmailInputError = true;
                  });
                } else {
                  if (isValidEmailAddress(_emailController.text)) {
                    var email = _emailController.text;
                    if (email.isNotEmpty) {
                      try {
                        await _auth.sendPasswordResetEmail(email: email);
                        Navigator.pop(context);
                        ToastBottomSuccess("Password reset email sent");
                      } catch (e) {
                        print(e);
                        Navigator.pop(context);
                        ToastBottomError("Failed to send password reset email");
                      }
                    } else {
                      ToastBottomError("Please enter your email address");
                    }
                  } else {
                    setState(() {
                      _emailInputErrorHint = 'Please enter valid address';
                      _isEmailInputError = true;
                    });
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
