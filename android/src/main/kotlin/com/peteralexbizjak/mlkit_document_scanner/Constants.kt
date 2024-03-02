package com.peteralexbizjak.mlkit_document_scanner

// Method names
internal const val START_DOCUMENT_SCANNER = "startDocumentScanner"

// Argument names
internal const val ARGUMENT_NUMBER_OF_PAGES = "maximumNumberOfPages"
internal const val ARGUMENT_GALLERY_IMPORT_ALLOWED = "galleryImportAllowed"
internal const val ARGUMENT_SCANNER_MODE = "scannerMode"

// Error codes and messages
internal const val ERROR_CODE_START_SCAN_INTENT_FAILURE = "error-start-scan-intent"
internal const val ERROR_MESSAGE_START_SCAN_INTENT_FAILURE =
    "Something went wrong trying to launch the Document Scanner activity"
