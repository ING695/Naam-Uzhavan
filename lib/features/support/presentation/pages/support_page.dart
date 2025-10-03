import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.support_agent,
                size: 80,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'How can we help you?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 32),
            Text(
              'Contact Us',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: const Text('support@naamuzhavan.com'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Opening email client...'),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Phone'),
                    subtitle: const Text('+91 1234567890'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Opening phone dialer...'),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.chat),
                    title: const Text('Live Chat'),
                    subtitle: const Text('Chat with our support team'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Live chat coming soon'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Frequently Asked Questions',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const _FAQCard(
              question: 'How do I create a new plan?',
              answer:
                  'Navigate to the "New Plan" tab from the bottom navigation bar. Fill in the details about your crop, land size, location, and dates, then tap "Create Plan".',
            ),
            const SizedBox(height: 12),
            const _FAQCard(
              question: 'Can I edit my plans?',
              answer:
                  'Currently, you can view and delete your plans from the "My Work" tab. Edit functionality will be added in a future update.',
            ),
            const SizedBox(height: 12),
            const _FAQCard(
              question: 'How do I track my work progress?',
              answer:
                  'Go to the "My Work" tab to see all your plans. Each plan shows the start date, expected harvest date, and days remaining until harvest.',
            ),
            const SizedBox(height: 12),
            const _FAQCard(
              question: 'Is my data secure?',
              answer:
                  'Yes, all your data is securely stored in Firebase and protected with Firebase Authentication. Your information is private and only accessible to you.',
            ),
            const SizedBox(height: 12),
            const _FAQCard(
              question: 'How do I reset my password?',
              answer:
                  'Password reset functionality will be available soon. For now, please contact support if you need to reset your password.',
            ),
            const SizedBox(height: 24),
            Text(
              'Send Feedback',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const _FeedbackForm(),
          ],
        ),
      ),
    );
  }
}

class _FAQCard extends StatefulWidget {
  final String question;
  final String answer;

  const _FAQCard({
    required this.question,
    required this.answer,
  });

  @override
  State<_FAQCard> createState() => _FAQCardState();
}

class _FAQCardState extends State<_FAQCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.question,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                ],
              ),
              if (_isExpanded) ...[
                const SizedBox(height: 12),
                Text(
                  widget.answer,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _FeedbackForm extends StatefulWidget {
  const _FeedbackForm();

  @override
  State<_FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<_FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thank you for your feedback!'),
          backgroundColor: Colors.green,
        ),
      );
      _feedbackController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _feedbackController,
                decoration: const InputDecoration(
                  labelText: 'Your Feedback',
                  hintText: 'Tell us what you think...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your feedback';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitFeedback,
                child: const Text('Submit Feedback'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
