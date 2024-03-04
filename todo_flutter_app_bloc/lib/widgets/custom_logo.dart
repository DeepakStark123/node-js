import 'package:flutter/material.dart';

class CommonLogo extends StatelessWidget {
  const CommonLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          child: Image.asset(
            "assets/logo.png",
            width: 120,
            height: 120,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Note Keeper",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        const Text(
          "Keep Your Tasks In This App",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
