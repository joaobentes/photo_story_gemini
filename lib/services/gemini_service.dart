import 'dart:io';

class GeminiService {
  Future<String> getStoryIntro(String photoPath, String author) async {
    final file = File(photoPath);

    if (await file.exists()) {
      return Future.delayed(const Duration(seconds: 2), () => 'Mocked intro');
    } else {
      throw Exception('File does not exist');
    }
  }
}