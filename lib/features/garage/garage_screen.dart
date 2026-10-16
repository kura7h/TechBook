import 'package:flutter/material.dart';

import '../../core/widgets/page_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/mock_data.dart';
import '../../data/models/car.dart';
import 'widgets/add_car_dialog.dart';
import 'widgets/add_car_tile.dart';
import 'widgets/car_card.dart';

class GarageScreen extends StatefulWidget {
  const GarageScreen({super.key});

  @override
  State<GarageScreen> createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen> {
  Future<void> _addCar() async {
    final car = await showDialog<Car>(
      context: context,
      builder: (context) => const AddCarDialog(),
    );
    if (car != null && mounted) {
      setState(() => MockData.addCar(car));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Гараж',
      actions: [
        PrimaryButton(
          label: 'Додати авто',
          icon: Icons.add,
          expand: false,
          dense: true,
          onPressed: _addCar,
        ),
      ],
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            const gap = 20.0;
            final columns = constraints.maxWidth >= 760 ? 2 : 1;
            final itemWidth =
                ((constraints.maxWidth - gap * (columns - 1)) / columns)
                    .floorToDouble();

            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final car in MockData.cars)
                  SizedBox(width: itemWidth, child: CarCard(car: car)),
                SizedBox(
                  width: itemWidth,
                  child: AddCarTile(onTap: _addCar),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
