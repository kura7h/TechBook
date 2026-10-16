import 'package:flutter/material.dart';

class CarPhoto extends StatelessWidget {
  const CarPhoto({super.key, this.asset, this.fit = BoxFit.cover});

  final String? asset;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (asset == null) return const _CarPhotoPlaceholder();
    return Image.asset(
      asset!,
      fit: fit,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) =>
          const _CarPhotoPlaceholder(),
    );
  }
}

class _CarPhotoPlaceholder extends StatelessWidget {
  const _CarPhotoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4B5563), Color(0xFF1F2937)],
        ),
      ),
      child: const Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.directions_car_filled_outlined,
              size: 40,
              color: Color(0x99FFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}
