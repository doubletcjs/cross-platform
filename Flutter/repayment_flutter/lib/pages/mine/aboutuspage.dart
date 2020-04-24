import 'package:flutter/material.dart';
import 'package:repayment_flutter/public/public.dart';

class AboutusPage extends StatelessWidget {
  const AboutusPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "关于我们",
      ),
    );
  }
}
