import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../configs/palette.dart';

class LoadingWidget extends StatelessWidget {
  final String? text;
  const LoadingWidget({
    super.key,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitDoubleBounce(
            color: Palette.kPrimaryColor,
            size: 100.0,
          ),
          SizedBox(height: 16),
          Text(
            text!,
          ),
        ],
      ),
    );
  }
}
