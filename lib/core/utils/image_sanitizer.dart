import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

/// Checks a picked photo's real type from its first bytes and re-encodes it as
/// a JPEG without EXIF (GPS, device data) before it leaves the phone. The
/// server repeats the check and re-encodes again.
class ImageSanitizer {
  const ImageSanitizer();

  static const int maxInputBytes = 8 * 1024 * 1024;
  static const int maxDimension = 1024;
  static const int jpegQuality = 85;
  static const String contentType = 'image/jpeg';

  static bool hasAllowedSignature(List<int> bytes) {
    if (bytes.length < 12) return false;
    final isJpeg = bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF;
    final isPng =
        bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47;
    final isWebp =
        bytes[0] == 0x52 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x46 &&
        bytes[8] == 0x57 &&
        bytes[9] == 0x45 &&
        bytes[10] == 0x42 &&
        bytes[11] == 0x50;
    return isJpeg || isPng || isWebp;
  }

  /// The cleaned JPEG, or null when the file isn't an accepted, decodable
  /// image within the size limit.
  Future<Uint8List?> sanitize(Uint8List bytes) {
    if (bytes.isEmpty ||
        bytes.length > maxInputBytes ||
        !hasAllowedSignature(bytes)) {
      return Future.value();
    }
    return compute(_reencode, bytes);
  }

  static Uint8List? _reencode(Uint8List bytes) {
    final decoded = img.decodeImage(bytes);
    if (decoded == null) return null;
    var image = img.bakeOrientation(decoded)..exif = img.ExifData();
    if (image.width > maxDimension || image.height > maxDimension) {
      image = image.width >= image.height
          ? img.copyResize(image, width: maxDimension)
          : img.copyResize(image, height: maxDimension);
    }
    return img.encodeJpg(image, quality: jpegQuality);
  }
}
