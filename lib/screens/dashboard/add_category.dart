import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pernance/models_powersync/index.dart';
import 'package:pernance/routes/routes.dart';
import 'package:pernance/utils/get_user_id.dart';

@RoutePage()
class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key, required this.onSubmit});

  final void Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: AddCategoryForm(onSubmit: onSubmit),
            ),
          ],
        ),
      ),
    );
  }
}

class AddCategoryForm extends StatefulWidget {
  const AddCategoryForm({super.key, required this.onSubmit});

  final void Function() onSubmit;

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
                          await db.execute(
                            'INSERT INTO categories(id, name, budget, user_id) VALUES(gen_random_uuid(), ?, ?, ?)',
                            [_nameController.text, _budgetController.text, await getUserId()]
                          );

                          // Update the data
                          widget.onSubmit();
                          
                          // Redirect back to categories page
                          router.navigate(const CategoriesRoute());
                        } catch (e) {
                          print(e);
                          setState(() {
                            _errorMessage = 'Something bad happened, please try again later';
                          });
                        }
                      } else {
                        print('not valid');
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
