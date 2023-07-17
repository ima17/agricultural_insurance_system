import 'package:flutter/material.dart';
import 'package:agricultural_insurance_system/models/application_data.dart';
import 'package:agricultural_insurance_system/utils/form_utils.dart';
import 'package:agricultural_insurance_system/widgets/button_widget.dart';
import 'package:agricultural_insurance_system/widgets/input_widget.dart';

class ApplicationScreen extends StatefulWidget {
  final ApplicationData? applicationData;

  const ApplicationScreen({Key? key, required this.applicationData})
      : super(key: key);

  @override
  _ApplicationScreenState createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.applicationData!.name ?? '';
  }

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
              InputWidget(
                inputName: 'name',
                inputPlaceholder: 'නම',
                errorHint: FormUtils.validateInput(
                  _nameController.text,
                  'නම',
                ),
                labelText: 'නම',
                textEditingController: _nameController,
                textInputType: TextInputType.text,
                isRequired: true,
                isError:
                    FormUtils.validateInput(_nameController.text, 'නම') != null,
                inputTriggerFunction: (value) {
                  setState(() {
                    widget.applicationData!.name = value;
                  });
                },
              ),
              SizedBox(height: 5.0),
              InputWidget(
                inputName: 'address',
                inputPlaceholder: 'ලිපිනය',
                errorHint: FormUtils.validateInput(
                  widget.applicationData!.address,
                  'ලිපිනය',
                ),
                labelText: 'ලිපිනය',
                initialText: widget.applicationData!.address,
                textInputType: TextInputType.text,
                inputValue: widget.applicationData!.address,
                isRequired: true,
                isError: FormUtils.validateInput(
                        widget.applicationData!.address, 'ලිපිනය') !=
                    null,
                inputTriggerFunction: (value) {
                  setState(() {
                    widget.applicationData!.address = value;
                  });
                },
              ),
              SizedBox(height: 5.0),
              InputWidget(
                inputName: 'contactNumber',
                inputPlaceholder: 'හැඳුනුම් අංකය',
                errorHint: FormUtils.validateInput(
                  widget.applicationData!.contactNumber,
                  'හැඳුනුම් අංකය',
                ),
                labelText: 'හැඳුනුම් අංකය',
                initialText: widget.applicationData!.contactNumber,
                textInputType: TextInputType.phone,
                inputValue: widget.applicationData!.contactNumber,
                isRequired: true,
                isError: FormUtils.validateInput(
                        widget.applicationData!.contactNumber,
                        'හැඳුනුම් අංකය') !=
                    null,
                inputTriggerFunction: (value) {
                  setState(() {
                    widget.applicationData!.contactNumber = value;
                  });
                },
              ),
              SizedBox(height: 5.0),
              InputWidget(
                inputName: 'dateOfBirth',
                inputPlaceholder: 'උපන්දිනය',
                errorHint: FormUtils.validateInput(
                  widget.applicationData!.dateOfBirth,
                  'උපන්දිනය',
                ),
                labelText: 'උපන්දිනය',
                initialText: widget.applicationData!.dateOfBirth,
                textInputType: TextInputType.datetime,
                inputValue: widget.applicationData!.dateOfBirth,
                isRequired: true,
                isError: FormUtils.validateInput(
                        widget.applicationData!.dateOfBirth, 'උපන්දිනය') !=
                    null,
                inputTriggerFunction: (value) {
                  setState(() {
                    widget.applicationData!.dateOfBirth = value;
                  });
                },
              ),
              SizedBox(height: 5.0),
              InputWidget(
                inputName: 'gender',
                inputPlaceholder: 'වී වර්ගය',
                errorHint: FormUtils.validateInput(
                  widget.applicationData!.gender,
                  'වී වර්ගය',
                ),
                labelText: 'වී වර්ගය',
                initialText: widget.applicationData!.gender,
                textInputType: TextInputType.text,
                inputValue: widget.applicationData!.gender,
                isRequired: true,
                isError: FormUtils.validateInput(
                        widget.applicationData!.gender, 'වී වර්ගය') !=
                    null,
                inputTriggerFunction: (value) {
                  setState(() {
                    widget.applicationData!.gender = value;
                  });
                },
              ),
              SizedBox(height: 5.0),
              InputWidget(
                inputName: 'occupation',
                inputPlaceholder: 'කන්නය',
                errorHint: FormUtils.validateInput(
                  widget.applicationData!.occupation,
                  'කන්නය',
                ),
                labelText: 'කන්නය',
                initialText: widget.applicationData!.occupation,
                textInputType: TextInputType.text,
                inputValue: widget.applicationData!.occupation,
                isRequired: true,
                isError: FormUtils.validateInput(
                        widget.applicationData!.occupation, 'කන්නය') !=
                    null,
                inputTriggerFunction: (value) {
                  setState(() {
                    widget.applicationData!.occupation = value;
                  });
                },
              ),
              SizedBox(height: 5.0),
              InputWidget(
                inputName: 'age',
                inputPlaceholder: 'වගා ක්‍රමය',
                errorHint: FormUtils.validateInput(
                  widget.applicationData!.age,
                  'වගා ක්‍රමය',
                ),
                labelText: 'වගා ක්‍රමය',
                initialText: widget.applicationData!.age,
                textInputType: TextInputType.number,
                inputValue: widget.applicationData!.age,
                isRequired: true,
                isError: FormUtils.validateInput(
                        widget.applicationData!.age, 'වගා ක්‍රමය') !=
                    null,
                inputTriggerFunction: (value) {
                  setState(() {
                    widget.applicationData!.age = value;
                  });
                },
              ),
              SizedBox(height: 5.0),
              InputWidget(
                inputName: 'propertySize',
                inputPlaceholder: 'ඉඩමේ ප්‍රමාණය',
                errorHint: FormUtils.validateInput(
                  widget.applicationData!.propertySize,
                  'ඉඩමේ ප්‍රමාණය',
                ),
                labelText: 'ඉඩමේ ප්‍රමාණය',
                initialText: widget.applicationData!.propertySize,
                textInputType: TextInputType.number,
                inputValue: widget.applicationData!.propertySize,
                isRequired: true,
                isError: FormUtils.validateInput(
                        widget.applicationData!.propertySize,
                        'ඉඩමේ ප්‍රමාණය') !=
                    null,
                inputTriggerFunction: (value) {
                  setState(() {
                    widget.applicationData!.propertySize = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ButtonWidget(
                buttonText: "Save",
                buttonTriggerFunction: _submitForm,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    FormUtils.submitForm(
      context: context,
      formKey: _formKey,
      nameController: _nameController,
      applicationData: widget.applicationData!,
    );
  }
}
