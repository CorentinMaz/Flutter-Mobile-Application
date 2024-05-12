import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

/// A modal widget for displaying a camera preview.
class CameraPreviewModal extends StatelessWidget {

  /// Constructs a [CameraPreviewModal] with the provided [completer] and [cameraController].
  const CameraPreviewModal({
    required this.completer,
    required this.cameraController,
    super.key,
  });

  /// Completer for handling the result of capturing an image.
  final Completer<XFile?> completer;

  /// Controller for managing the camera.
  final CameraController cameraController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Camera Preview'),
      content: SizedBox(
        width: double.maxFinite,
        height: 400, // Ajustez la hauteur en fonction de vos besoins
        child: Stack(
          children: <Widget>[
            AspectRatio(
              aspectRatio: cameraController.value.aspectRatio,
              child: CameraPreview(cameraController),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    if (cameraController.value.isInitialized) {
                      final XFile photo = await cameraController.takePicture();
                      completer.complete(photo);
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: const Text('Take Picture'),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            completer.complete(null);
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
