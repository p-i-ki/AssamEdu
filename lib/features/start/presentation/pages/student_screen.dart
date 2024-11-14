import 'package:assam_edu/core/routes/names.dart';
import 'package:assam_edu/features/start/presentation/widgets/get_started_widgets.dart';
import 'package:flutter/material.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background text
            backGroundScreen(),
            //book logo
            bookLogo(),
            //motivation text
            motivationText(),
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
            mainText(text: 'LEARNER')
          ],
        ),
      ),
    );
  }
}
