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
        scannerMode: Int
    ): GmsDocumentScanner {
        val options = GmsDocumentScannerOptions.Builder()
            .setGalleryImportAllowed(galleryImportAllowed)
            .setPageLimit(maximumNumberOfPages)
            .setResultFormats(
                GmsDocumentScannerOptions.RESULT_FORMAT_JPEG,
                GmsDocumentScannerOptions.RESULT_FORMAT_PDF
            )
            .setScannerMode(scannerMode)
            .build()

        return GmsDocumentScanning.getClient(options)
    }

    fun handleActivityResult(
        data: Intent?,
        eventSinkJPEG: EventChannel.EventSink?,
        eventSinkPDF: EventChannel.EventSink?
    ) {
        GmsDocumentScanningResult.fromActivityResultIntent(data)?.also { result ->
            result.pages?.let {
                Log.d(LOGGING_TAG, "Received JPEG pages count ${it.size}")
                eventSinkJPEG?.success(it.map { pages -> pages.imageUri.toFile().readBytes() })
            }
            result.pdf?.let {
                Log.d(LOGGING_TAG, "Received PDF file with pages count ${it.pageCount}")
                eventSinkPDF?.success(listOf(it.uri.toFile().readBytes()))
            }
        }
    }
}