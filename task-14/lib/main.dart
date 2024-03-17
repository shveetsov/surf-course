import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_14/app_constants.dart';
import 'package:task_14/models/list_photo_galleries/list_photo_galleries_bloc.dart';
import 'package:task_14/models/scale_route.dart';
import 'package:task_14/view/photo_screen.dart';

import 'models/photo.dart';

void main() {
  runApp(const PostogramApp());
}

class PostogramApp extends StatelessWidget {
  const PostogramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        primaryColor: AppColors.black,
        scaffoldBackgroundColor: AppColors.white,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _listPhotoGalleriesBloc = ListPhotoGalleriesBloc();

  @override
  void initState() {
    _listPhotoGalleriesBloc.add(LoadListPhotoGalleries());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AppAssets.logo,
          height: 34,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: BlocBuilder<ListPhotoGalleriesBloc, ListPhotoGalleriesState>(
              bloc: _listPhotoGalleriesBloc,
              builder: (context, state) {
                if (state is ListPhotoGalleriesLoaded) {
                  return GridViewPhotos(
                    listPhotos: state.listPhotos,
                  );
                }

                return SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: theme.primaryColor,
                      strokeWidth: 2,
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class GridViewPhotos extends StatelessWidget {
  final List<Photo> listPhotos;

  const GridViewPhotos({super.key, required this.listPhotos});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 5,
      crossAxisSpacing: 3,
      children: List.generate(
          listPhotos.length,
          (index) => GestureDetector(
            onTap: (){
              Navigator.push(context, ScaleRoute(page: PhotoScreen(listPhotos: listPhotos, index: index,)));
            },
            child: Image.asset(
                  listPhotos[index].imagePath,
              fit: BoxFit.cover,
                ),
          )),
    );
  }
}
