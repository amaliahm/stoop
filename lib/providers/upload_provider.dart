// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:stoop/models/UploadItem.dart';
import 'package:stoop/services/ImageService.dart';

class UploadProvider extends ChangeNotifier {
  final ImageService _imageService;
  bool _isProcessing = false;
  
  UploadProvider(this._imageService) {
    _initializeItems();
  }

  List<UploadItem> _uploadItems = [];
  int _currentStep = 1;

  List<UploadItem> get uploadItems => _uploadItems;
  int get currentStep => _currentStep;
  bool get canProceed => _uploadItems.every((item) => item.isUploaded);
  bool get isProcessing => _isProcessing;

  void _initializeItems() {
    _uploadItems = [
      UploadItem(title: 'UPLOAD YOUR ID CARD'),
      UploadItem(title: 'UPLOAD YOUR PHOTO'),
    ];
    notifyListeners();
  }

  Future<void> handleImagePicked(int index, String imagePath) async {
    try {
      _isProcessing = true;
      notifyListeners();

      print('Processing image at path: $imagePath');
      
      final imageData = await _imageService.extractImageData(imagePath);
      print('Extracted image data: $imageData');

      _uploadItems[index] = _uploadItems[index].copyWith(
        isUploaded: true,
        imagePath: imagePath,
        imageData: imageData,
      );
      
    } catch (e) {
      print('Error processing image: $e');
    } finally {
      _isProcessing = false;
      notifyListeners();
    }
  }

  void proceed(BuildContext context) {
    if (_currentStep < 2) {
      _currentStep++;
      notifyListeners();
    } else {
      // next screen
    }
  }
}