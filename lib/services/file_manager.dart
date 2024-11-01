import 'dart:async';
import 'dart:io';
// import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class FilesManipulator {
  //
  //getting root directory for file storage
  Future<String> getRootDirectory() async {
    final fileDirectory = await getApplicationDocumentsDirectory();

    return fileDirectory.path;
  }

  //
  //initiating file
  Future<File> getFile() async {
    final filePath = await getRootDirectory();

    return File("$filePath/choice_file_name.txt");
  }

  //
  //reading from file
  Future<int> readFile() async {
    try {
      final file = await getFile();

      String contents = await file.readAsString();
      return int.parse(contents);
    } catch (e) {
      return 0;
    }
  }

  //
  //writting to file
  Future<File> writeFile(int counterNumber) async {
    final file = await getFile();

    return file.writeAsString("$counterNumber");
  }

  //
  //Deleting file
  Future deleteFile() async {
    final file = await getFile();
    return file.delete();
  }
}
