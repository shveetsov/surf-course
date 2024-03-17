import 'package:flutter/material.dart';
import 'package:task_14/app_constants.dart';

import '../models/photo.dart';

class PhotoScreen extends StatefulWidget {
  final List<Photo> listPhotos;
  final int index;

  const PhotoScreen({super.key, required this.listPhotos, required this.index});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  static const _defaultAnimDuration = Duration(milliseconds: 300);

  late var currentPage = widget.index;

  late final _pageController = PageController(
    initialPage: currentPage,
    viewportFraction: 0.8,
  );

  @override
  void initState() {
    _pageController.addListener(_onPageChanged);
    super.initState();
  }

  @override
  void dispose() {
    _pageController
      ..removeListener(_onPageChanged)
      ..dispose();
    super.dispose();
  }

  void _onPageChanged() {
    final prevPage = currentPage;

    currentPage = _pageController.page?.round() ?? currentPage;

    if (prevPage != currentPage) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text(
            '$currentPage',
            style:
                AppTextStyles.counterPhoto.copyWith(color: theme.primaryColor),
          ),
          Text('/${widget.listPhotos.length}',
              style:
                  AppTextStyles.counterPhoto.copyWith(color: AppColors.gray)),
          const SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 72),
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.listPhotos.length,
          itemBuilder: (_, i) => Center(
            child: AnimatedScale(
              duration: const Duration(milliseconds: 300),
              scale: currentPage == i ? 1 : 0.85,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: GestureDetector(
                  onTap: () => _pageController.animateToPage(
                    i,
                    duration: _defaultAnimDuration,
                    curve: Curves.easeIn,
                  ),
                  child: _PageViewItem(photo: widget.listPhotos[i]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PageViewItem extends StatelessWidget {
  final Photo photo;

  const _PageViewItem({
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: Image.asset(
          photo.imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
