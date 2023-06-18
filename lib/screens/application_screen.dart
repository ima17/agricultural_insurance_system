import 'package:agricultural_insurance_system/models/application_data.dart';
import 'package:agricultural_insurance_system/screens/map_screen.dart';
import 'package:flutter/material.dart';

class ApplicationScreen extends StatefulWidget {
  final ApplicationData? applicationData;

  const ApplicationScreen({Key? key, required this.applicationData})
      : super(key: key);

  @override
  _ApplicationScreenState createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: widget.applicationData!.name,
                decoration: const InputDecoration(labelText: 'නම'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'නම ඇතුළත් කරන්න';
                  }
                  return null;
                },
                onSaved: (value) {
                  widget.applicationData!.name = value!;
                },
              ),
              TextFormField(
                initialValue: widget.applicationData!.address,
                decoration: const InputDecoration(labelText: 'ලිපිනය'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ලිපිනය ඇතුළත් කරන්න';
                  }
                  return null;
                },
                onSaved: (value) {
                  widget.applicationData!.address = value!;
                },
              ),
              TextFormField(
                initialValue: widget.applicationData!.contactNumber,
                decoration:
                    const InputDecoration(labelText: 'හැඳුනුම්පත් අංකය'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'හැඳුනුම්පත් අංකය ඇතුළත් කරන්න';
                  }
                  return null;
                },
                onSaved: (value) {
                  widget.applicationData!.contactNumber = value!;
                },
              ),
              TextFormField(
                initialValue: widget.applicationData!.dateOfBirth,
                decoration: const InputDecoration(labelText: 'උපන්දිනය'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'උපන්දිනය ඇතුළත් කරන්න';
                  }
                  return null;
                },
                onSaved: (value) {
                  widget.applicationData!.dateOfBirth = value!;
                },
              ),
              TextFormField(
                initialValue: widget.applicationData!.gender,
                decoration: const InputDecoration(labelText: 'වී වර්ගය'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'වී වර්ගය ඇතුළත් කරන්න';
                  }
                  return null;
                },
                onSaved: (value) {
                  widget.applicationData!.gender = value!;
                },
              ),
              TextFormField(
                initialValue: widget.applicationData!.occupation,
                decoration: const InputDecoration(labelText: 'කන්නය'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'කන්නය ඇතුළත් කරන්න';
                  }
                  return null;
                },
                onSaved: (value) {
                  widget.applicationData!.occupation = value!;
                },
              ),
              TextFormField(
                initialValue: widget.applicationData!.age,
                decoration: const InputDecoration(labelText: 'වගා ක්‍රමය'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'වගා ක්‍රමය ඇතුළත් කරන්න';
                  }
                  return null;
                },
                onSaved: (value) {
                  widget.applicationData!.age = value!;
                },
              ),
              TextFormField(
                initialValue: widget.applicationData!.propertySize,
                decoration: const InputDecoration(labelText: 'ඉඩමේ ප්‍රමාණය'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ඉඩමේ ප්‍රමාණය ඇතුළත් කරන්න';
                  }
                  return null;
                },
                onSaved: (value) {
                  widget.applicationData!.propertySize = value!;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _submitForm();
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Process the form submission
      print(widget.applicationData.toString());
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MapScreen(
                  applicationData: widget.applicationData,
                )),
      );
    }
  }
}
