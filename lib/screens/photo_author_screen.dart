import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_story_gemini/providers/photo_author_provider.dart';
import 'package:photo_story_gemini/widgets/author_selection.dart';
import 'package:photo_story_gemini/widgets/generate_story_button.dart';
import 'package:photo_story_gemini/widgets/photo_button.dart';
import 'package:photo_story_gemini/widgets/photo_display.dart';
import 'package:photo_story_gemini/widgets/spacer.dart';

class PhotoAuthorScreen extends ConsumerWidget {
  const PhotoAuthorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultSpacer(),
              Text(
                '1) Take or upload a photo',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PhotoButton(
                    source: ImageSource.camera,
                    buttonText: 'Take a photo',
                  ),
                  SizedBox(width: 16.0),
                  PhotoButton(
                    source: ImageSource.gallery,
                    buttonText: 'Upload a photo',
                  ),
                ],
              ),
              DefaultSpacer(),
              PhotoDisplay(),
              DefaultSpacer(),
              Text(
                '2) Select one of the following authors:',
                style: TextStyle(fontSize: 18.0),
              ),
              DefaultSpacer(),
              AuthorSelection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GenerateStoryButton(),
          ],
        ),
      ),
    );
  }
}
