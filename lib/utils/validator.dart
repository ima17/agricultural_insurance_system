import 'package:regexed_validator/regexed_validator.dart';

bool isValidEmailAddress(String input) {
  return validator.email(input);
}

bool isValidName(String input) {
  return RegExp(r'^[a-zA-Z0-9]+$', caseSensitive: false).hasMatch(input);
}

bool isValidPhoneNumber(String input) {
  return validator.phone(input);
}

bool isValidPostalCode(String input) {
  return validator.postalCode(input);
}

bool isValidStrongPassword(String input) {
  return validator.password(input);
}