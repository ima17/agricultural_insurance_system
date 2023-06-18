import 'package:agricultural_insurance_system/models/application_data.dart';
import 'package:flutter/material.dart';

class ApplicationScreen extends StatelessWidget {
  final ApplicationData? applicationData;
  const ApplicationScreen({super.key, required this.applicationData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: applicationData!.name,
                decoration: const InputDecoration(labelText: 'නම'),
              ),
              TextFormField(
                initialValue: applicationData!.address,
                decoration: const InputDecoration(labelText: 'ලිපිනය'),
              ),
              TextFormField(
                initialValue: applicationData!.contactNumber,
                decoration: const InputDecoration(labelText: 'හැඳුනුම්පත් අංකය'),
              ),
              TextFormField(
                initialValue: applicationData!.dateOfBirth,
                decoration: const InputDecoration(labelText: 'උපන්දිනය'),
              ),
              TextFormField(
                initialValue: applicationData!.gender,
                decoration: const InputDecoration(labelText: 'වී වර්ගය'),
              ),
              TextFormField(
                initialValue: applicationData!.occupation,
                decoration: const InputDecoration(labelText: 'කන්නය'),
              ),
              TextFormField(
                initialValue: applicationData!.age,
                decoration: const InputDecoration(labelText: 'වගා ක්‍රමය'),
              ),
              TextFormField(
                initialValue: applicationData!.propertySize,
                decoration: const InputDecoration(labelText: 'ඉඩමේ ප්‍රමාණය'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Handle form submission
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
