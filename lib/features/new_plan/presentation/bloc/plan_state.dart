part of 'plan_bloc.dart';

abstract class PlanState extends Equatable {
  const PlanState();

  @override
  List<Object?> get props => [];
}

class PlanInitial extends PlanState {}

class PlanLoading extends PlanState {}

class PlanCreated extends PlanState {}

class PlanDeleted extends PlanState {}

class PlansLoaded extends PlanState {
  final List<Plan> plans;

  const PlansLoaded({required this.plans});

  @override
  List<Object?> get props => [plans];
}

class PlanError extends PlanState {
  final String message;

  const PlanError({required this.message});

  @override
  List<Object?> get props => [message];
}
