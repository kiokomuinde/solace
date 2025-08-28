// File: lib/screens/create_memorial_screen.dart
// This file handles the form for creating a new memorial.

import 'package:flutter/material.dart';

// A form screen for users to create and submit a new memorial.
class CreateMemorialScreen extends StatefulWidget {
  const CreateMemorialScreen({super.key});

  @override
  State<CreateMemorialScreen> createState() => _CreateMemorialScreenState();
}

class _CreateMemorialScreenState extends State<CreateMemorialScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields.
  final _nameController = TextEditingController();
  final _datesController = TextEditingController();
  final _tributeController = TextEditingController();

  // This would be replaced with actual image selection logic.
  String? _selectedImageUrl;

  @override
  void dispose() {
    _nameController.dispose();
    _datesController.dispose();
    _tributeController.dispose();
    super.dispose();
  }

  // A method to handle form submission.
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // In a real application, you would save this data to a database,
      // like Firebase Firestore.
      final newMemorial = {
        'name': _nameController.text,
        'dates': _datesController.text,
        'tribute': _tributeController.text,
        'imageUrl': _selectedImageUrl ?? 'https://placehold.co/600x400/FFF/000?text=Placeholder',
      };
      
      // For now, we'll just show a confirmation dialog.
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Memorial Created!'),
          content: Text('Memorial for "${newMemorial['name']}" has been created.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Navigate back to the Home Screen
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  // A helper method for creating the form fields.
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    String? hintText,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
        ),
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Memorial'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Honor a Loved One",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Fill out the form below to create a lasting tribute.",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  
                  // Image selection placeholder.
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Theme.of(context).colorScheme.outline),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, size: 60, color: Theme.of(context).colorScheme.onSurface),
                          const SizedBox(height: 8),
                          Text('Tap to select a photo', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  _buildTextField(
                    controller: _nameController,
                    labelText: 'Full Name',
                    hintText: 'e.g., Jane Doe',
                  ),
                  _buildTextField(
                    controller: _datesController,
                    labelText: 'Dates',
                    hintText: 'e.g., 1950 - 2023',
                  ),
                  _buildTextField(
                    controller: _tributeController,
                    labelText: 'Tribute',
                    hintText: 'Write a short tribute or memory...',
                    maxLines: 5,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: const TextStyle(fontSize: 18),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: const Text('Create Memorial'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
