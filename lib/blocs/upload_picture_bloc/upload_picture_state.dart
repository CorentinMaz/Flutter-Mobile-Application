part of 'upload_picture_bloc.dart';

/// An sealed class representing a state for uploading a picture.
sealed class UploadPictureState extends Equatable {
  const UploadPictureState();

  @override
  List<Object?> get props => <Object>[];
}

/// A concrete class representing the loading state during picture upload.
final class UploadPictureLoading extends UploadPictureState {}

/// A concrete class representing the failure state during picture upload.
final class UploadPictureFailure extends UploadPictureState {}

/// A concrete class representing the success state after a picture is uploaded.
final class UploadPictureSuccess extends UploadPictureState {

  /// Constructs an [UploadPictureSuccess] state with the provided [url].
  const UploadPictureSuccess(this.url);

  /// The URL of the uploaded picture.
  final String url;

  @override
  List<Object?> get props => <Object?>[];
}
