import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../domain/entities/plan.dart';
import '../../data/repositories/plan_repository_impl.dart';
import '../bloc/plan_bloc.dart';

class NewPlanPage extends StatelessWidget {
  const NewPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlanBloc(
        planRepository: PlanRepositoryImpl(),
      ),
      child: const _NewPlanView(),
    );
  }
}

class _NewPlanView extends StatefulWidget {
  const _NewPlanView();

  @override
  State<_NewPlanView> createState() => _NewPlanViewState();
}

class _NewPlanViewState extends State<_NewPlanView> {
  final _formKey = GlobalKey<FormState>();
  final _cropNameController = TextEditingController();
  final _landSizeController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime? _expectedHarvestDate;

  @override
  void dispose() {
    _cropNameController.dispose();
    _landSizeController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _selectStartDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      setState(() {
        _startDate = date;
      });
    }
  }

  void _selectHarvestDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _expectedHarvestDate ?? DateTime.now().add(const Duration(days: 90)),
      firstDate: _startDate,
      lastDate: DateTime(2030),
    );
    if (date != null) {
      setState(() {
        _expectedHarvestDate = date;
      });
    }
  }

  void _createPlan() {
    if (_formKey.currentState!.validate()) {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthAuthenticated) {
        final plan = Plan(
          userId: authState.user.uid,
          cropName: _cropNameController.text.trim(),
          landSize: _landSizeController.text.trim(),
          location: _locationController.text.trim(),
          startDate: _startDate,
          expectedHarvestDate: _expectedHarvestDate,
          notes: _notesController.text.trim(),
          createdAt: DateTime.now(),
        );

        context.read<PlanBloc>().add(CreatePlanRequested(plan: plan));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Plan'),
      ),
      body: BlocListener<PlanBloc, PlanState>(
        listener: (context, state) {
          if (state is PlanCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Plan created successfully'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pop();
          } else if (state is PlanError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _cropNameController,
                  decoration: const InputDecoration(
                    labelText: 'Crop Name',
                    prefixIcon: Icon(Icons.grass),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter crop name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _landSizeController,
                  decoration: const InputDecoration(
                    labelText: 'Land Size (acres)',
                    prefixIcon: Icon(Icons.landscape),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter land size';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Start Date'),
                  subtitle: Text(DateFormat('dd MMM yyyy').format(_startDate)),
                  trailing: const Icon(Icons.edit),
                  onTap: _selectStartDate,
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.event),
                  title: const Text('Expected Harvest Date (Optional)'),
                  subtitle: Text(
                    _expectedHarvestDate != null
                        ? DateFormat('dd MMM yyyy').format(_expectedHarvestDate!)
                        : 'Not set',
                  ),
                  trailing: const Icon(Icons.edit),
                  onTap: _selectHarvestDate,
                ),
                const Divider(),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Notes (Optional)',
                    prefixIcon: Icon(Icons.note),
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 32),
                BlocBuilder<PlanBloc, PlanState>(
                  builder: (context, state) {
                    if (state is PlanLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      onPressed: _createPlan,
                      child: const Text('Create Plan'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
