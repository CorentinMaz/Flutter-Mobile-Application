part of 'upload_picture_bloc.dart';

/// An sealed class representing an event for uploading a picture.
sealed class UploadPictureEvent extends Equatable {
  const UploadPictureEvent();

  @override
  List<Object?> get props => <Object>[];
}

/// A concrete class representing the event of uploading a picture.
class UploadPicture extends UploadPictureEvent {
  /// Constructs an [UploadPicture] event with the provided [file] and [name].
  const UploadPicture(this.file, this.name);

  /// The file to be uploaded.
  final Uint8List file;

  /// The name of the file.
  final String name;

  @override
  List<Object?> get props => <Object?>[file, name];
}
