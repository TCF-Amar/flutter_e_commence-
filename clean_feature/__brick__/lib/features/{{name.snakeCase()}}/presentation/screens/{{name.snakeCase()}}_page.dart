import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/{{name.snakeCase()}}_controller.dart';

class {{name.pascalCase()}}Screen extends GetView<{{name.pascalCase()}}Controller> {
  const {{name.pascalCase()}}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('{{name.pascalCase()}}'),
      ),
      body: const Center(
        child: Text('{{name.pascalCase()}} Screen'),
      ),
    );
  }
}
