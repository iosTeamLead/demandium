import 'package:flutter/material.dart';

class RippleButton extends StatelessWidget {
  const RippleButton({Key? key, required this.onTap}) : super(key: key);
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return  Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        hoverColor: Colors.transparent,
      ),
    );
  }
}
