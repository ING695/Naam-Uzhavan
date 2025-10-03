import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../new_plan/presentation/bloc/plan_bloc.dart';
import '../../../new_plan/data/repositories/plan_repository_impl.dart';
import '../../../new_plan/domain/entities/plan.dart';

class MyWorkPage extends StatelessWidget {
  const MyWorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final authState = context.read<AuthBloc>().state;
        final bloc = PlanBloc(planRepository: PlanRepositoryImpl());
        if (authState is AuthAuthenticated) {
          bloc.add(LoadUserPlansRequested(userId: authState.user.uid));
        }
        return bloc;
      },
      child: const _MyWorkView(),
    );
  }
}

class _MyWorkView extends StatelessWidget {
  const _MyWorkView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Work'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              final authState = context.read<AuthBloc>().state;
              if (authState is AuthAuthenticated) {
                context.read<PlanBloc>().add(
                      LoadUserPlansRequested(userId: authState.user.uid),
                    );
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<PlanBloc, PlanState>(
        builder: (context, state) {
          if (state is PlanLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PlansLoaded) {
            if (state.plans.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.work_off,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No plans yet',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text('Create your first plan to get started'),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.plans.length,
              itemBuilder: (context, index) {
                final plan = state.plans[index];
                return _PlanCard(plan: plan);
              },
            );
          } else if (state is PlanError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 80,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading plans',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final authState = context.read<AuthBloc>().state;
                      if (authState is AuthAuthenticated) {
                        context.read<PlanBloc>().add(
                              LoadUserPlansRequested(userId: authState.user.uid),
                            );
                      }
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final Plan plan;

  const _PlanCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    final daysUntilHarvest = plan.expectedHarvestDate != null
        ? plan.expectedHarvestDate!.difference(DateTime.now()).inDays
        : null;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.grass,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    plan.cropName,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                if (daysUntilHarvest != null && daysUntilHarvest > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '$daysUntilHarvest days',
                      style: TextStyle(
                        color: Colors.green[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            _InfoRow(
              icon: Icons.landscape,
              label: 'Land Size',
              value: '${plan.landSize} acres',
            ),
            const SizedBox(height: 8),
            _InfoRow(
              icon: Icons.location_on,
              label: 'Location',
              value: plan.location,
            ),
            const SizedBox(height: 8),
            _InfoRow(
              icon: Icons.calendar_today,
              label: 'Start Date',
              value: DateFormat('dd MMM yyyy').format(plan.startDate),
            ),
            if (plan.expectedHarvestDate != null) ...[
              const SizedBox(height: 8),
              _InfoRow(
                icon: Icons.event,
                label: 'Expected Harvest',
                value: DateFormat('dd MMM yyyy').format(plan.expectedHarvestDate!),
              ),
            ],
            if (plan.notes != null && plan.notes!.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                'Notes:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(plan.notes!),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.delete, size: 18),
                  label: const Text('Delete'),
                  onPressed: () {
                    _showDeleteDialog(context, plan.id!);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String planId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Plan'),
        content: const Text('Are you sure you want to delete this plan?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<PlanBloc>().add(DeletePlanRequested(planId: planId));
              // Reload plans after deletion
              final authState = context.read<AuthBloc>().state;
              if (authState is AuthAuthenticated) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  context.read<PlanBloc>().add(
                        LoadUserPlansRequested(userId: authState.user.uid),
                      );
                });
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
