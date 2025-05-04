import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

Future<File> convertBlobToFile(Uint8List imageBytes, String fileName) async {
  final tempDir = await getTemporaryDirectory();
  final filePath = '${tempDir.path}/$fileName';

  final file = File(filePath);
  await file.writeAsBytes(imageBytes);
  return file;
}

// The path_provider package in Flutter helps you locate commonly used file system directories on the device.
// These directories are platform-specific, and path_provider gives you a unified way to access them in both Android and iOS

// Why you need path_provider:
// If you want to read or write a file (like saving an image from a Uint8List), you need to know where to store it.
// You can’t just pick an arbitrary path — every OS has its own rules.

//  Common Directories Provided:
// Method                                                             	Description
// getTemporaryDirectory()                                 	Temporary storage, cleared by OS when needed. Good for caching files.
// getApplicationDocumentsDirectory()	                       Persistent storage for app-specific files. Survives app restarts.
// getExternalStorageDirectory() (Android only)             	Access external storage (like SD card). Requires permissions.

// HERE getTemporaryDirectory():
// This returns a temporary folder path, where you can save files like converted images. Example result:
// Android: /data/user/0/com.example.app/cache
// iOS: /var/mobile/Containers/Data/Application/.../tmp
