package com.peteralexbizjak.mlkit_document_scanner

enum class DocumentScannerResultMode {
    JPEG_PAGES,
    PDF_FILE,
    BOTH;

    companion object {
        fun getModeFromValue(value: Int): DocumentScannerResultMode = when (value) {
            0 -> JPEG_PAGES
            1 -> PDF_FILE
            2 -> BOTH
            else -> BOTH
        }
    }
}