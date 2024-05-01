import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoes_repository/shoes_repository.dart';

part 'upload_picture_event.dart';
part 'upload_picture_state.dart';

class UploadPictureBloc extends Bloc<UploadPictureEvent, UploadPictureState> {
  ShoesRepo shoesRepo;

  UploadPictureBloc(this.shoesRepo) : super(UploadPictureLoading()) {
    on<UploadPicture>(( UploadPicture event, Emitter<UploadPictureState> emit) async {
      try {
        final String url = await shoesRepo.sendImage(event.file, event.name);
        emit(UploadPictureSuccess(url));
      } catch (e) {
        print(e);
        emit(UploadPictureFailure());
      }
    });
  }
}
