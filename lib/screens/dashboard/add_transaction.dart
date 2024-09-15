import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pernance/models_powersync/category.dart';
import 'package:pernance/models_powersync/index.dart';

import 'package:pernance/routes/routes.dart';
import 'package:pernance/utils/get_user_id.dart';

@RoutePage()
class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: AddTransactionForm(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    router.push(const RegisterRoute());
                  },
                  style: ButtonStyle(padding: WidgetStateProperty.all(EdgeInsets.zero)),
                  child: const Text("Register", style: TextStyle(color: Colors.blue),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({super.key});

  @override
  AddTransactionFormState createState() {
    return AddTransactionFormState();
  }
}


class AddTransactionFormState extends State<AddTransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  // final _dateController = TextEditingController();
  String? _selectedCategory;
  String _errorMessage = '';

  void _showCategoryModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: FutureBuilder(
            future: db.getAll('SELECT * FROM categories'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final categories = snapshot.data!.map((row) => Category.fromRow(row)).toList();

              return ListView(
                children: categories
                    .map((Category category) => ListTile(
                          title: Text(category.name),
                          onTap: () {
                            setState(() {
                              _selectedCategory = category.id;
                              Navigator.pop(context);
                            });
                          },
                        ))
                    .toList(),
              );
            }
          ),
        );
      },
    );
  }

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
              labelText: 'Transaction Name',
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the amount';
              }
              return null;
            },
            controller: _amountController,
            decoration: const InputDecoration(
              labelText: 'Amount',
            ),
          ),
          const SizedBox(height: 10),
          // TextButton(
          //   onPressed: _showDatePicker,
          // ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _showCategoryModal,
            child: Text(_selectedCategory ?? 'Choose Category'),
          ),
          const SizedBox(height: 20),
          Column(
              children: <Widget>[
                if (_errorMessage != '') Text(_errorMessage, style: const TextStyle(color: Colors.red),),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() && _selectedCategory != null) {
                        try {                     
                          // Add Transaction
                          // await db.execute(
                          //   'INSERT INTO categories(id, category_id, name, price, date, user_id) VALUES(gen_random_uuid(), ?, ?, ?, ?, ?)',
                          //   [_nameController.text, _amountController.text, await getUserId()]
                          // );

                          // Update the data
                          // widget.onSubmit();
                          
                          // Redirect to dashboard
                          router.replace(const DashboardRoute());
                        } catch (e) {
                            _errorMessage = 'Something bad happened, please try again later';
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue),
                    ),
                    child: const Text('Add Transaction', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
