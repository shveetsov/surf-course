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

  // текущая картинка
  late var currentPage = widget.index;

  late final _pageController = PageController(
    /// Начальным элементом будет нажатая картинка
    initialPage: currentPage,

    /// Отвечает за то, сколько пространства PageView занимает активный элемент.
    /// По умолчанию равно 1, что означает, что элемент занимает все пространство.
    ///
    /// Выставив такое значение, мы сможем увидеть соседние элементы.
    viewportFraction: 0.8,
  );

  @override
  void initState() {
    /// С этого момента при любом изменении, произошедшем в PageController,
    /// будет вызвать метод _onPageChanged
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

  /// Здесь мы будем реагировать на изменение текущего положения в рамках PageView
  void _onPageChanged() {
    /// Запоминаем последнюю активную страницу
    final prevPage = currentPage;

    /// Вычисляем текущую (или, вернее, вычисляем страницу, к которой мы ближе всего)
    currentPage = _pageController.page?.round() ?? currentPage;

    /// Если наша страница изменилась, делаем setState, чтобы вызвать перестройку виджета
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
            /// Используем виджет неявной анимации, чтобы достичь
            /// красивого эффекта плавного масштабирования
            child: AnimatedScale(
              duration: const Duration(milliseconds: 300),

              /// Если страница является текущей, её масштаб будет оригинальным (1),
              /// иначе - чуть меньше
              scale: currentPage == i ? 1 : 0.85,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: GestureDetector(
                  /// Теперь при нажатии на определенный элемент мы с помощью
                  /// PageController перемещаться к нему
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
      // Соотношение сторон 1:2
      aspectRatio: 1 / 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0), // Радиус закругления
        child: Image.asset(
          photo.imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
