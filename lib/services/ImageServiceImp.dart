// ignore_for_file: unused_import, avoid_print

import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:stoop/services/ImageService.dart';

class MLKitImageService implements ImageService {
  final _textRecognizer = TextRecognizer();

  @override
  Future<Map<String, dynamic>?> extractImageData(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      if (recognizedText.text.isEmpty) {
        return null;
      }

      final Map<String, dynamic> data = {
        'text': recognizedText.text,
        'blocks': recognizedText.blocks.map((block) => block.text).toList(),
      };

      return data;
    } catch (e) {
      print('Error extracting image data: $e');
      return null;
    }
  }

  void dispose() {
    _textRecognizer.close();
  }
}