import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_story_gemini/services/gemini_service.dart';

final photoAuthorProvider = StateNotifierProvider<PhotoAuthorController, PhotoAuthorState>((ref) => PhotoAuthorController());

final geminiServiceProvider = Provider<GeminiService>((ref) => GeminiService());

final storyIntroProvider = FutureProvider<String>((ref) async {
  final photoAuthorState = ref.watch(photoAuthorProvider);
  final geminiService = ref.watch(geminiServiceProvider);
  return await geminiService.getStoryIntro(photoAuthorState.photo!.path, photoAuthorState.author!);
});

class PhotoAuthorController extends StateNotifier<PhotoAuthorState> {
  PhotoAuthorController() : super(const PhotoAuthorState());

  void setPhoto(File newPhoto) {
    state = state.copyWith(photo: newPhoto);
  }

  void setAuthor(String newAuthor) {
    state = state.copyWith(author: newAuthor);
  }
}

@immutable
class PhotoAuthorState {
  final File? photo;
  final String? author;

  const PhotoAuthorState({this.photo, this.author});

  PhotoAuthorState copyWith({File? photo, String? author}) {
    return PhotoAuthorState(
      photo: photo ?? this.photo,
      author: author ?? this.author,
    );
  }
}