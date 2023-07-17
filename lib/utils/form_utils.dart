import 'package:flutter/material.dart';

import '../models/application_data.dart';
import '../screens/map_screen.dart';

class FormUtils {
  static void submitForm({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required ApplicationData applicationData,
  }) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if (validateInput(nameController.text, 'නම') != null ||
          validateInput(applicationData.address, 'ලිපිනය') != null ||
          validateInput(applicationData.contactNumber, 'හැඳුනුම් අංකය') !=
              null ||
          validateInput(applicationData.dateOfBirth, 'උපන්දිනය') != null ||
          validateInput(applicationData.gender, 'වී වර්ගය') != null ||
          validateInput(applicationData.occupation, 'කන්නය') != null ||
          validateInput(applicationData.age, 'වගා ක්‍රමය') != null ||
          validateInput(applicationData.propertySize, 'ඉඩමේ ප්‍රමාණය') !=
              null) {
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapScreen(
            applicationData: applicationData,
          ),
        ),
      );
    }
  }

  static String? validateInput(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName ඇතුළත් කරන්න';
    }
    return null;
  }
}
