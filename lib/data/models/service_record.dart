import 'part.dart';
import 'record_type.dart';

class ServiceRecord {
  const ServiceRecord({
    required this.id,
    required this.carId,
    required this.type,
    required this.date,
    required this.mileage,
    required this.workCost,
    required this.description,
    this.parts = const [],
  });

  final String id;
  final String carId;
  final RecordType type;
  final DateTime date;
  final int mileage;
  final int workCost;
  final String description;
  final List<Part> parts;

  /// Вартість робіт + вартість усіх замінених деталей.
  int get totalCost =>
      workCost + parts.fold<int>(0, (sum, part) => sum + part.total);
}
