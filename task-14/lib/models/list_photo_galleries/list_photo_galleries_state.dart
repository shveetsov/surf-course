part of 'list_photo_galleries_bloc.dart';

class ListPhotoGalleriesState {}

class ListPhotoGalleriesInitial extends ListPhotoGalleriesState {}

class ListPhotoGalleriesLoaded extends ListPhotoGalleriesState {
  final List<Photo> listPhotos;

  ListPhotoGalleriesLoaded({required this.listPhotos});
}