import '../models/photo.dart';

final List<Photo> _listPhoto = List.generate(
  18,
      (index) => Photo(
    imagePath: 'assets/images/photos/image-$index.jpg',
  ),
);

class LocalRepositories {
  final List<Photo> _photos = [];

  Future<List<Photo>> getPhoto() async {
    for (var photo in _listPhoto) {
      _photos.add(photo);
    }
    await Future.delayed(const Duration(milliseconds: 1000));
    return _photos;
  }
}
