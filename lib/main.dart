import 'package:assam_edu/core/routes/pages.dart';
//import 'package:assam_edu/features/course/course_detail/presentation/pages/course_detail_screen.dart';
import 'package:assam_edu/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Global.init();
  print("Initialization complete"); // Debugging line
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: CourseDetailScreen(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppPages.allBlocProviders(context),
      child: ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp(
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            title: 'Assam Edu',
            theme: ThemeData(
              fontFamily: 'myfontsdroid',
              colorScheme: const ColorScheme.light(
                primary: Color.fromRGBO(253, 245, 231, 1),
              ),
              useMaterial3: true,
            ),
            onGenerateRoute: (settings) => AppPages.generateRoute(settings),
            //home: const SignInScreen(),
          );
        },
      ),
    );
  }
}
