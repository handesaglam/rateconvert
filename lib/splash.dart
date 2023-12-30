import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  kPrimaryColor,
      child: Center(
        child: Image.asset("assets/images/monero.png",
        fit: BoxFit.cover,
        
        ),
      ),
    );
  }
}