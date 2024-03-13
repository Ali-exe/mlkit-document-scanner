/// Flutter plugin bringing MLKit Document Scanner to Flutter.
library mlkit_document_scanner;

import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// This is the main plugin class. You should be able to instantiate the class,
/// use the [startDocumentScanner] method to configure and start a scanner,
/// and collect PDF scan data from the [scanResults] stream.
final class MlkitDocumentScannerPlugin extends PlatformInterface {
  static const _methodChannel =
      MethodChannel('mlkit_document_scanner_method_channel');
  static const _eventChannel =
      EventChannel('mlkit_document_scanner_event_channel');

  MlkitDocumentScannerPlugin({required super.token});

  /// This stream contains full stream of PDF data that came from the PDF scan.
  Stream<Uint8List> get scanResults {
    return _eventChannel
        .receiveBroadcastStream()
        .map((event) => event as Uint8List);
  }

  /// This method starts the document scanner. It tries to mimic the official
  /// API as much as possible. Refer to this URL for more information:
  /// https://developers.google.com/ml-kit/vision/doc-scanner.
  ///
  /// - [maximumNumberOfPages] sets the limit to the number of pages scanned.
  /// - [galleryImportAllowed] enable or disable the capability to import from
  /// the photo gallery.
  /// - [scannerMode] customize the editing functionalities available to the
  /// user by choosing from 3 modes available in [MlkitDocumentScannerMode].
  Future<void> startDocumentScanner({
    required int maximumNumberOfPages,
    required bool galleryImportAllowed,
    required MlkitDocumentScannerMode scannerMode,
  }) async {
    await _methodChannel.invokeMethod('startDocumentScanner', {
      'maximumNumberOfPages': maximumNumberOfPages,
      'galleryImportAllowed': galleryImportAllowed,
      'scannerMode': scannerMode.code,
    });
  }
}

/// Options that the MLKit Document Scanner allows.
enum MlkitDocumentScannerMode {
  /// Adds ML-enabled image cleaning capabilities (erase stains, fingers, etc…)
  /// to the [MlkitDocumentScannerMode.baseWithFilter] mode. This mode will also
  /// allow future major features to be automatically added along with Google
  /// Play services updates, while the other two modes will maintain their
  /// current feature sets and only receive minor refinements.
  full(1),

  /// Basic editing capabilities (crop, rotate, reorder pages, etc…).
  base(3),

  /// Adds image filters (grayscale, auto image enhancement, etc…) to the
  /// [MlkitDocumentScannerMode.base] mode.
  baseWithFilter(2);

  /// Only used internally.
  final int code;

  const MlkitDocumentScannerMode(this.code);
}
