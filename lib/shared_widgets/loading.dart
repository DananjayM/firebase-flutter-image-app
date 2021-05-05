import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  Loading({@required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(color),
        strokeWidth: 3.0,
      ),
      height: MediaQuery.of(context).size.height * 0.03,
      width: MediaQuery.of(context).size.height * 0.03,
    );
  }
}
