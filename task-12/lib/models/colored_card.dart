enum TypeColor {
  hex,
  r,
  g,
  b,
}

class ColoredCard {
  final String name;
  final String value;

  int get colorHex => int.parse('FF${value.substring(1)}', radix: 16);

  String copyColor(TypeColor typeColor){
    int red = (colorHex >> 16) & 0xFF;
    int green = (colorHex >> 8) & 0xFF;
    int blue = colorHex & 0xFF;

    switch (typeColor) {
      case TypeColor.hex: return value;
      case TypeColor.r: return red.toString();
      case TypeColor.g: return green.toString();
      case TypeColor.b: return blue.toString();
    }
  }

  const ColoredCard({required this.name, required this.value});

  static ColoredCard? fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final value = json['value'];

    if (value == null || name == null) {
      // Если value равно null, не создаем объект
      return null;
    } else {
      // Если value не равно null, создаем и возвращаем объект
      return ColoredCard(name: name, value: value);
    }
  }
}