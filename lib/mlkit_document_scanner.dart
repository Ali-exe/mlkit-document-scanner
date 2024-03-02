import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

final class MlkitDocumentScannerPlugin extends PlatformInterface {
  static const _methodChannel =
      MethodChannel('mlkit_document_scanner_method_channel');
  static const _eventChannel =
      EventChannel('mlkit_document_scanner_event_channel');

  MlkitDocumentScannerPlugin({required super.token});

  Stream<Uint8List> get scanResults {
    return _eventChannel
        .receiveBroadcastStream()
        .map((event) => event as Uint8List);
  }

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

enum MlkitDocumentScannerMode {
  full(1),
  base(3),
  baseWithFilter(2);

  final int code;

  const MlkitDocumentScannerMode(this.code);
}
