import 'models/car.dart';
import 'models/mileage_entry.dart';
import 'models/record_type.dart';
import 'models/service_record.dart';
import 'models/user_profile.dart';

/// Hardcoded-дані для демонстрації інтерфейсу (без бекенду).
/// Списки змінювані, тому нові записи з діалогів відображаються на всіх екранах
/// до перезапуску застосунку.
class MockData {
  MockData._();

  static int _sequence = 100;
  static String nextId(String prefix) => '$prefix-${_sequence++}';

  static const UserProfile user = UserProfile(
    firstName: 'Ростислав',
    lastName: 'Барановський',
    email: 'rostyslav@example.com',
    phone: '+380 00 000 0000',
  );

  static const String camryPhoto = 'assets/images/toyota_camry.png';
  static const String bmwPhoto = 'assets/images/bmw_x5.png';
  static const String civicPhoto = 'assets/images/honda_civic.png';

  static final List<Car> cars = [
    Car(
      id: 'car-1',
      brand: 'Toyota',
      model: 'Camry',
      year: 2020,
      plate: 'AA 1234 BC',
      vin: '1HGCM82633A004352',
      fuel: 'Бензин',
      engineVolume: 2.5,
      mileage: 87430,
      photoAsset: camryPhoto,
    ),
    Car(
      id: 'car-2',
      brand: 'BMW',
      model: 'X5',
      year: 2022,
      plate: 'KA 5678 HM',
      vin: '5UXCR6C54KLL12345',
      fuel: 'Дизель',
      engineVolume: 3.0,
      mileage: 34210,
      photoAsset: bmwPhoto,
    ),
    Car(
      id: 'car-3',
      brand: 'Honda',
      model: 'Civic',
      year: 2019,
      plate: 'OA 9012 PT',
      vin: '2HGFC2F59KH512345',
      fuel: 'Бензин',
      engineVolume: 1.5,
      mileage: 112800,
      photoAsset: civicPhoto,
    ),
  ];

  static final List<ServiceRecord> serviceRecords = [
    ServiceRecord(
      id: 'rec-1',
      carId: 'car-1',
      type: RecordType.maintenance,
      date: DateTime(2026, 9, 15),
      mileage: 87000,
      workCost: 3200,
      description: 'Планове технічне обслуговування',
    ),
    ServiceRecord(
      id: 'rec-2',
      carId: 'car-3',
      type: RecordType.repair,
      date: DateTime(2026, 9, 10),
      mileage: 112500,
      workCost: 3800,
      description: 'Заміна амортизаторів',
    ),
    ServiceRecord(
      id: 'rec-3',
      carId: 'car-2',
      type: RecordType.maintenance,
      date: DateTime(2026, 9, 1),
      mileage: 33000,
      workCost: 5400,
      description: 'Технічне обслуговування 30 000 км',
    ),
    ServiceRecord(
      id: 'rec-4',
      carId: 'car-1',
      type: RecordType.repair,
      date: DateTime(2026, 8, 3),
      mileage: 85200,
      workCost: 1850,
      description: 'Заміна гальмівних колодок на передній осі',
    ),
    ServiceRecord(
      id: 'rec-5',
      carId: 'car-2',
      type: RecordType.diagnostics,
      date: DateTime(2026, 7, 14),
      mileage: 31500,
      workCost: 800,
      description: "Комп'ютерна діагностика",
    ),
    ServiceRecord(
      id: 'rec-6',
      carId: 'car-1',
      type: RecordType.repair,
      date: DateTime(2026, 5, 14),
      mileage: 82400,
      workCost: 4700,
      description: 'Заміна ременя ГРМ та ролика натягувача',
    ),
  ];

