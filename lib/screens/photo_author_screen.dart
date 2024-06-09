import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_story_gemini/constants/strings.dart';
import 'package:photo_story_gemini/providers/photo_author_provider.dart';
import 'package:photo_story_gemini/screens/story_intro_screen.dart';

class PhotoAuthorScreen extends ConsumerWidget {
  const PhotoAuthorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoAuthorState = ref.watch(photoAuthorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Generate a intro for your photo')),
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt),
            onPressed: () {
              ref.read(photoAuthorProvider.notifier).reset();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              const Text(
                '1) Take or upload a photo',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (pickedFile != null) {
                        ref
                            .read(photoAuthorProvider.notifier)
                            .setPhoto(File(pickedFile.path));
                      }
                    },
                    child: const Text('Take a photo'),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        ref
                            .read(photoAuthorProvider.notifier)
                            .setPhoto(File(pickedFile.path));
                      }
                    },
                    child: const Text('Upload a photo'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              if (photoAuthorState.photo != null)
                Center(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      SizedBox(
                        height: 400,
                        child: Image.file(
                          photoAuthorState.photo!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          ref.read(photoAuthorProvider.notifier).setPhoto(null);
                        },
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16.0),
              const Text(
                '2) Select one of the following authors:',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 16.0),
              Wrap(
                spacing: 5.0,
                runSpacing: 5.0,
                children: List<Widget>.generate(
                  authors.length,
                  (int index) {
                    return ChoiceChip(
                      label: Text(authors[index]),
                      selected: photoAuthorState.author == authors[index],
                      onSelected: (bool selected) {
                        ref.read(photoAuthorProvider.notifier).setAuthor(
                              selected ? authors[index] : null,
                            );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (ref.read(photoAuthorProvider).author != null &&
                    ref.read(photoAuthorProvider).photo != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StoryIntroScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Please select a photo and an author first.'),
                    ),
                  );
                }
              },
              child: const Row(
                children: [
                  Text('Generate Story Intro'),
                  Icon(Icons.navigate_next),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
