import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_story_gemini/providers/photo_author_provider.dart';

class PhotoButton extends ConsumerWidget {
  final ImageSource source;
  final String buttonText;

  const PhotoButton(
      {super.key, required this.source, required this.buttonText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        final pickedFile = await ImagePicker().pickImage(source: source);
        if (pickedFile != null) {
          ref
              .read(photoAuthorProvider.notifier)
              .setPhoto(File(pickedFile.path));
        }
      },
      child: Text(buttonText),
    );
  }
}
