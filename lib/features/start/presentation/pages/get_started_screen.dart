import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/core/routes/names.dart';
import 'package:assam_edu/core/storage_service/storage_service.dart';
import 'package:assam_edu/features/start/presentation/widgets/get_started_widgets.dart';
import 'package:assam_edu/init_dependencies.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBody: true,
      // extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            // Background text
            backGroundScreen(),
            // book Logo
            bookLogo(),
            //motivation text
            motivationText(),
            //Navigation text button
            navigationTextButton(
                context: context,
                buttonTextLeft: 'EDUCATOR',
                buttonTextRight: 'LEARNER',
                onPressedLeft: () {
                  storeAndNavigate(context, AppRoutes.EDUCATOR, "instructor");
                },
                onPressedRight: () {
                  storeAndNavigate(context, AppRoutes.LEARNER, "student");
                }),
            //Get started text
            mainText(text: 'GET STARTED'),
          ],
        ),
      ),
    );
  }

  void storeAndNavigate(
      BuildContext context, String route, String userType) async {
    try {
      final storageServices = getIt<StorageServices>();
      // Set user type
      final userTypeSave =
          await storageServices.setString(AppConstants.USER_TYPE, userType);
      // Set deviceFirst open
      final deviceFirstOpen = await storageServices.setDeviceFirstOpen(
          AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME, true);
      if (userTypeSave && deviceFirstOpen && context.mounted) {
        Navigator.pushNamed(context, route);
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
// class GetStartedScreen extends StatelessWidget {
//   const GetStartedScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     print("Get started screen is executed");
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Background text
//             backGroundScreen(),
//             //book Logo
//             bookLogo(),
//             //motivation text
//             motivationText(),
//             //Navigation text button
//             navigationTextButton(
//                 context: context,
//                 buttonTextLeft: 'EDUCATOR',
//                 buttonTextRight: 'LEARNER',
//                 onPressedLeft: () {
//                   //storeAndNavigate(context, AppRoutes.EDUCATOR);
//                 },
//                 onPressedRight: () {
//                   //storeAndNavigate(context, AppRoutes.LEARNER);
//                 }),
//             //Get started text
//             mainText(text: 'GET STARTED'),
//           ],
//         ),
//       ),
//     );
//   }

//   void storeAndNavigate(BuildContext context, String route) async {
//     try {
//       print("Accessing StorageServices"); //
//       final storageServices = GetIt.instance<StorageServices>();
//       final save = await storageServices.setDeviceFirstOpen(
//           AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME, true);
//       if (save == true && context.mounted) {
//         Navigator.pushNamed(context, route);
//       }
//     } catch (e) {
//       // Handle error: e.g., show an error message, log the error, etc.
//       print("Error: $e");
//     }
//   }
// }
