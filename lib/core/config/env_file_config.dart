import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> loadEnv() async {
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    print("Error occured durin loading the env file: $e");
  }
}
