import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import 'package:pernance/models/category.dart';
import 'package:pernance/models/index.dart';
import 'package:pernance/providers/transactions.dart';
import 'package:pernance/routes/routes.dart';
import 'package:pernance/widgets/editable_text.dart';

@RoutePage()
class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

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
              child: AddTransactionForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class AddTransactionForm extends ConsumerStatefulWidget {
  const AddTransactionForm({super.key});

  @override
  ConsumerState<AddTransactionForm> createState() => AddTransactionFormState();
}

class AddTransactionFormState extends ConsumerState<AddTransactionForm> {
  // Main form management
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;
  bool _isMultipleTransaction = false;

  // Subtransactions management
  final List<Widget> _subtransactionFormsList = [];

  // Error message state
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = now;
    _dateController.text = DateFormat('d MMM yyyy').format(now);
  }

  void _addSubtransactionForm() {
    setState(() {
      _subtransactionFormsList.add(
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 150,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          print('Item deleted');
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ]
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Item Name',
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the item price';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Price',
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      );
    });
  }

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

                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListView(
                    children: categories.map((Category category) => ListTile(
                      title: Text(category.name),
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                          Navigator.pop(context);
                        });
                      },
                    )).toList(),
                  ),
                );
              }),
        );
      },
    );
  }

  _showDatePicker() async {
    DateTime? chosenDate = await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      type: OmniDateTimePickerType.date
    );
    setState(() {
      if (chosenDate != null) {
        _selectedDate = chosenDate;
        _dateController.text = DateFormat('d MMM yyyy').format(chosenDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // TextFormField(
          //   keyboardType: TextInputType.name,
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return 'Please enter some text';
          //     }
          //     return null;
          //   },
          //   controller: _nameController,
          //   decoration: const InputDecoration(
          //     labelText: 'Transaction Name',
          //   ),
          // ),
          const Text(
            'Add A New Transaction',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          PernanceEditableText(
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: _nameController,
            placeholder: 'Transaction Name',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold
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
            controller: _priceController,
            decoration: const InputDecoration(
              labelText: 'Price',
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            readOnly: true,
            textAlign: TextAlign.center,
            onTap: _showDatePicker,
            controller: _dateController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please choose the date of purchase';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _showCategoryModal,
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              textStyle: WidgetStatePropertyAll(
                TextStyle(
                  fontSize: 10,
                  color: Colors.blue,
                )
              ),
            ),
            child: Text(_selectedCategory?.name ?? 'Choose Category'),
          ),
          const SizedBox(height: 20),
          // ElevatedButton(onPressed: _addSubtransactionForm, child: const Text('Add a specific item to this purchase')),
          CheckboxListTile(
            title: const Text(
              'This is a multiple transaction',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
            value: _isMultipleTransaction,
            onChanged: (newValue) {
              setState(() {
                _isMultipleTransaction = newValue!; 
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          if (_isMultipleTransaction)
            Column(
              children: _subtransactionFormsList + [
                FilledButton(
                  onPressed: _addSubtransactionForm,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      Text('Add Item'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ]
            ),
          const SizedBox(height: 20),
          Column(
            children: <Widget>[
              if (_errorMessage != '') Text(_errorMessage,style: const TextStyle(color: Colors.red)),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() && _selectedDate != null && _selectedCategory != null) {
                      try {
                        // Add Transaction
                        await ref.read(transactionsNotifierProvider.notifier).addTransaction(
                          name: _nameController.text,
                          price: _priceController.text,
                          categoryId: _selectedCategory!.id,
                          date: _selectedDate
                        );

                        // Redirect back to transactions page
                        router.navigate(const TransactionsRoute());
                      } catch (e) {
                        _errorMessage = 'Something bad happened, please try again later';
                      }
                    }
                  },
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
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
