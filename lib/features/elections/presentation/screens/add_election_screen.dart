import 'package:flutter/material.dart';
import 'package:solutech_votify/features/elections/presentation/widgets/add_election_form.dart';

class AddElectionScreen extends StatelessWidget {
  static const routePath = '/add-election';
  const AddElectionScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Election",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: const AddElectionForm(),
        ),
      ),
    );
  }
}
