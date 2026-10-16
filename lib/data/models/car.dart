class Car {
  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.plate,
    required this.vin,
    required this.fuel,
    required this.engineVolume,
    required this.mileage,
    this.photoAsset,
  });

  static const List<String> fuelTypes = [
    'Бензин',
    'Дизель',
    'Газ/Бензин',
    'Гібрид',
    'Електро',
  ];

  final String id;
  final String brand;
  final String model;
  final int year;
  final String plate;
  final String vin;
  final String fuel;
  final double engineVolume;
  final String? photoAsset;

  int mileage;

  String get name => '$brand $model';

  String get label => plate.isEmpty ? name : '$name · $plate';

  String get shortSpec {
    final volume =
        engineVolume > 0 ? '${engineVolume.toStringAsFixed(1)} ' : '';
    return '$year · $volume$fuel';
  }

  String get fullSpec {
    final volume =
        engineVolume > 0 ? '${engineVolume.toStringAsFixed(1)}L ' : '';
    return '$year · $volume$fuel';
  }

  String get vinShort {
    if (vin.isEmpty) return '—';
    return vin.length > 10 ? '${vin.substring(0, 10)}…' : vin;
  }
}
