import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:flutter/material.dart';

class AddExamView extends StatefulWidget {
  const AddExamView({super.key});

  static const routeName = '/add-exam';

  @override
  State<AddExamView> createState() => _AddExamViewState();
}

class _AddExamViewState extends State<AddExamView> {
  final formKey = GlobalKey<FormState>();
  final courseController = TextEditingController();
  final courseNotifier = ValueNotifier<Course?>(null);

  @override
  void dispose() {
    courseController.dispose();
    courseNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
