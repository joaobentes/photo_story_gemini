import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_story_gemini/providers/photo_author_provider.dart';

class PhotoDisplay extends ConsumerWidget {
  final bool readOnly;

  const PhotoDisplay({super.key, this.readOnly = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoAuthorState = ref.watch(photoAuthorProvider);
    if (photoAuthorState.photo == null) {
      return const SizedBox.shrink();
    } else {
      return Center(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            SizedBox(
              height: 400,
              child: Image.file(
                ref.read(photoAuthorProvider).photo!,
                fit: BoxFit.cover,
              ),
            ),
            if (!readOnly)
              IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () {
                    ref.read(photoAuthorProvider.notifier).setPhoto(null);
                  }),
          ],
        ),
      );
    }
  }
}
