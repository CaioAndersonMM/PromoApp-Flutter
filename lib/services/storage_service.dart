import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageService {
  Future<File> _getLocalFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$fileName');
  }

  Future<void> writeToFile(String fileName, String content) async {
    final file = await _getLocalFile(fileName);
    await file.writeAsString(content);
  }

  Future<String> readFromFile(String fileName) async {
    try {
      final file = await _getLocalFile(fileName);
      return await file.readAsString();
    } catch (e) {
      return '';
    }
  }
}
