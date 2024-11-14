import 'package:assam_edu/core/routes/names.dart';
import 'package:assam_edu/features/start/presentation/widgets/get_started_widgets.dart';
import 'package:flutter/material.dart';

class EducatorScreen extends StatelessWidget {
  const EducatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background text
            backGroundScreen(),
            //book Logo
            bookLogo(),
            //motivation text
            motivationText(),
            //Navigation text button
            navigationTextButton(
              context: context,
              buttonTextLeft: 'LOGIN',
              buttonTextRight: 'SIGN UP',
              onPressedLeft: () {
                Navigator.pushNamed(context, AppRoutes.SIGN_IN);
              },
              onPressedRight: () {
                Navigator.pushNamed(context, AppRoutes.SIGN_UP);
              },
            ),
            //Get started text
            mainText(text: 'EDUCATOR'),
          ],
        ),
      ),
    );
  }
}
