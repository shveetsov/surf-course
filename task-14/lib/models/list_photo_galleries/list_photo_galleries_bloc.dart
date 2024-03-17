import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/local_repositories.dart';
import '../photo.dart';

part 'list_photo_galleries_event.dart';
part 'list_photo_galleries_state.dart';

class ListPhotoGalleriesBloc extends Bloc<ListPhotoGalleriesEvent, ListPhotoGalleriesState> {
  ListPhotoGalleriesBloc() : super(ListPhotoGalleriesInitial()) {
    final LocalRepositories localRepositories = LocalRepositories();

    Future<void> handleListPhotoGalleries(event, emit) async {
      final listPhotos = await localRepositories.getPhoto();
      emit(ListPhotoGalleriesLoaded(listPhotos: listPhotos));
    }

    on<LoadListPhotoGalleries>(handleListPhotoGalleries);
  }
}