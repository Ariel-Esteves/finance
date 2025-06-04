import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageUploader {
  final ImagePicker _picker = ImagePicker();

  /// Picks an image from the gallery, saves it locally,
  /// and returns the local file path.
  Future<String?> saveImageFromGalleryLocally() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return null;

      final appDir = await getApplicationDocumentsDirectory();
      final extension = path.extension(pickedFile.path);
      final fileName =
          'image_${DateTime.now().millisecondsSinceEpoch}$extension';
      final localPath = path.join(appDir.path, fileName);

      final savedImage = await File(pickedFile.path).copy(localPath);

      print('Image saved locally at: ${savedImage.path}');
      return savedImage.path;
    } catch (e, stack) {
      print('Error saving image locally: $e\n$stack');
      return null;
    }
  }
}
