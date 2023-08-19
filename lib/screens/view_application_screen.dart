import 'package:agricultural_insurance_system/models/value_object_data.dart';
import 'package:agricultural_insurance_system/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/info_card.dart';

class ViewApplicationScreen extends StatefulWidget {
  final List<ValueObject>? valueObject;
  final String policyNo;
  const ViewApplicationScreen(
      {super.key, this.valueObject, required this.policyNo});

  @override
  State<ViewApplicationScreen> createState() => _ViewApplicationScreenState();
}

class _ViewApplicationScreenState extends State<ViewApplicationScreen> {
  @override
  void initState() {
    print(widget.valueObject);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 0,
        title: widget.policyNo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  itemCount: widget.valueObject!.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final title = widget.valueObject![index].title;
                    final value = widget.valueObject![index].value;

                    return InfoCard(
                      icon: FontAwesomeIcons.solidCircle,
                      infoTitle: title,
                      info: value,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
