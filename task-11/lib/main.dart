import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:test_11/global_variables.dart';

import 'list_products.dart';
import 'models.dart' as model;

enum SortType {
  none("Без сортировки"),
  nameAsc("По имени от А до Я"),
  nameDesc("По имени от Я до А"),
  priceAsc("По возрастанию"),
  priceDesc("По убыванию"),
  typeAsc("По типу от А до Я"),
  typeDesc("По типу от Я до А");

  const SortType(this.name);
  final String name;

  @override
  String toString() => name;
}

SortType selectedSortType = SortType.none;
bool checkFilter = false;
ValueNotifier update = ValueNotifier(false);

Map<model.Category, List<model.ProductEntity>> listProductsSort = {};

// Метод для сортировки списка продуктов от А до Я по названию
void sortProductsAtoZ(List<model.ProductEntity> products) {
  products.sort((a, b) => a.title.compareTo(b.title));
}

// Метод для сортировки списка продуктов от Я до А по названию
void sortProductsZtoA(List<model.ProductEntity> products) {
  products.sort((a, b) => b.title.compareTo(a.title));
}

// Метод для сортировки списка продуктов от А до Я по названию
void sortProductsPriceAtoZ(List<model.ProductEntity> products) {
  products.sort((a, b) => a.price.compareTo(b.price));
}

// Метод для сортировки списка продуктов от Я до А по названию
void sortProductsPriceZtoA(List<model.ProductEntity> products) {
  products.sort((a, b) => b.price.compareTo(a.price));
}

void sortProductsByCategoryAtoZ(List<model.ProductEntity> products) {
  Map<model.Category, List<model.ProductEntity>> groupedByCategory = {};

  // Группировка продуктов по категориям
  for (var product in products) {
    groupedByCategory.putIfAbsent(product.category, () => []).add(product);
  }

  // Сортировка категорий по алфавиту (от А до Я)
  var sortedKeys = groupedByCategory.keys.toList()
    ..sort((a, b) => a.name.compareTo(b.name));

  Map<model.Category, List<model.ProductEntity>> sortedByCategory = {
    for (var key in sortedKeys) key: groupedByCategory[key]!
  };

  // Обновление глобальной переменной
  listProductsSort = sortedByCategory;
}

void sortProductsByCategoryZtoA(List<model.ProductEntity> products) {
  Map<model.Category, List<model.ProductEntity>> groupedByCategory = {};

  // Группировка продуктов по категориям
  for (var product in products) {
    groupedByCategory.putIfAbsent(product.category, () => []).add(product);
  }

  // Сортировка категорий по алфавиту (от А до Я)
  var sortedKeys = groupedByCategory.keys.toList()
    ..sort((a, b) => b.name.compareTo(a.name));

  Map<model.Category, List<model.ProductEntity>> sortedByCategory = {
    for (var key in sortedKeys) key: groupedByCategory[key]!
  };

  // Обновление глобальной переменной
  listProductsSort = sortedByCategory;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    listProductsSort = {
      model.Category.all: dataForStudents
    };

    // обновление экрана если применен новый фильтр
    update.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Column(
          children: [
            Text(
              'Чек № 56',
              style: GlobalStyleText.title,
            ),
            Text(
              '24.02.23 в 12:23',
              style: GlobalStyleText.appBarDate,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        // Как сделать фон белый, потому что при скроле он меняет цвет...
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: GlobalColors.brightGreen,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleFilter(
                title: 'Список покупок',
                activeFilter: checkFilter,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    barrierColor: const Color(0x66252849),
                    elevation: 0,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    builder: (context) => const SortWindow(),
                  );
                },
              ),
              const SizedBox(height: 16),
              listProductsSort.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listProductsSort.length,
                      itemBuilder: (context, index) {
                        bool check = false;
                        if (listProductsSort.length > 1) {
                          check = true;
                        }
                        return ListProductsCategory(products: listProductsSort.entries.toList()[index].value, checkTitle: check,);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          color: GlobalColors.smokyWhite, // Цвет линии
                          thickness: 1, // Толщина линии
                        );
                      },
                    )
                  : Text('Здесь пока ничего нет',
                      style: GlobalStyleText.textProduct),
              const Divider(
                color: GlobalColors.smokyWhite, // Цвет линии
                thickness: 1, // Толщина линии
              ),
              const SizedBox(height: 24),
              Total(productList: dataForStudents),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}

class ListProductsCategory extends StatefulWidget {
  final List<model.ProductEntity> products;
  final bool checkTitle;

  const ListProductsCategory({super.key, required this.products, required this.checkTitle});

  @override
  State<ListProductsCategory> createState() => _ListProductsCategoryState();
}

