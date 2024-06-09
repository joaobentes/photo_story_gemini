import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_story_gemini/providers/photo_author_provider.dart';

class StoryIntroScreen extends ConsumerWidget {
  const StoryIntroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoAuthorState = ref.watch(photoAuthorProvider);
    final storyIntroAsyncValue = ref.watch(storyIntroProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Story Intro')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (photoAuthorState.photo != null)
                Center(
                  child: SizedBox(
                    height: 400,
                    child: Image.file(
                      photoAuthorState.photo!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 16.0),
              RichText(
                text: TextSpan(
                  text: 'Intro by ',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${photoAuthorState.author}',
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              storyIntroAsyncValue.when(
                data: (storyIntro) => Text(
                  storyIntro,
                  style: const TextStyle(fontSize: 20),
                ),
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => Text('Error: $err'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
