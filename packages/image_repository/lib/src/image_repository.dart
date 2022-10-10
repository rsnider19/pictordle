// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// {@template image_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ImageRepository {
  /// {@macro image_repository}
  ImageRepository(
    FirebaseStorage firebaseStorage,
  ) : _firebaseStorage = firebaseStorage;

  final FirebaseStorage _firebaseStorage;

  late String _imageUrl;

  String get imageUrl => _imageUrl;

  Future<void> loadImage(String wordOfTheDay) async {
    final ref = 'pictordles/${wordOfTheDay.toLowerCase()}.png';
    _imageUrl = await _firebaseStorage.ref().child(ref).getDownloadURL();

    await DefaultCacheManager().downloadFile(_imageUrl);
  }
}
