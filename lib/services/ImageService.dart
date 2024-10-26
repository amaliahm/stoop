// ignore_for_file: file_names

abstract class ImageService {
  Future<Map<String, dynamic>?> extractImageData(String imagePath);
}