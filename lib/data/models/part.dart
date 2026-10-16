class Part {
  const Part({
    required this.name,
    this.manufacturer = '',
    this.quantity = 1,
    this.price = 0,
  });

  final String name;
  final String manufacturer;
  final int quantity;
  final int price;

  int get total => quantity * price;
}