  static final List<MileageEntry> mileageEntries = [
    // Toyota Camry
    MileageEntry(
        id: 'm-1',
        carId: 'car-1',
        date: DateTime(2026, 9, 29),
        odometer: 87430),
    MileageEntry(
        id: 'm-2',
        carId: 'car-1',
        date: DateTime(2026, 8, 18),
        odometer: 86700),
    MileageEntry(
        id: 'm-3',
        carId: 'car-1',
        date: DateTime(2026, 7, 30),
        odometer: 85900),
    MileageEntry(
        id: 'm-4',
        carId: 'car-1',
        date: DateTime(2026, 6, 22),
        odometer: 84300),
    MileageEntry(
        id: 'm-5',
        carId: 'car-1',
        date: DateTime(2026, 5, 14),
        odometer: 82400),
    MileageEntry(
        id: 'm-6', carId: 'car-1', date: DateTime(2026, 4, 8), odometer: 80100),
    MileageEntry(
        id: 'm-7',
        carId: 'car-1',
        date: DateTime(2026, 3, 12),
        odometer: 77800),
    MileageEntry(
        id: 'm-8',
        carId: 'car-1',
        date: DateTime(2026, 1, 15),
        odometer: 75200),
    // BMW X5
    MileageEntry(
        id: 'm-9',
        carId: 'car-2',
        date: DateTime(2026, 9, 28),
        odometer: 34210),
    MileageEntry(
        id: 'm-10',
        carId: 'car-2',
        date: DateTime(2026, 9, 1),
        odometer: 33000),
    MileageEntry(
        id: 'm-11',
        carId: 'car-2',
        date: DateTime(2026, 7, 14),
        odometer: 31500),
    MileageEntry(
        id: 'm-12',
        carId: 'car-2',
        date: DateTime(2026, 5, 10),
        odometer: 29800),
    MileageEntry(
        id: 'm-13',
        carId: 'car-2',
        date: DateTime(2026, 3, 2),
        odometer: 27000),
    // Honda Civic
    MileageEntry(
        id: 'm-14',
        carId: 'car-3',
        date: DateTime(2026, 9, 30),
        odometer: 112800),
    MileageEntry(
        id: 'm-15',
        carId: 'car-3',
        date: DateTime(2026, 9, 10),
        odometer: 112500),
    MileageEntry(
        id: 'm-16',
        carId: 'car-3',
        date: DateTime(2026, 7, 21),
        odometer: 110200),
    MileageEntry(
        id: 'm-17',
        carId: 'car-3',
        date: DateTime(2026, 5, 5),
        odometer: 107900),
  ];

  // ---------------------------------------------------------------- Queries

  static Car? carById(String id) {
    for (final car in cars) {
      if (car.id == id) return car;
    }
    return null;
  }

  /// Записи ТО (нові зверху). Якщо [carId] == null – по всіх автомобілях.
  static List<ServiceRecord> recordsFor({String? carId}) {
    final list = serviceRecords
        .where((r) => carId == null || r.carId == carId)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  /// Записи пробігу автомобіля (нові зверху).
  static List<MileageEntry> mileageFor(String carId) {
    final list = mileageEntries.where((e) => e.carId == carId).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  // -------------------------------------------------------------- Mutations

  static void addCar(Car car) {
    cars.add(car);
    if (car.mileage > 0) {
      mileageEntries.add(
        MileageEntry(
          id: nextId('m'),
          carId: car.id,
          date: DateTime.now(),
          odometer: car.mileage,
        ),
      );
    }
  }

  static void addServiceRecord(ServiceRecord record) {
    serviceRecords.add(record);
    _bumpMileage(record.carId, record.mileage);
  }

  static void removeServiceRecord(String id) {
    serviceRecords.removeWhere((r) => r.id == id);
  }

  static void addMileageEntry(MileageEntry entry) {
    mileageEntries.add(entry);
    _bumpMileage(entry.carId, entry.odometer);
  }

  static void removeMileageEntry(String id) {
    mileageEntries.removeWhere((e) => e.id == id);
  }

  static void _bumpMileage(String carId, int value) {
    final car = carById(carId);
    if (car != null && value > car.mileage) {
      car.mileage = value;
    }
  }
}
