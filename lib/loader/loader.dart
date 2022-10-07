import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
