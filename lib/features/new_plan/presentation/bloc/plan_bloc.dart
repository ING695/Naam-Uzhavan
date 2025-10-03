import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/plan.dart';
import '../../domain/repositories/plan_repository.dart';

part 'plan_event.dart';
part 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  final PlanRepository planRepository;

  PlanBloc({required this.planRepository}) : super(PlanInitial()) {
    on<CreatePlanRequested>(_onCreatePlanRequested);
    on<LoadUserPlansRequested>(_onLoadUserPlansRequested);
    on<DeletePlanRequested>(_onDeletePlanRequested);
  }

  Future<void> _onCreatePlanRequested(
    CreatePlanRequested event,
    Emitter<PlanState> emit,
  ) async {
    emit(PlanLoading());
    try {
      await planRepository.createPlan(event.plan);
      emit(PlanCreated());
    } catch (e) {
      emit(PlanError(message: e.toString()));
    }
  }

  Future<void> _onLoadUserPlansRequested(
    LoadUserPlansRequested event,
    Emitter<PlanState> emit,
  ) async {
    emit(PlanLoading());
    try {
      final plans = await planRepository.getUserPlans(event.userId);
      emit(PlansLoaded(plans: plans));
    } catch (e) {
      emit(PlanError(message: e.toString()));
    }
  }

  Future<void> _onDeletePlanRequested(
    DeletePlanRequested event,
    Emitter<PlanState> emit,
  ) async {
    emit(PlanLoading());
    try {
      await planRepository.deletePlan(event.planId);
      emit(PlanDeleted());
    } catch (e) {
      emit(PlanError(message: e.toString()));
    }
  }
}
