import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CommonLogo extends StatelessWidget {
  const CommonLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          "assets/logo.png",
          width: 100,
        ),
        "To-Do App".text.xl2.make(),
        "Keep Your Tasks In This App".text.light.white.wider.lg.make(),
      ],
    );
  }
}
