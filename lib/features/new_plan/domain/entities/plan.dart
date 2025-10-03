import 'package:equatable/equatable.dart';

class Plan extends Equatable {
  final String? id;
  final String userId;
  final String cropName;
  final String landSize;
  final String location;
  final DateTime startDate;
  final DateTime? expectedHarvestDate;
  final String? notes;
  final DateTime createdAt;

  const Plan({
    this.id,
    required this.userId,
    required this.cropName,
    required this.landSize,
    required this.location,
    required this.startDate,
    this.expectedHarvestDate,
    this.notes,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        cropName,
        landSize,
        location,
        startDate,
        expectedHarvestDate,
        notes,
        createdAt,
      ];
}
