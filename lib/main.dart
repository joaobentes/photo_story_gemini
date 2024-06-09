import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_story_gemini/screens/photo_author_screen.dart';

void main() {
  runApp(const ProviderScope(child: PhotoStoryApp()));
}

class PhotoStoryApp extends StatelessWidget {
  const PhotoStoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intro generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PhotoAuthorScreen(),
    );
  }
}
