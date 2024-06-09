import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_story_gemini/providers/photo_author_provider.dart';

class PhotoAuthorScreen extends ConsumerWidget {
  const PhotoAuthorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoAuthorState = ref.watch(photoAuthorProvider);
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
          DropdownButton<String>(
            value: photoAuthorState.author,
            onChanged: (String? newValue) {
              ref.read(photoAuthorProvider.notifier).setAuthor(newValue!);
            },
            items: <String>['Author1', 'Author2', 'Author3']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}