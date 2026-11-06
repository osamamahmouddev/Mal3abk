import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:mal3abk/core/utils/image_sanitizer.dart';

void main() {
  const sanitizer = ImageSanitizer();

  Uint8List jpegWithGps({int width = 40, int height = 20}) {
    final image = img.Image(width: width, height: height);
    image.exif.gpsIfd['GPSLatitude'] = img.IfdValueRational(30, 1);
    image.exif.imageIfd['Make'] = img.IfdValueAscii('Phone');
    return img.encodeJpg(image);
  }

  test('re-encodes a JPEG without its EXIF data', () async {
    final source = jpegWithGps();
    expect(img.decodeJpgExif(source)?.isEmpty, isFalse);

    final clean = await sanitizer.sanitize(source);

    expect(clean, isNotNull);
    expect(ImageSanitizer.hasAllowedSignature(clean!), isTrue);
    expect(img.decodeJpgExif(clean)?.isEmpty ?? true, isTrue);
  });

  test('scales large photos down', () async {
    final clean = await sanitizer.sanitize(
      jpegWithGps(width: 3000, height: 1500),
    );

    final decoded = img.decodeJpg(clean!)!;
    expect(decoded.width, ImageSanitizer.maxDimension);
    expect(decoded.height, 512);
  });

  test('rejects files that only claim to be images', () async {
    final script = Uint8List.fromList('<script>alert(1)</script>'.codeUnits);
    final truncated = Uint8List.fromList([
      0xFF,
      0xD8,
      0xFF,
      0xE0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ]);

    expect(await sanitizer.sanitize(script), isNull);
    expect(await sanitizer.sanitize(truncated), isNull);
    expect(await sanitizer.sanitize(Uint8List(0)), isNull);
  });
}
