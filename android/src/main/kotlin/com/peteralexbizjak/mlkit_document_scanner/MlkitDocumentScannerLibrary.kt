package com.peteralexbizjak.mlkit_document_scanner

import android.content.Intent
import android.util.Log
import androidx.core.net.toFile
import com.google.mlkit.vision.documentscanner.GmsDocumentScanner
import com.google.mlkit.vision.documentscanner.GmsDocumentScannerOptions
import com.google.mlkit.vision.documentscanner.GmsDocumentScanning
import com.google.mlkit.vision.documentscanner.GmsDocumentScanningResult
import io.flutter.plugin.common.EventChannel

internal class MlkitDocumentScannerLibrary {
    fun buildGmsDocumentScanner(
        maximumNumberOfPages: Int,
        galleryImportAllowed: Boolean,
        scannerMode: Int,
    ): GmsDocumentScanner {
        val options = GmsDocumentScannerOptions.Builder()
            .setGalleryImportAllowed(galleryImportAllowed)
            .setPageLimit(maximumNumberOfPages)
            .setResultFormats(GmsDocumentScannerOptions.RESULT_FORMAT_PDF)
            .setScannerMode(scannerMode)
            .build()

        return GmsDocumentScanning.getClient(options)
    }

    fun handleActivityResult(data: Intent?, eventSink: EventChannel.EventSink?) {
        GmsDocumentScanningResult.fromActivityResultIntent(data)?.pdf?.let {
            Log.d(LOGGING_TAG, "Received PDF ${it.uri}")
            eventSink?.success(it.uri.toFile().readBytes())
        }
    }

    companion object {
        private const val LOGGING_TAG = "MLKit Library"
    }
}