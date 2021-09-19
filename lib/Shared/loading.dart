import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(229, 229, 229, 1),
      child: Center(
        child: SpinKitRing(
          color: Colors.red,
          size: 50,
        ),
      ),
    );
  }
}
