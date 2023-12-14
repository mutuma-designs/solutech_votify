import 'package:flutter/material.dart';

import '../widgets/add_roles_form.dart';

class AddRolesScreen extends StatelessWidget {
  static const routePath = '/add-roles';
  const AddRolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add role',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: const AddRolesForm(),
        ),
      ),
    );
  }
}
