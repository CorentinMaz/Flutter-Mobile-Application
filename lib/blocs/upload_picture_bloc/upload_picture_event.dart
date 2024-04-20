part of 'upload_picture_bloc.dart';

sealed class UploadPictureEvent extends Equatable {
  const UploadPictureEvent();

  @override
  List<Object?> get props => <Object>[];
}

class UploadPicture extends UploadPictureEvent {
  const UploadPicture(this.file, this.name);

  final Uint8List file;
  final String name;

  @override
  List<Object?> get props => <Object?>[file, name];
}
