import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/plan.dart';

class PlanModel extends Plan {
  const PlanModel({
    super.id,
    required super.userId,
    required super.cropName,
    required super.landSize,
    required super.location,
    required super.startDate,
    super.expectedHarvestDate,
    super.notes,
    required super.createdAt,
  });

  factory PlanModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PlanModel(
      id: doc.id,
      userId: data['userId'],
      cropName: data['cropName'],
      landSize: data['landSize'],
      location: data['location'],
      startDate: (data['startDate'] as Timestamp).toDate(),
      expectedHarvestDate: data['expectedHarvestDate'] != null
          ? (data['expectedHarvestDate'] as Timestamp).toDate()
          : null,
      notes: data['notes'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'cropName': cropName,
      'landSize': landSize,
      'location': location,
      'startDate': Timestamp.fromDate(startDate),
      'expectedHarvestDate': expectedHarvestDate != null
          ? Timestamp.fromDate(expectedHarvestDate!)
          : null,
      'notes': notes,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
