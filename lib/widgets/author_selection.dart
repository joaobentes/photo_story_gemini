import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_story_gemini/constants/strings.dart';
import 'package:photo_story_gemini/providers/photo_author_provider.dart';

class AuthorSelection extends ConsumerWidget {
  const AuthorSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoAuthorState = ref.watch(photoAuthorProvider);
    return Wrap(
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
    );
  }
}
