import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pernance/models/category.dart';
import 'package:pernance/models/index.dart';

import 'package:realm/realm.dart';

@RoutePage()
class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: AddCategoryForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class AddCategoryForm extends StatefulWidget {
  const AddCategoryForm({super.key});

  @override
  AddCategoryFormState createState() {
    return AddCategoryFormState();
  }
}


class AddCategoryFormState extends State<AddCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _budgetController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Category Name',
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the budget';
              }
              return null;
            },
            controller: _budgetController,
            decoration: const InputDecoration(
              labelText: 'Budget',
            ),
          ),
          const SizedBox(height: 20),
          Column(
              children: <Widget>[
                if (_errorMessage != '') Text(_errorMessage, style: const TextStyle(color: Colors.red)),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {                     
                          // Add Category
                          RealmProvider().realm.write(() {
                            final newCategory = Category(ObjectId(), _nameController.text, int.parse(_budgetController.text));
                            RealmProvider().realm.add(newCategory);
                          });
                          // Redirect back to categories page
                          router.back();
                        } catch (e) {
                          print(e);
                          setState(() {
                            _errorMessage = 'Something bad happened, please try again later';
                          });
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue),
                    ),
                    child: const Text('Add Category', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
