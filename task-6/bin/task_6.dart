class Product {
  final int id;
  String category;
  String name;
  int price;
  int quantity;

  Product(
      this.id,
      this.category,
      this.name,
      this.price,
      this.quantity,
      );

  @override
  String toString() {
    return "$id\t$category\t$name\t$priceруб.\t$quantityшт.";
  }

  // Фабричный конструктор для создания экземпляра Item из строки
  factory Product.fromString(String itemString) {
    var parts = itemString.split(',');
    return Product(
      int.parse(parts[0].trim()),
      parts[1].trim(),
      parts[2].trim(),
      int.parse(parts[3].trim()),
      int.parse(parts[4].trim()),
    );
  }
}

abstract class Filter {
  bool apply(Product product);
}

class FilterCategory extends Filter {
  final String category;

  FilterCategory(this.category);

  @override
  bool apply(Product product) {
    return product.category == category;
  }
}

class FilterPrice extends Filter {
  final double maxPrice;

  FilterPrice(this.maxPrice);

  @override
  bool apply(Product product) {
    return product.price <= maxPrice;
  }
}

class FilterQuantity extends Filter {
  final int maxQuantity;

  FilterQuantity(this.maxQuantity);

  @override
  bool apply(Product product) {
    return product.quantity <= maxQuantity;
  }
}

void applyFilter(String itemsList, Filter filter) {

  var products = itemsList.trim().split('\n').map((productString) => Product.fromString(productString));

  var filteredProducts = products.where((product) => filter.apply(product));

  print("Id\tКатегория\tНаименование\tЦена\tКоличество");
  for (var product in filteredProducts) {
    print(product.toString());
  }
}

void main() {
  final articles = '''
  1,хлеб,Бородинский,500,5
  2,хлеб,Белый,200,15
  3,молоко,Полосатый кот,50,53
   4,молоко,Коровка,50,53
  5,вода,Апельсин,25,100
  6,вода,Бородинский,500,5
  ''';

  print("Фильтр по категории 'хлеб':");
  applyFilter(articles, FilterCategory("хлеб"));

  print("\nФильтр по максимальной цене 200 руб.:");
  applyFilter(articles, FilterPrice(200));

  print("\nФильтр по максимальному количеству на складе 15 шт.:");
  applyFilter(articles, FilterQuantity(15));
}

