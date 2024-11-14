import 'package:flutter/material.dart';

class DemoPage extends StatelessWidget {
  static const String routeName = '/demo-page';
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('DEMO PAGE'),
      ),
    );
  }
}
