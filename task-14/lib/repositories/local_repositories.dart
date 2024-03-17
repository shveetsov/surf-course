import '../models/photo.dart';

List<String> _listPhoto = [
  'assets/images/photos/image-0.jpg',
  'assets/images/photos/image-1.jpg',
  'assets/images/photos/image-2.jpg',
  'assets/images/photos/image-3.jpg',
  'assets/images/photos/image-4.jpg',
  'assets/images/photos/image-5.jpg',
  'assets/images/photos/image-6.jpg',
  'assets/images/photos/image-7.jpg',
  'assets/images/photos/image-8.jpg',
  'assets/images/photos/image-9.jpg',
  'assets/images/photos/image-10.jpg',
  'assets/images/photos/image-11.jpg',
  'assets/images/photos/image-12.jpg',
  'assets/images/photos/image-13.jpg',
  'assets/images/photos/image-14.jpg',
  'assets/images/photos/image-15.jpg',
  'assets/images/photos/image-16.jpg',
  'assets/images/photos/image-17.jpg',
];

class LocalRepositories {
  final List<Photo> _photos = [];

  Future<List<Photo>> getPhoto() async {
    for (var photo in _listPhoto) {
      _photos.add(Photo(imagePath: photo));
    }
    await Future.delayed(const Duration(milliseconds: 1000));
    return _photos;
  }
}
