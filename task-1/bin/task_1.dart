enum Countries { brazil, russia, turkish, spain, japan }

class Territory {
  final int areaInHectare;
  final List<String> crops;
  final List<AgriculturalMachinery> machineries;

  Territory(
      this.areaInHectare,
      this.crops,
      this.machineries,
      );
}

class AgriculturalMachinery {
  final String id;
  final DateTime releaseDate;

  AgriculturalMachinery(
      this.id,
      this.releaseDate,
      );

  /// Переопределяем оператор "==", чтобы сравнивать объекты по значению.
  @override
  bool operator ==(Object? other) {
    if (other is! AgriculturalMachinery) return false;
    if (other.id == id && other.releaseDate == releaseDate) return true;

    return false;
  }

  @override
  int get hashCode => id.hashCode ^ releaseDate.hashCode;
}

final mapBefore2010 = <Countries, List<Territory>>{
  Countries.brazil: [
    Territory(
      34,
      ['Кукуруза'],
      [
        AgriculturalMachinery(
          'Трактор Степан',
          DateTime(2001),
        ),
        AgriculturalMachinery(
          'Культиватор Сережа',
          DateTime(2007),
        ),
      ],
    ),
  ],
  Countries.russia: [
    Territory(
      14,
      ['Картофель'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Гранулятор Антон',
          DateTime(2009),
        ),
      ],
    ),
    Territory(
      19,
      ['Лук'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Дробилка Маша',
          DateTime(1990),
        ),
      ],
    ),
  ],
  Countries.turkish: [
    Territory(
      43,
      ['Хмель'],
      [
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
        AgriculturalMachinery(
          'Сепаратор Марк',
          DateTime(2005),
        ),
      ],
    ),
  ],
};

final mapAfter2010 = {
  Countries.turkish: [
    Territory(
      22,
      ['Чай'],
      [
        AgriculturalMachinery(
          'Каток Кирилл',
          DateTime(2018),
        ),
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
      ],
    ),
  ],
  Countries.japan: [
    Territory(
      3,
      ['Рис'],
      [
        AgriculturalMachinery(
          'Гидравлический молот Лена',
          DateTime(2014),
        ),
      ],
    ),
  ],
  Countries.spain: [
    Territory(
      29,
      ['Арбузы'],
      [
        AgriculturalMachinery(
          'Мини-погрузчик Максим',
          DateTime(2011),
        ),
      ],
    ),
    Territory(
      11,
      ['Табак'],
      [
        AgriculturalMachinery(
          'Окучник Саша',
          DateTime(2010),
        ),
      ],
    ),
  ],
};

void main() {
  // Создаю список всех территорий
  List<Territory> listAllTerritory = [];

  // Наполняю список из старой БД
  for (var territory in mapBefore2010.values) {
    listAllTerritory.addAll(territory);
  }

  // Наполняю список из новой БД
  for (var territory in mapAfter2010.values) {
    listAllTerritory.addAll(territory);
  }

  // Создаю список всей техники
  Set<AgriculturalMachinery> listAllAgriculturalMachinery = {};

  // Добавляю уникальную технику в список
  for (var value in listAllTerritory) {listAllAgriculturalMachinery.addAll(value.machineries);}

  // Создаю переменную для вычисления суммарного возраста
  int sumAgesAllAgriculturalMachinery = 0;

  // Суммирую возраст
  for (var value in listAllAgriculturalMachinery) {
    sumAgesAllAgriculturalMachinery += value.releaseDate.year;
  }

  // Вывожу средний возраст всей техники
  print('Средний возраст техники: ${DateTime.now().year-(sumAgesAllAgriculturalMachinery/listAllAgriculturalMachinery.length).round()}');

  // Создаю отсортированный список
  List<AgriculturalMachinery> listSortAgriculturalMachinery = listAllAgriculturalMachinery.toList();

  // Сортирую его
  listSortAgriculturalMachinery.sort((a, b) => a.releaseDate.year.compareTo(b.releaseDate.year));

  // Создаю список половины орг техники
  List<AgriculturalMachinery> listHalfAgriculturalMachinery = [];

  // Заполняю его
  for (int i = 0; i < (listSortAgriculturalMachinery.length/2).ceil(); i++) {
    listHalfAgriculturalMachinery.add(listSortAgriculturalMachinery[i]);
  }

  // Обнуляю переменную для нового расчета
  sumAgesAllAgriculturalMachinery = 0;

  // Суммирую возраст
  for (var element in listHalfAgriculturalMachinery) {sumAgesAllAgriculturalMachinery += element.releaseDate.year;}

  // ср возраст в переменную
  int averageAge = DateTime.now().year-(sumAgesAllAgriculturalMachinery/(listSortAgriculturalMachinery.length/2).ceil()).round();

  // Вывожу итог
  print('Средний возраст 50% техники: $averageAge');

}