import 'package:agricultural_insurance_system/screens/loading_screen.dart';
import 'package:agricultural_insurance_system/screens/login_screen.dart';
import 'package:agricultural_insurance_system/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../configs/palette.dart';
import '../utils/validator.dart';
import '../widgets/button_widget.dart';
import '../widgets/input_widget.dart';
import '../widgets/toast.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isFirstNameInputError = false,
      _isLastNameInputError = false,
      _isEmailInputError = false,
      _isPasswordInputError = false,
      _isConfirmPasswordInputError = false;

  String _firstNameErrorHint = '',
      _lastNameErrorHint = '',
      _emailErrorHint = '',
      _passwordErrorHint = '',
      _confirmPasswordErrorHint = '';

  bool _passwordObscurity = true;
  bool _confirmPasswordObscurity = true;
  bool isLoading = false;
  IconData? passwordShowIcon;
  IconData? confirmPasswordShowIcon;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return isLoading
        ? LoadingWidget(
            text: "Signing In",
          )
        : Container(
            height: MediaQuery.of(context).size.height +
                MediaQuery.of(context).viewInsets.bottom,
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/images/back.png'),
                opacity: 0.8,
                fit: BoxFit.fill,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: true,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(
                                Icons.keyboard_backspace_rounded,
                                size: 25.0,
                                color: Palette.kHeadingColor,
                              ),
                            ),
                          ),
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 65, height: 10)
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Add your details to sign up',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                          color: Palette.kHeadingColor,
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InputWidget(
                              inputPlaceholder: 'First Name',
                              errorHint: _firstNameErrorHint,
                              isError: _isFirstNameInputError,
                              textEditingController: firstNameController,
                            ),
                            const SizedBox(height: 7.5),
                            InputWidget(
                              inputPlaceholder: 'Last Name',
                              errorHint: _lastNameErrorHint,
                              isError: _isLastNameInputError,
                              textEditingController: lastNameController,
                            ),
                            const SizedBox(height: 7.5),
                            InputWidget(
                              inputPlaceholder: 'Email Address',
                              textInputType: TextInputType.emailAddress,
                              errorHint: _emailErrorHint,
                              isError: _isEmailInputError,
                              textEditingController: emailController,
                            ),
                            const SizedBox(height: 7.5),
                            InputWidget(
                              inputPlaceholder: 'Password',
                              textInputType: TextInputType.visiblePassword,
                              trailingIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    _passwordObscurity = !_passwordObscurity;
                                    if (_passwordObscurity == true) {
                                      passwordShowIcon = Icons.visibility;
                                    } else {
                                      passwordShowIcon = Icons.visibility_off;
                                    }
                                  });
                                },
                                child: Icon(
                                  passwordShowIcon ?? Icons.visibility,
                                  size: 20.0,
                                  color: Palette.kInputPlaceholderColor,
                                ),
                              ),
                              errorHint: _passwordErrorHint,
                              isError: _isPasswordInputError,
                              textEditingController: passwordController,
                              isObscureText: _passwordObscurity,
                            ),
                            const SizedBox(height: 7.5),
                            InputWidget(
                              inputPlaceholder: 'Confirm Password ',
                              textInputType: TextInputType.visiblePassword,
                              trailingIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    _confirmPasswordObscurity =
                                        !_confirmPasswordObscurity;
                                    if (_confirmPasswordObscurity == true) {
                                      confirmPasswordShowIcon =
                                          Icons.visibility;
                                    } else {
                                      confirmPasswordShowIcon =
                                          Icons.visibility_off;
                                    }
                                  });
                                },
                                child: Icon(
                                  confirmPasswordShowIcon ?? Icons.visibility,
                                  size: 20.0,
                                  color: Palette.kInputPlaceholderColor,
                                ),
                              ),
                              errorHint: _confirmPasswordErrorHint,
                              isError: _isConfirmPasswordInputError,
                              textEditingController: confirmPasswordController,
                              isObscureText: _confirmPasswordObscurity,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          height: size.height * 0.12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ButtonWidget(
                                buttonText: "Sign Up",
                                buttonBGColor: Palette.kPrimaryColor,
                                buttonTextColor: Palette.kLightWhiteColor,
                                buttonTriggerFunction: () async {
                                  setState(() {
                                    if (firstNameController.text.isEmpty) {
                                      _firstNameErrorHint =
                                          'First name is required';
                                      _isFirstNameInputError = true;
                                    } else {
                                      if (isValidName(
                                          firstNameController.text)) {
                                        _isFirstNameInputError = false;
                                      } else {
                                        _firstNameErrorHint = 'Invalid format';
                                        _isFirstNameInputError = true;
                                      }
                                    }

                                    if (lastNameController.text.isEmpty) {
                                      _lastNameErrorHint =
                                          'Last name is required';
                                      _isLastNameInputError = true;
                                    } else {
                                      if (isValidName(
                                          lastNameController.text)) {
                                        _isLastNameInputError = false;
                                      } else {
                                        _lastNameErrorHint = 'Invalid format';
                                        _isLastNameInputError = true;
                                      }
                                    }

                                    if (emailController.text.isEmpty) {
                                      _emailErrorHint = 'Email is required';
                                      _isEmailInputError = true;
                                    } else {
                                      if (isValidEmailAddress(
                                          emailController.text)) {
                                        _isEmailInputError = false;
                                      } else {
                                        _emailErrorHint =
                                            'Invalid email format';
                                        _isEmailInputError = true;
                                      }
                                    }

                                    if (passwordController.text.isEmpty) {
                                      _passwordErrorHint =
                                          'Password is required';
                                      _isPasswordInputError = true;
                                    } else {
                                      if (isValidStrongPassword(
                                          passwordController.text)) {
                                        _isPasswordInputError = false;
                                      } else {
                                        _passwordErrorHint =
                                            'Weak password strength';
                                        _isPasswordInputError = true;
                                      }
                                    }

                                    if (confirmPasswordController
                                        .text.isEmpty) {
                                      _confirmPasswordErrorHint =
                                          'Confirm password is required';
                                      _isConfirmPasswordInputError = true;
                                    } else {
                                      if (passwordController.text ==
                                          confirmPasswordController.text) {
                                        _isConfirmPasswordInputError = false;
                                      } else {
                                        _confirmPasswordErrorHint =
                                            'Password mismatched';
                                        _isConfirmPasswordInputError = true;
                                      }
                                    }
                                  });

                                  if (!_isFirstNameInputError &&
                                      !_isLastNameInputError &&
                                      !_isEmailInputError &&
                                      !_isPasswordInputError &&
                                      !_isConfirmPasswordInputError) {
                                    try {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await _auth
                                          .createUserWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );

                                      // Get the current user after successful registration
                                      User? user = _auth.currentUser;

                                      // Update the user's display name
                                      if (user != null) {
                                        await user.updateDisplayName(
                                            "${firstNameController.text} ${lastNameController.text}");
                                      }

                                      Navigator.pushReplacement<void, void>(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const LoadingScreen(),
                                        ),
                                      );
                                    } catch (e) {
                                      setState(() {
                                        isLoading = false;
                                      });

                                      ToastBottomError('Something went wrong');
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        children: <Widget>[
                          const Text('Already have an account?',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: Palette.kDarkBlackColor)),
                          const SizedBox(width: 5.0),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement<void, void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: Palette.kPrimaryColor,
                              ),
                            ),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      const SizedBox(height: 60.0)
                    ],
                  ),
                ),
              ),
            ));
  }
}
