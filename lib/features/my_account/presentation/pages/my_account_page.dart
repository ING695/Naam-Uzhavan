import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        state.user.displayName?.substring(0, 1).toUpperCase() ??
                            state.user.email.substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                          fontSize: 48,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Profile Information',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Name'),
                          subtitle: Text(state.user.displayName ?? 'Not set'),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: const Text('Email'),
                          subtitle: Text(state.user.email),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.phone),
                          title: const Text('Phone'),
                          subtitle: Text(state.user.phoneNumber ?? 'Not set'),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.fingerprint),
                          title: const Text('User ID'),
                          subtitle: Text(state.user.uid),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'App Settings',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.notifications),
                          title: const Text('Notifications'),
                          subtitle: const Text('Manage notification preferences'),
                          trailing: Switch(
                            value: true,
                            onChanged: (value) {
                              // Handle notification toggle
                            },
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.language),
                          title: const Text('Language'),
                          subtitle: const Text('English'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            // Handle language selection
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.info_outline),
                          title: const Text('About'),
                          subtitle: const Text('Version 1.0.0'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            _showAboutDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Account Actions',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.lock, color: Colors.orange),
                          title: const Text('Change Password'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Password change feature coming soon'),
                              ),
                            );
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.logout, color: Colors.red),
                          title: const Text('Logout'),
                          onTap: () {
                            _showLogoutDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Naam Uzhavan'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Version: 1.0.0'),
            SizedBox(height: 8),
            Text('A Flutter app for farmers to manage their work and plans.'),
            SizedBox(height: 16),
            Text('Features:'),
            Text('• Authentication'),
            Text('• Plan Management'),
            Text('• Work Tracking'),
            Text('• Account Management'),
            Text('• Support'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
