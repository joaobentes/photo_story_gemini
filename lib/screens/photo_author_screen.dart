import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_story_gemini/providers/photo_author_provider.dart';
import 'package:photo_story_gemini/screens/story_intro_screen.dart';

class PhotoAuthorScreen extends ConsumerWidget {
  const PhotoAuthorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoAuthorState = ref.watch(photoAuthorProvider);
    final authors = ['Author1', 'Author2', 'Author3']; // List of authors

    return Scaffold(
      appBar: AppBar(title: const Text('Take a photo and select an author')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
              if (pickedFile != null) {
                ref.read(photoAuthorProvider.notifier).setPhoto(File(pickedFile.path));
              }
            },
            child: const Text('Take a photo'),
          ),
          if (photoAuthorState.photo != null)
            Image.file(
              photoAuthorState.photo!,
              width: 300, // You can adjust the size as needed
              height: 300, // You can adjust the size as needed
            ),
          Expanded(
            child: ListView.builder(
              itemCount: authors.length,
              itemBuilder: (context, index) {
                return RadioListTile<String>(
                  title: Text(authors[index]),
                  value: authors[index],
                  groupValue: photoAuthorState.author,
                  onChanged: (String? value) {
                    ref.read(photoAuthorProvider.notifier).setAuthor(value!);
                  },
                );
              },
            ),
          ),
    ElevatedButton(
  onPressed: () {
    final author = ref.read(photoAuthorProvider).author;
    final photo = ref.read(photoAuthorProvider).photo;
    if (author != null && photo != null) {
      // Navigate to the StoryIntro page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const StoryIntroScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please take a photo and select an author first.')),
      );
    }
  },
  child: const Text('Generate Story Intro'),
),
        ],
      ),
    );
  }
}