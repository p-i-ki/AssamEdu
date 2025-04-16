import 'package:assam_edu/core/app_constants/app_constants.dart';
import 'package:assam_edu/core/config/env_file_config.dart';
import 'package:assam_edu/core/routes/pages.dart';
import 'package:assam_edu/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnv();
  print('Server_Api_Url: ${AppConstants.SERVER_API_URL}');
  await Global.init();
  configLoading();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppPages.allBlocProviders(context),
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(412, 915),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            builder: (context, widget) {
              // Force status bar styling here
              SystemChrome.setSystemUIOverlayStyle(
                const SystemUiOverlayStyle(
                  statusBarColor: Colors.black, // Set to black
                  statusBarIconBrightness: Brightness.dark, // Icons in white
                  statusBarBrightness: Brightness.dark, // For iOS
                ),
              );
              return EasyLoading.init()(context, widget);
            },
            //builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            title: 'Assam Edu',
            //----- Dark Themese to be added----
            // themeMode: ThemeMode.dark,
            // darkTheme: ThemeData(),
            theme: ThemeData(
              fontFamily: 'myfontsdroid',
              colorScheme: const ColorScheme.light(
                primary: Color.fromRGBO(253, 245, 231, 1),
              ),
              useMaterial3: true,
            ),
            onGenerateRoute: (settings) => AppPages.generateRoute(settings),
          );
        },
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom // Use custom style
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.transparent // Make background transparent
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withValues(alpha: 0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}
