// ignore_for_file: file_names

class UploadItem {
  final String title;
  final bool isUploaded;
  final String? imagePath;
  final Map<String, dynamic>? imageData;

  UploadItem({
    required this.title,
    this.isUploaded = false,
    this.imagePath,
    this.imageData,
  });

  UploadItem copyWith({
    String? title,
    bool? isUploaded,
    String? imagePath,
    Map<String, dynamic>? imageData,
  }) {
    return UploadItem(
      title: title ?? this.title,
      isUploaded: isUploaded ?? this.isUploaded,
      imagePath: imagePath ?? this.imagePath,
      imageData: imageData ?? this.imageData,
    );
  }
}