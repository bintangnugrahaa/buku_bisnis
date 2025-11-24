import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../../core/utils/currency_input_formatter.dart';
import '../../../data/models/response/account_response_model.dart';
import '../../../data/models/response/category_response_model.dart';
import '../../bloc/account/account_bloc.dart';
import '../../bloc/account/account_event.dart';
import '../../bloc/account/account_state.dart';
import '../../bloc/category/category_bloc.dart';
import '../../bloc/category/category_event.dart';
import '../../bloc/category/category_state.dart';
import '../../bloc/transaction/transaction_bloc.dart';
import '../../bloc/transaction/transaction_event.dart';
import '../../bloc/transaction/transaction_state.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _noteController = TextEditingController();
  final _counterpartyController = TextEditingController();
  final _amountController = TextEditingController();

  String _selectedType = 'income';
  int? _selectedCategoryId;
  int? _selectedAccountId;
  DateTime _selectedDate = DateTime.now();

  List<AccountModel> _accounts = [];
  List<CategoryModel> _incomeCategories = [];
  List<CategoryModel> _expenseCategories = [];

  @override
  void initState() {
    super.initState();
    // Load accounts and categories
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccountBloc>().add(AccountLoadAll());
      context.read<CategoryBloc>().add(CategoryLoadAll());
    });
  }

  @override
  void dispose() {
    _noteController.dispose();
    _counterpartyController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state is TransactionOperationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              NavigationService.pop();
            } else if (state is TransactionError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
        BlocListener<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is AccountLoaded) {
              setState(() {
                _accounts = state.accounts;
                if (_accounts.isNotEmpty && _selectedAccountId == null) {
                  _selectedAccountId = _accounts.first.id;
                }
              });
            }
          },
        ),
        BlocListener<CategoryBloc, CategoryState>(
          listener: (context, state) {
            if (state is CategoryLoaded) {
              setState(() {
                _incomeCategories = state.categories
                    .where((c) => c.type == 'income')
                    .toList();
                _expenseCategories = state.categories
                    .where((c) => c.type == 'expense')
                    .toList();
                if (_selectedType == 'income' &&
                    _incomeCategories.isNotEmpty &&
                    _selectedCategoryId == null) {
                  _selectedCategoryId = _incomeCategories.first.id;
                } else if (_selectedType == 'expense' &&
                    _expenseCategories.isNotEmpty &&
                    _selectedCategoryId == null) {
                  _selectedCategoryId = _expenseCategories.first.id;
                }
              });
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Transaction'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              NavigationService.pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Transaction Type
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Transaction Type',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedType = 'income';
                                    if (_incomeCategories.isNotEmpty) {
                                      _selectedCategoryId =
                                          _incomeCategories.first.id;
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: _selectedType == 'income'
                                        ? AppColors.income.withValues(
                                            alpha: 0.1,
                                          )
                                        : AppColors.surface,
                                    border: Border.all(
                                      color: _selectedType == 'income'
                                          ? AppColors.income
                                          : AppColors.border,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_upward,
                                        color: AppColors.income,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Income',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedType = 'expense';
                                    if (_expenseCategories.isNotEmpty) {
                                      _selectedCategoryId =
                                          _expenseCategories.first.id;
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: _selectedType == 'expense'
                                        ? AppColors.expense.withValues(
                                            alpha: 0.1,
                                          )
                                        : AppColors.surface,
                                    border: Border.all(
                                      color: _selectedType == 'expense'
                                          ? AppColors.expense
                                          : AppColors.border,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_downward,
                                        color: AppColors.expense,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Expense',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Amount
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Rp',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(minWidth: 50),
                    border: const OutlineInputBorder(),
                  ),
                  inputFormatters: [CurrencyInputFormatter()],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Amount is required';
                    }
                    // Remove all non-digit characters (including dots/commas)
                    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
                    if (digitsOnly.isEmpty || double.tryParse(digitsOnly) == null) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Note
                TextFormField(
                  controller: _noteController,
                  decoration: const InputDecoration(
                    labelText: 'Note',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Counterparty
                TextFormField(
                  controller: _counterpartyController,
                  decoration: const InputDecoration(
                    labelText: 'Counterparty (Optional)',
                    border: OutlineInputBorder(),
                    hintText: 'Client/Supplier name',
                  ),
                ),
                const SizedBox(height: 16),

                // Category
                DropdownButtonFormField<int>(
                  value: _selectedCategoryId,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      (_selectedType == 'income'
                              ? _incomeCategories
                              : _expenseCategories)
                          .map(
                            (category) => DropdownMenuItem<int>(
                              value: category.id,
                              child: Text(category.name),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategoryId = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Account
                DropdownButtonFormField<int>(
                  value: _selectedAccountId,
                  decoration: const InputDecoration(
                    labelText: 'Account',
                    border: OutlineInputBorder(),
                  ),
                  items: _accounts
                      .map(
                        (account) => DropdownMenuItem<int>(
                          value: account.id,
                          child: Text(account.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedAccountId = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an account';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Date
                InkWell(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    child: Text(
                      '${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year}',
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Save Button
                BlocBuilder<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                    final isLoading = state is TransactionLoading;

                    return ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                // Parse amount - remove all non-digit characters
                                final amount = double.parse(
                                  _amountController.text.replaceAll(
                                    RegExp(r'[^\d]'),
                                    '',
                                  ),
                                );

                                // Format date to yyyy-MM-dd
                                final formattedDate = DateFormat(
                                  'yyyy-MM-dd',
                                ).format(_selectedDate);

                                // Create transaction event
                                context.read<TransactionBloc>().add(
                                  TransactionCreate(
                                    accountId: _selectedAccountId!,
                                    categoryId: _selectedCategoryId!,
                                    type: _selectedType,
                                    date: formattedDate,
                                    amount: amount,
                                    note: _noteController.text.isNotEmpty
                                        ? _noteController.text
                                        : null,
                                    counterparty:
                                        _counterpartyController.text.isNotEmpty
                                        ? _counterpartyController.text
                                        : null,
                                  ),
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text(
                              'Save Transaction',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
