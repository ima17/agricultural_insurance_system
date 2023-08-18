import 'package:agricultural_insurance_system/configs/palette.dart';
import 'package:agricultural_insurance_system/widgets/custom_app_bar.dart';
import 'package:agricultural_insurance_system/widgets/filled_application_card.dart';
import 'package:agricultural_insurance_system/widgets/input_widget.dart';
import 'package:agricultural_insurance_system/widgets/loading_widget.dart';
import 'package:agricultural_insurance_system/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/value_object_data.dart';

class FilledApplicationScreen extends StatefulWidget {
  const FilledApplicationScreen({Key? key}) : super(key: key);

  @override
  _FilledApplicationScreenState createState() =>
      _FilledApplicationScreenState();
}

class _FilledApplicationScreenState extends State<FilledApplicationScreen> {
  List<ValueObject> values = [];
  List<ValueObject> filteredValues = [];
  String searchQuery = '';
  bool isLoading = true;

  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    retrieveValues();
  }

  Future<void> retrieveValues() async {
    try {
      final querySnapshot = await _fireStore
          .collection('applications')
          .where('email', isEqualTo: _auth.currentUser!.email)
          .get();

      values = [];
      for (final docSnapshot in querySnapshot.docs) {
        final jsonValues = docSnapshot.data()['application'] as List<dynamic>;
        print(jsonValues);
        final applicationValues = jsonValues
            .map((jsonValue) => ValueObject.fromJson(jsonValue))
            .toList();
        print(applicationValues);

        final policyNumberValue = applicationValues.firstWhere(
          (value) => value.title == 'Policy Number',
          orElse: () => ValueObject(
            title: '',
            value: '',
            icon: FontAwesomeIcons.solidCircle,
          ),
        );
        print(policyNumberValue);
        final nameValue = applicationValues.firstWhere(
          (value) => value.title == 'Name',
          orElse: () => ValueObject(
            title: '',
            value: '',
            icon: FontAwesomeIcons.solidCircle,
          ),
        );

        final cardValue = ValueObject(
          title: policyNumberValue.value,
          value: nameValue.value,
          icon: FontAwesomeIcons.hashtag,
          originalObject: applicationValues,
        );

        values.add(cardValue);
      }

      filteredValues = List.from(values);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      ToastBottomError("Something went wrong");
    }
  }

  void filterValues() {
    filteredValues = values.where((valueObject) {
      final title = valueObject.title.toLowerCase();
      final value = valueObject.value.toLowerCase();
      final query = searchQuery.toLowerCase();

      return title.contains(query) || value.contains(query);
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingWidget()
        : Scaffold(
            appBar: CustomAppBar(elevation: 0, title: 'Filled Applications'),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  InputWidget(
                    inputPlaceholder: 'Search',
                    trailingIcon: Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 15,
                      color: Palette.kPrimaryColor,
                    ),
                    inputTriggerFunction: (value) {
                      setState(() {
                        searchQuery = value;
                        filterValues();
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  filteredValues.isEmpty
                      ? Text(
                          'No filled Applications yet. ',
                          style: TextStyle(
                              fontSize: 12.0, color: Palette.kHeadingColor),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: filteredValues.length,
                            itemBuilder: (context, index) {
                              final valueObject = filteredValues[index];

                              return FilledApplicationCard(
                                valueObject: valueObject,
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          );
  }
}