class _ListProductsCategoryState extends State<ListProductsCategory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.checkTitle)
          Text(
            widget.products[0].category.name,
            style: GlobalStyleText.total,
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.products.length,
          itemBuilder: (context, index) {
            return ProductCard(product: widget.products[index]);
          },
        ),
      ],
    );
  }
}


// Widget listProductsCategory(
//     List<model.ProductEntity> products, bool checkTitle) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       if (checkTitle)
//         Text(
//           products[0].category.name,
//           style: GlobalStyleText.total,
//         ),
//       ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           return ProductCard(product: products[index]);
//         },
//       ),
//     ],
//   );
// }

class SortWindow extends StatefulWidget {
  const SortWindow({super.key});

  @override
  State<SortWindow> createState() => _SortWindowState();
}

class _SortWindowState extends State<SortWindow> {
  SortType _selectedSortType = SortType.none;

  @override
  void initState() {
    super.initState();
    _selectedSortType = selectedSortType;
  }

  void _updateData(SortType sort) {
    setState(() {
      _selectedSortType = sort;
    });
  }

  void switchSelected (){
    switch (selectedSortType) {
      case SortType.none:
        listProductsSort = {
          model.Category.all: dataForStudents
        };
        checkFilter = false;
      case SortType.nameAsc:
        listProductsSort = {
          model.Category.all: dataForStudents
        };
        sortProductsAtoZ(
            listProductsSort[model.Category.all]!);
        checkFilter = true;
      case SortType.nameDesc:
        listProductsSort = {
          model.Category.all: dataForStudents
        };
        sortProductsZtoA(
            listProductsSort[model.Category.all]!);
        checkFilter = true;
      case SortType.priceAsc:
        listProductsSort = {
          model.Category.all: dataForStudents
        };
        sortProductsPriceAtoZ(
            listProductsSort[model.Category.all]!);
        checkFilter = true;
      case SortType.priceDesc:
        listProductsSort = {
          model.Category.all: dataForStudents
        };
        sortProductsPriceZtoA(
            listProductsSort[model.Category.all]!);
        checkFilter = true;
      case SortType.typeAsc:
        sortProductsByCategoryAtoZ(dataForStudents);
        checkFilter = true;
      case SortType.typeDesc:
        sortProductsByCategoryZtoA(dataForStudents);
        checkFilter = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 4),
                height: 4,
                width: 24,
                decoration: BoxDecoration(
                  color: const Color(0x2EB5B5B5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Сортировка',
                    style: GlobalStyleText.sort,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: GlobalColors.nightBlue,
                      ))
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RadioListTileSort(sortValue: SortType.none, selectedSortType: _selectedSortType, callback: _updateData),
                titleDivider('По имени'),
                RadioListTileSort(sortValue: SortType.nameAsc, selectedSortType: _selectedSortType, callback: _updateData),
                RadioListTileSort(sortValue: SortType.nameDesc, selectedSortType: _selectedSortType, callback: _updateData),
                titleDivider('По цене'),
                RadioListTileSort(sortValue: SortType.priceAsc, selectedSortType: _selectedSortType, callback: _updateData),
                RadioListTileSort(sortValue: SortType.priceDesc, selectedSortType: _selectedSortType, callback: _updateData),
                titleDivider('По типу'),
                RadioListTileSort(sortValue: SortType.typeAsc, selectedSortType: _selectedSortType, callback: _updateData),
                RadioListTileSort(sortValue: SortType.typeDesc, selectedSortType: _selectedSortType, callback: _updateData),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedSortType = _selectedSortType;
                        update.value = !update.value;
                        switchSelected();
                        Navigator.pop(context);
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          GlobalColors.brightGreen), // Цвет фона
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Цвет текста
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Скругление углов
                      )),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14), // Отступы внутри кнопки
                      ),
                    ),
                    child: const Text(
                      'Готово',
                      style: TextStyle(
                        fontSize: 16, // Размер шрифта
                        fontWeight: FontWeight.bold, // Жирность шрифта
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget titleDivider(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            color: GlobalColors.smokyWhite, // Цвет линии
            height: 8,
            thickness: 1, // Толщина линии
          ),
          Text(
            title,
            style: GlobalStyleText.textProduct,
          ),
        ],
      ),
    );
  }
}

class RadioListTileSort extends StatelessWidget {
  final SortType sortValue;
  final SortType selectedSortType;
  final Function(SortType) callback;

  const RadioListTileSort({super.key, required this.sortValue, required this.selectedSortType, required this.callback});

  @override
  Widget build(BuildContext context) {
    return RadioListTile<SortType>(
      title: Text(sortValue.toString()),
      value: sortValue,
      groupValue: selectedSortType,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      activeColor: GlobalColors.brightGreen,
      onChanged: (SortType? value) {
        if (value != null) {
          callback(value);
        }
      },
    );
  }
}



class Total extends StatefulWidget {
  final List<model.ProductEntity> productList;

