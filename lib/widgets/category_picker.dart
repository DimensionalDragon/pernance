import 'package:flutter/material.dart';
import 'package:pernance/models/category.dart';
import 'package:pernance/models/index.dart';

class CategoryPicker extends StatefulWidget {
  const CategoryPicker({super.key});

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.getAll('SELECT * FROM categories'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final categories = snapshot.data!.map((row) => Category.fromRow(row)).toList();

        return ListView(
          children: categories.map((Category category) => ListTile(
            title: Text(category.name),
            onTap: () {
              setState(() {
                selectedCategory = category;
                Navigator.pop(context);
              });
            },
          )).toList(),
        );
      }
    );
  }
}