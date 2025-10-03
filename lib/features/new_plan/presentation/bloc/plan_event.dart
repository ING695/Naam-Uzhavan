part of 'plan_bloc.dart';

abstract class PlanEvent extends Equatable {
  const PlanEvent();

  @override
  List<Object?> get props => [];
}

class CreatePlanRequested extends PlanEvent {
  final Plan plan;

  const CreatePlanRequested({required this.plan});

  @override
  List<Object?> get props => [plan];
}

class LoadUserPlansRequested extends PlanEvent {
  final String userId;

  const LoadUserPlansRequested({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class DeletePlanRequested extends PlanEvent {
  final String planId;

  const DeletePlanRequested({required this.planId});

  @override
  List<Object?> get props => [planId];
}
