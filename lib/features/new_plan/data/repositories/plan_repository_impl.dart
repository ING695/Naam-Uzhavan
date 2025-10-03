import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/plan.dart';
import '../../domain/repositories/plan_repository.dart';
import '../models/plan_model.dart';

class PlanRepositoryImpl implements PlanRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'plans';

  @override
  Future<void> createPlan(Plan plan) async {
    try {
      final planModel = PlanModel(
        userId: plan.userId,
        cropName: plan.cropName,
        landSize: plan.landSize,
        location: plan.location,
        startDate: plan.startDate,
        expectedHarvestDate: plan.expectedHarvestDate,
        notes: plan.notes,
        createdAt: plan.createdAt,
      );
      
      await _firestore.collection(_collection).add(planModel.toFirestore());
    } catch (e) {
      throw Exception('Failed to create plan: ${e.toString()}');
    }
  }

  @override
  Future<List<Plan>> getUserPlans(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => PlanModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get plans: ${e.toString()}');
    }
  }

  @override
  Future<void> updatePlan(Plan plan) async {
    try {
      if (plan.id == null) {
        throw Exception('Plan ID is required for update');
      }

      final planModel = PlanModel(
        id: plan.id,
        userId: plan.userId,
        cropName: plan.cropName,
        landSize: plan.landSize,
        location: plan.location,
        startDate: plan.startDate,
        expectedHarvestDate: plan.expectedHarvestDate,
        notes: plan.notes,
        createdAt: plan.createdAt,
      );

      await _firestore
          .collection(_collection)
          .doc(plan.id)
          .update(planModel.toFirestore());
    } catch (e) {
      throw Exception('Failed to update plan: ${e.toString()}');
    }
  }

  @override
  Future<void> deletePlan(String planId) async {
    try {
      await _firestore.collection(_collection).doc(planId).delete();
    } catch (e) {
      throw Exception('Failed to delete plan: ${e.toString()}');
    }
  }
}
