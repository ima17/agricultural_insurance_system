import 'package:agricultural_insurance_system/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import '../configs/palette.dart';
import '../widgets/button_widget.dart';
import '../widgets/input_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _emailAddressInputError = false;
  bool _passwordInputError = false;

  final String _emailAddressErrorHint = 'Enter your email address';
  final String _passwordErrorHint = 'Enter your password';

  bool _passwordObscurity = true;
  IconData? trailingIcon;
  final String email = "test@email.com";
  final String password = "test123";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Palette.kPrimaryColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/images/back.png'),
              opacity: 0.8,
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: Image.asset('assets/icons/icon.png'),
                  ),
                  SizedBox(height: size.height * 0.02),
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                      color: Palette.kPrimaryColor,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InputWidget(
                          textEditingController: emailController,
                          textInputType: TextInputType.emailAddress,
                          inputPlaceholder: 'Enter your email address',
                          leadingIcon: const Icon(
                            Icons.email_outlined,
                            size: 20.0,
                            color: Palette.kInputPlaceholderColor,
                          ),
                          errorHint: _emailAddressErrorHint,
                          isError: _emailAddressInputError,
                        ),
                        const SizedBox(height: 5.0),
                        InputWidget(
                          textEditingController: passwordController,
                          inputPlaceholder: _passwordErrorHint,
                          trailingIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _passwordObscurity = !_passwordObscurity;
                                if (_passwordObscurity == true) {
                                  trailingIcon = Icons.visibility;
                                } else {
                                  trailingIcon = Icons.visibility_off;
                                }
                              });
                            },
                            child: Icon(
                              trailingIcon ?? Icons.visibility,
                              size: 20.0,
                              color: Palette.kInputPlaceholderColor,
                            ),
                          ),
                          leadingIcon: const Icon(
                            Icons.lock_open,
                            size: 20.0,
                            color: Palette.kInputPlaceholderColor,
                          ),
                          errorHint: 'Enter your password',
                          isError: _passwordInputError,
                          isObscureText: _passwordObscurity,
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: InkWell(
                            onTap: () => () {},
                            child: const Text(
                              'Forgot Password?',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: Palette.kInvalidInputHintColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ButtonWidget(
                          buttonText: "Login",
                          buttonBGColor: Palette.kPrimaryColor,
                          buttonTextColor: Palette.kLightWhiteColor,
                          buttonTriggerFunction: () async {
                            setState(() {
                              _emailAddressInputError =
                                  emailController.text.isEmpty;
                              _passwordInputError =
                                  passwordController.text.isEmpty;
                            });

                            if (emailController.text == email &&
                                passwordController.text == password) {
                              Navigator.pushReplacement<void, void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const LoadingScreen(),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: size.height * 0.015),
                        const Text(
                          'OR',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(height: size.height * 0.015),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    children: <Widget>[
                      const Text(
                        'New user?',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Palette.kDarkBlackColor,
                        ),
                      ),
                      TextButton(
                        child: const Text(
                          'Sign up here',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: Palette.kPrimaryColor,
                          ),
                        ),
                        onPressed: () {},
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}