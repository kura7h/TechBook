class MileageEntry {
  const MileageEntry({
    required this.id,
    required this.carId,
    required this.date,
    required this.odometer,
  });

  final String id;
  final String carId;
  final DateTime date;
  final int odometer;
}
