import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_story_gemini/providers/photo_author_provider.dart';

class StoryIntroScreen extends ConsumerWidget {
  const StoryIntroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storyIntroAsyncValue = ref.watch(storyIntroProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Story Intro')),
      body: storyIntroAsyncValue.when(
        data: (storyIntro) => Text('Story Intro: $storyIntro'),
        loading: () => const CircularProgressIndicator(),
        error: (err, stack) => Text('Error: $err'),
      ),
    );
  }
}