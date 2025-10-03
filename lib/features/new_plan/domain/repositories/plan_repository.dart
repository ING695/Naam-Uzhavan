import '../entities/plan.dart';

abstract class PlanRepository {
  Future<void> createPlan(Plan plan);
  Future<List<Plan>> getUserPlans(String userId);
  Future<void> updatePlan(Plan plan);
  Future<void> deletePlan(String planId);
}
