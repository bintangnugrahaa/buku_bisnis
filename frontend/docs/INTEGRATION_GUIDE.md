# Panduan Integrasi BLoC ke UI

Semua BLoC sudah dibuat dan tersedia. Berikut panduan untuk mengintegrasikan BLoC ke halaman-halaman yang tersisa.

## 📁 File yang Sudah Selesai ✓

- ✅ Login Page (`login_page.dart`)
- ✅ Register Page (`register_page.dart`)
- ✅ Splash Page (`splash_page.dart`)
- ✅ Main App (`main.dart`) - MultiBlocProvider

## 📋 File yang Perlu Diintegrasikan

### 1. **Accounts Page** (`accounts_page.dart`)

**Import yang diperlukan:**
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/account/account_bloc.dart';
import '../../bloc/account/account_event.dart';
import '../../bloc/account/account_state.dart';
```

**Load data di initState:**
```dart
@override
void initState() {
  super.initState();
  // Load accounts when page opens
  context.read<AccountBloc>().add(const AccountLoadAll());
}
```

**Replace Scaffold dengan BlocConsumer:**
```dart
return BlocConsumer<AccountBloc, AccountState>(
  listener: (context, state) {
    if (state is AccountError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    } else if (state is AccountOperationSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  builder: (context, state) {
    // Handle different states
    if (state is AccountLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Accounts')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (state is AccountLoaded) {
      final accounts = state.accounts;

      return Scaffold(
        appBar: AppBar(title: const Text('Accounts')),
        body: ListView.builder(
          itemCount: accounts.length,
          itemBuilder: (context, index) {
            final account = accounts[index];
            return ListTile(
              title: Text(account.name),
              subtitle: Text(account.type),
              trailing: Text('Rp ${account.startingBalance}'),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddAccountPage()),
          ),
          child: const Icon(Icons.add),
        ),
      );
    }

    // Default: show empty state
    return Scaffold(
      appBar: AppBar(title: const Text('Accounts')),
      body: const Center(child: Text('No accounts')),
    );
  },
);
```

---

### 2. **Add Account Page** (`add_account_page.dart`)

**Import yang diperlukan:**
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_constants.dart';
import '../../bloc/account/account_bloc.dart';
import '../../bloc/account/account_event.dart';
import '../../bloc/account/account_state.dart';
```

**Handle form submission:**
```dart
void _handleSubmit() {
  if (_formKey.currentState!.validate()) {
    context.read<AccountBloc>().add(
      AccountCreate(
        name: _nameController.text.trim(),
        type: _selectedType, // e.g., AppConstants.accountTypeCash
        startingBalance: double.parse(_balanceController.text),
        isActive: true,
      ),
    );
  }
}
```

**Listen to BLoC state:**
```dart
return BlocConsumer<AccountBloc, AccountState>(
  listener: (context, state) {
    if (state is AccountOperationSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
      Navigator.pop(context); // Go back to accounts list
    } else if (state is AccountError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  builder: (context, state) {
    final isLoading = state is AccountLoading;

    return Scaffold(
      // Your form UI here
      // Disable submit button when loading
      ElevatedButton(
        onPressed: isLoading ? null : _handleSubmit,
        child: isLoading
            ? const CircularProgressIndicator()
            : const Text('Save'),
      ),
    );
  },
);
```

---

### 3. **Transactions Page** (`transactions_page.dart`)

**Import yang diperlukan:**
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_constants.dart';
import '../../bloc/transaction/transaction_bloc.dart';
import '../../bloc/transaction/transaction_event.dart';
import '../../bloc/transaction/transaction_state.dart';
```

**Load data di initState:**
```dart
@override
void initState() {
  super.initState();
  // Load transactions
  context.read<TransactionBloc>().add(const TransactionLoadAll());

  // Optionally load with filters
  // final today = DateTime.now();
  // final firstDayOfMonth = DateTime(today.year, today.month, 1);
  // context.read<TransactionBloc>().add(
  //   TransactionLoadAll(
  //     fromDate: DateFormat(AppConstants.apiDateFormat).format(firstDayOfMonth),
  //     toDate: DateFormat(AppConstants.apiDateFormat).format(today),
  //   ),
  // );
}
```

**BlocConsumer:**
```dart
return BlocConsumer<TransactionBloc, TransactionState>(
  listener: (context, state) {
    if (state is TransactionError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  builder: (context, state) {
    if (state is TransactionLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is TransactionLoaded) {
      final transactions = state.transactions;
      final pagination = state.pagination;

      return Scaffold(
        appBar: AppBar(
          title: Text('Transactions (${pagination.total})'),
        ),
        body: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return ListTile(
              title: Text(transaction.note ?? 'No note'),
              subtitle: Text('${transaction.date} - ${transaction.account?.name}'),
              trailing: Text(
                '${transaction.type == 'income' ? '+' : '-'} Rp ${transaction.amount}',
                style: TextStyle(
                  color: transaction.type == 'income' ? Colors.green : Colors.red,
                ),
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: const Center(child: Text('No transactions')),
    );
  },
);
```

---

### 4. **Add Transaction Page** (`add_transaction_page.dart`)

**Import yang diperlukan:**
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_constants.dart';
import '../../bloc/transaction/transaction_bloc.dart';
import '../../bloc/transaction/transaction_event.dart';
import '../../bloc/transaction/transaction_state.dart';
import '../../bloc/account/account_bloc.dart';
import '../../bloc/account/account_event.dart';
import '../../bloc/account/account_state.dart';
import '../../bloc/category/category_bloc.dart';
import '../../bloc/category/category_event.dart';
import '../../bloc/category/category_state.dart';
```

**Load accounts and categories di initState:**
```dart
@override
void initState() {
  super.initState();
  // Load accounts for dropdown
  context.read<AccountBloc>().add(const AccountLoadAll());

  // Load categories for dropdown (filter by type if needed)
  context.read<CategoryBloc>().add(const CategoryLoadAll());
}
```

**Handle form submission:**
```dart
void _handleSubmit() {
  if (_formKey.currentState!.validate()) {
    final date = DateFormat(AppConstants.apiDateFormat).format(_selectedDate);

    if (_isTransfer) {
      // Create transfer
      context.read<TransactionBloc>().add(
        TransactionCreateTransfer(
          fromAccountId: _fromAccountId!,
          toAccountId: _toAccountId!,
          amount: double.parse(_amountController.text),
          date: date,
          note: _noteController.text,
        ),
      );
    } else {
      // Create normal transaction
      context.read<TransactionBloc>().add(
        TransactionCreate(
          accountId: _selectedAccountId!,
          categoryId: _selectedCategoryId!,
          type: _transactionType, // income or expense
          date: date,
          amount: double.parse(_amountController.text),
          note: _noteController.text,
          counterparty: _counterpartyController.text,
        ),
      );
    }
  }
}
```

**Dropdown for accounts and categories:**
```dart
// Account Dropdown
BlocBuilder<AccountBloc, AccountState>(
  builder: (context, state) {
    if (state is AccountLoaded) {
      return DropdownButtonFormField<int>(
        value: _selectedAccountId,
        decoration: const InputDecoration(labelText: 'Account'),
        items: state.accounts.map((account) {
          return DropdownMenuItem<int>(
            value: account.id,
            child: Text(account.name),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedAccountId = value;
          });
        },
      );
    }
    return const CircularProgressIndicator();
  },
),

// Category Dropdown
BlocBuilder<CategoryBloc, CategoryState>(
  builder: (context, state) {
    if (state is CategoryLoaded) {
      // Filter categories by transaction type
      final categories = state.categories
          .where((cat) => cat.type == _transactionType)
          .toList();

      return DropdownButtonFormField<int>(
        value: _selectedCategoryId,
        decoration: const InputDecoration(labelText: 'Category'),
        items: categories.map((category) {
          return DropdownMenuItem<int>(
            value: category.id,
            child: Text(category.name),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedCategoryId = value;
          });
        },
      );
    }
    return const CircularProgressIndicator();
  },
),
```

---

### 5. **Dashboard Page** (`dashboard_page.dart`)

**Import yang diperlukan:**
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_constants.dart';
import '../../bloc/transaction/transaction_bloc.dart';
import '../../bloc/transaction/transaction_event.dart';
import '../../bloc/transaction/transaction_state.dart';
import '../../bloc/account/account_bloc.dart';
import '../../bloc/account/account_event.dart';
import '../../bloc/account/account_state.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
```

**Load data di initState:**
```dart
@override
void initState() {
  super.initState();

  // Load current user
  context.read<AuthBloc>().add(const AuthGetCurrentUser());

  // Load accounts
  context.read<AccountBloc>().add(const AccountLoadAll());

  // Load transaction statistics for current month
  final today = DateTime.now();
  final firstDay = DateTime(today.year, today.month, 1);
  context.read<TransactionBloc>().add(
    TransactionLoadStatistics(
      fromDate: DateFormat(AppConstants.apiDateFormat).format(firstDay),
      toDate: DateFormat(AppConstants.apiDateFormat).format(today),
    ),
  );

  // Load recent transactions
  context.read<TransactionBloc>().add(
    const TransactionLoadAll(perPage: 5, sortBy: 'created_at', sortOrder: 'desc'),
  );
}
```

**Show user info:**
```dart
BlocBuilder<AuthBloc, AuthState>(
  builder: (context, state) {
    if (state is AuthAuthenticated) {
      return Text('Welcome, ${state.user.name}!');
    }
    return const Text('Welcome!');
  },
),
```

**Show statistics:**
```dart
BlocBuilder<TransactionBloc, TransactionState>(
  builder: (context, state) {
    if (state is TransactionStatisticsLoaded) {
      final stats = state.statistics;

      return Column(
        children: [
          StatCard(
            title: 'Total Income',
            amount: stats.totalIncome,
            color: Colors.green,
          ),
          StatCard(
            title: 'Total Expense',
            amount: stats.totalExpense,
            color: Colors.red,
          ),
          StatCard(
            title: 'Net Amount',
            amount: stats.netAmount,
            color: Colors.blue,
          ),
        ],
      );
    }
    return const CircularProgressIndicator();
  },
),
```

**Show accounts summary:**
```dart
BlocBuilder<AccountBloc, AccountState>(
  builder: (context, state) {
    if (state is AccountLoaded) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.accounts.length,
        itemBuilder: (context, index) {
          final account = state.accounts[index];
          return ListTile(
            title: Text(account.name),
            subtitle: Text(account.type),
            trailing: Text('Rp ${account.startingBalance}'),
          );
        },
      );
    }
    return const CircularProgressIndicator();
  },
),
```

---

## 🎯 Pattern Umum untuk Semua Halaman

### 1. **Import BLoC**
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/[feature]/[feature]_bloc.dart';
import '../../bloc/[feature]/[feature]_event.dart';
import '../../bloc/[feature]/[feature]_state.dart';
```

### 2. **Trigger Event di initState**
```dart
@override
void initState() {
  super.initState();
  context.read<[Feature]Bloc>().add(const [Feature]LoadAll());
}
```

### 3. **Listen to State Changes**
```dart
BlocConsumer<[Feature]Bloc, [Feature]State>(
  listener: (context, state) {
    if (state is [Feature]Error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  builder: (context, state) {
    // Build UI based on state
  },
);
```

### 4. **Trigger Event on User Action**
```dart
void _handleAction() {
  context.read<[Feature]Bloc>().add(
    [Feature]Action(/* parameters */),
  );
}
```

---

## 🔄 Refresh Pattern

Untuk refresh data (pull to refresh):

```dart
RefreshIndicator(
  onRefresh: () async {
    context.read<TransactionBloc>().add(const TransactionRefresh());
    // Wait for state to update
    await Future.delayed(const Duration(seconds: 1));
  },
  child: ListView(...),
)
```

---

## 🔐 Logout Implementation

Di Settings Page atau menu:

```dart
void _handleLogout() {
  context.read<AuthBloc>().add(const AuthLogoutRequested());
}

// Listen to auth state
BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthUnauthenticated) {
      // Navigate to login
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }
  },
  child: // Your widget
)
```

---

## 📝 Important Notes

1. **Semua BLoC sudah tersedia** melalui MultiBlocProvider di main.dart
2. **Gunakan `context.read<Bloc>()`** untuk trigger events
3. **Gunakan `BlocBuilder`** untuk rebuild UI berdasarkan state
4. **Gunakan `BlocListener`** untuk side effects (navigation, snackbar)
5. **Gunakan `BlocConsumer`** untuk kombinasi builder + listener
6. **Format tanggal** gunakan `AppConstants.apiDateFormat` untuk API
7. **Account types** gunakan constants dari `AppConstants.accountType*`
8. **Transaction types** gunakan `AppConstants.transactionType*`

---

## 🚀 Next Steps

1. Integrasikan BLoC ke `accounts_page.dart`
2. Integrasikan BLoC ke `add_account_page.dart`
3. Integrasikan BLoC ke `transactions_page.dart`
4. Integrasikan BLoC ke `add_transaction_page.dart`
5. Integrasikan BLoC ke `dashboard_page.dart`
6. Test semua fitur end-to-end
7. Run `flutter pub get` untuk install dependencies
8. Run aplikasi dan test API integration

---

## 🐛 Troubleshooting

**Error: "BlocProvider.of() called with a context that does not contain a Bloc"**
- Pastikan widget dibungkus oleh BlocProvider
- Check bahwa BLoC sudah disediakan di main.dart

**Error: "Bad state: Cannot add new events after calling close"**
- Jangan trigger event setelah BLoC di-dispose
- Gunakan `if (mounted)` sebelum trigger event di async functions

**Data tidak ter-update setelah create/update/delete**
- Pastikan ada `add([Feature]LoadAll())` setelah operation success di BLoC

---

Semua BLoC sudah siap digunakan! Ikuti panduan di atas untuk mengintegrasikan ke UI. 🎉
