class Engine {
  final int engineCapacity; // Объем двигателя
  final int power; // Мощность
  final String name; // Имя

  Engine(
      {required this.engineCapacity, required this.power, required this.name});

  @override
  String toString(){
    String adoutMe = 'название: $name, мощность: $power, объем двигателя: $engineCapacity';
    return adoutMe;
  }
}

class Car {
  static const String _brand =
      'Subaru'; // Бренд (один бренд у всех автомобилей)
  final String model; // Модель
  String color; // Цвет (можно перекрасить)
  final DateTime yearOfRelease; // Год выпуска
  Engine engine; // Двигатель
  bool? spareWheel; // Запасное колесо

  // Стандартная комплектация
  Car(
      {required this.model,
        required this.yearOfRelease,
        required this.engine,
        required this.color});

  // Полная комплектация
  Car.fullEquipment(
      {required this.model,
        required this.yearOfRelease,
        required this.engine,
        required this.color}) {
    spareWheel = true;
  }

  String get brand => _brand;

  void drive() {
    print('Машина поехала');
  }

  void stop() {
    print('Машина остановилась');
  }

  @override
  String toString(){
    String adoutMe = '''
    Бренд: $brand
    Модель: $model
    Цвет: $color
    Двигатель: $engine
    Запасное колесо: ${spareWheel == true ? 'Есть' : 'Нет'}
    ''';
    return adoutMe;
  }
}

void main() {
  final engA210 = Engine(engineCapacity: 1000, power: 200, name: 'A210');
  final engA310 = Engine(engineCapacity: 1500, power: 300, name: 'A310');
  final engA410 = Engine(engineCapacity: 2000, power: 400, name: 'A410');

  final car1 = Car(model: 'vm1', yearOfRelease: DateTime.utc(2001,01,1), engine: engA210, color: 'White');
  final car2 = Car(model: 'vm2', yearOfRelease: DateTime.utc(2004,01,1), engine: engA310, color: 'Black');
  final car3 = Car(model: 'vm3', yearOfRelease: DateTime.utc(2007,01,1), engine: engA410, color: 'White');
  final car4 = Car.fullEquipment(model: 'vm3', yearOfRelease: DateTime.utc(20010,01,1), engine: engA410, color: 'White');

  print(car1);
  print(car2);
  print(car3);
  print(car4);
}