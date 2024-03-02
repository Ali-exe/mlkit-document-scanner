import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mlkit_document_scanner/mlkit_document_scanner.dart';

void main() {
  runApp(const MyApp());
}

final class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final class _MyAppState extends State<MyApp> {
  final MlkitDocumentScannerPlugin _mlkitDocumentScannerPlugin =
      MlkitDocumentScannerPlugin(token: Object());
  late final Stream<Uint8List> _pdfDocumentStream;

  @override
  void initState() {
    super.initState();
    _pdfDocumentStream = _mlkitDocumentScannerPlugin.scanResults;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextButton(
                onPressed: () =>
                    _mlkitDocumentScannerPlugin.startDocumentScanner(
                  maximumNumberOfPages: 1,
                  galleryImportAllowed: true,
                  scannerMode: MlkitDocumentScannerMode.full,
                ),
                child: const Text('Start scanner'),
              ),
              StreamBuilder(
                stream: _pdfDocumentStream,
                builder: (BuildContext context, AsyncSnapshot<Uint8List> data) {
                  return data.hasData && data.data != null
                      ? Text(
                          'Received PDF of ${data.data?.lengthInBytes} bytes')
                      : const Text('No PDF data yet');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
