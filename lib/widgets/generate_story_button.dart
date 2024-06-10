import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_story_gemini/providers/photo_author_provider.dart';
import 'package:photo_story_gemini/screens/story_intro_screen.dart';

class GenerateStoryButton extends ConsumerWidget {
  const GenerateStoryButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
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
              content: Text('Please select a photo and an author first.'),
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
    );
  }
}