  const Total({super.key, required this.productList});

  @override
  State<Total> createState() => _TotalState();
}

class _TotalState extends State<Total> {
  double _sum = 0;
  double _sumSale = 0;
  double _sale = 0;
  double _salePercent = 0;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    for (var product in widget.productList) {
      if (product.sale != 0) {
        _sale += product.price * (product.sale / 100);
      }
      _sum += product.price;
    }

    _sumSale = _sum - _sale;
    _salePercent = (_sale / _sum * 100 * 100).round() / 100;

    _sale = _sale / 100;
    _sumSale = _sumSale / 100;
    _sum = _sum / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'В вашей покупке',
          style: GlobalStyleText.total,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${widget.productList.length} товаров',
              style: GlobalStyleText.textProduct,
            ),
            Text(
              '${processNumber(_sum)} руб',
              style: GlobalStyleText.textBoldProduct,
            )
          ],
        ),
        const SizedBox(
          height: 11,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Скидка ${(_salePercent * 100).round() / 100}%',
              style: GlobalStyleText.textProduct,
            ),
            Text(
              '-${processNumber(_sale)} руб',
              style: GlobalStyleText.textBoldProduct,
            )
          ],
        ),
        const SizedBox(
          height: 11,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Итого',
              style: GlobalStyleText.total,
            ),
            Text(
              '${processNumber(_sumSale)} руб',
              style: GlobalStyleText.total,
            )
          ],
        ),
      ],
    );
  }
}

dynamic processNumber(double number) {
  final format = NumberFormat('#,##0.##', 'ru_RU');
  return format.format(number);
}

class ProductCard extends StatelessWidget {
  final model.ProductEntity product;

  const ProductCard({
    super.key,
    required this.product,
  });

  String _amount(model.Amount amount) {
    if (amount.runtimeType == model.Grams) {
      return '${processNumber(amount.value / 1000)} кг.';
    }
    return '${amount.value} шт.';
  }

  Widget _price() {
    if (product.sale == 0) {
      return Text(
        '${(processNumber(product.price / 100))} руб',
        style: GlobalStyleText.textBoldProduct,
      );
    }

    String salePrice = processNumber(product.price * (product.sale / 100) / 100);

    return Row(
      children: [
        Text(
          '${(processNumber(product.price / 100))} руб',
          style: GlobalStyleText.textProduct.copyWith(
              color: GlobalColors.lightGrey,
              decoration: TextDecoration.lineThrough),
        ),
        const SizedBox(width: 16),
        Text(
          '$salePrice руб',
          style:
              GlobalStyleText.textBoldProduct.copyWith(color: GlobalColors.red),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product.imageUrl,
              height: 68,
              width: 68,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox(
                  height: 68,
                  width: 68,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: GlobalColors.brightGreen,
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(minHeight: 68),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.title,
                    style: GlobalStyleText.textProduct,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _amount(product.amount),
                        style: GlobalStyleText.textProduct,
                      ),
                      _price(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleFilter extends StatelessWidget {
  final String title;
  final bool activeFilter;
  final VoidCallback onPressed;

  const TitleFilter(
      {super.key,
      required this.title,
      required this.activeFilter,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GlobalStyleText.title,
        ),
        FilterIconButton(
          onPressed: onPressed,
          iconPath: AppAssets.sort,
          background: GlobalColors.smokyWhite,
          width: 32,
          height: 32,
          activeFilter: activeFilter,
        ),
      ],
    );
  }
}

class FilterIconButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color background;
  final bool activeFilter;

  const FilterIconButton({
    super.key,
    required this.iconPath,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.background,
    required this.activeFilter,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: background,
            ),
            child: Center(
              child: SvgPicture.asset(iconPath,
                  width: 24, height: 24, semanticsLabel: 'Фильтр'),
            ),
          ),
          if (activeFilter)
            Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: GlobalColors.brightGreen,
                ),
              ),
            )
        ],
      ),
    );
  }
}

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            // Цвет бордюра
            color: GlobalColors.smokyWhite, // Цвет линии
            // Толщина бордюра
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            iconTitle(AppAssets.article, 'Каталог',
                GlobalColors.motherOfPearlBlackberry),
            iconTitle(AppAssets.search, 'Поиск',
                GlobalColors.motherOfPearlBlackberry),
            iconTitle(AppAssets.cart, 'Корзина',
                GlobalColors.motherOfPearlBlackberry),
            iconTitle(AppAssets.person, 'Личное',
                GlobalColors.brightGreen),
          ],
        ),
      ),
    );
  }

  Widget iconTitle(String iconPath, String title, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          semanticsLabel: title,
          width: 24,
          height: 24,
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          title,
          style: GlobalStyleText.navBar.copyWith(color: color),
        ),
      ],
    );
  }
}
