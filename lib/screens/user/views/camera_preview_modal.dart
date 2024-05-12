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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close), // Utilisation de l'icône de close
          onPressed: () {
            completer.complete(null);
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Camera Preview'),
      ),
      body: AlertDialog(
        backgroundColor: Colors.white, // Background transparent
        content: Center(
          child: Column(
            children: <Widget>[
              ClipRRect(
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9, // Taille adaptative
                    height: 300,
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: AspectRatio(
                              aspectRatio: cameraController.value.aspectRatio,
                              child: CameraPreview(cameraController),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (cameraController.value.isInitialized) {
                    final XFile photo = await cameraController.takePicture();
                    completer.complete(photo);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Couleur du bouton noir
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Border radius
                  ),
                ),
                child: const Text(
                  'Take Picture',
                  style: TextStyle(color: Colors.white), // Texte blanc
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
