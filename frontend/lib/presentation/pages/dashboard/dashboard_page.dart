import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../../data/models/response/transaction_response_model.dart';
import '../../bloc/transaction/transaction_bloc.dart';
import '../../bloc/transaction/transaction_event.dart';
import '../../bloc/transaction/transaction_state.dart';
import '../settings/settings_page.dart';
import '../transactions/transactions_page.dart';
import '../accounts/accounts_page.dart';
import '../categories/categories_page.dart';
import '../transactions/add_transaction_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  TransactionStatisticsDataModel? _statistics;
  List<TransactionModel> _recentTransactions = [];

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  void _loadDashboardData() {
    // Load statistics
    context.read<TransactionBloc>().add(const TransactionLoadStatistics());

    // Load recent transactions (5 latest)
    context.read<TransactionBloc>().add(
      const TransactionLoadAll(
        perPage: 5,
        sortBy: 'created_at',
        sortOrder: 'desc',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionStatisticsLoaded) {
          setState(() {
            _statistics = state.statistics;
          });
        } else if (state is TransactionLoaded) {
          setState(() {
            _recentTransactions = state.transactions;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.dashboard),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadDashboardData,
            ),
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                NavigationService.push(const SettingsPage());
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _loadDashboardData();
            // Wait a bit for the data to load
            await Future.delayed(const Duration(milliseconds: 500));
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary Cards from Statistics
                BlocBuilder<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                    if (state is TransactionLoading && _statistics == null) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final stats = _statistics;
                    if (stats == null) {
                      return const SizedBox.shrink();
                    }

                    final totalIncome = double.tryParse(stats.totalIncome) ?? 0;
                    final totalExpense =
                        double.tryParse(stats.totalExpense) ?? 0;
                    final netAmount = double.tryParse(stats.netAmount) ?? 0;

                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildSummaryCard(
                                title: 'Net Amount',
                                amount: netAmount,
                                color: netAmount >= 0
                                    ? AppColors.income
                                    : AppColors.expense,
                                icon: Icons.account_balance_wallet,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildSummaryCard(
                                title: 'Transactions',
                                amount: stats.transactionCount.toDouble(),
                                color: AppColors.primary,
                                icon: Icons.receipt_long,
                                isCount: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildSummaryCard(
                                title: AppStrings.totalIncome,
                                amount: totalIncome,
                                color: AppColors.income,
                                icon: Icons.trending_up,
                                count: stats.incomeCount,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildSummaryCard(
                                title: AppStrings.totalExpense,
                                amount: totalExpense,
                                color: AppColors.expense,
                                icon: Icons.trending_down,
                                count: stats.expenseCount,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Recent Transactions Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.recentTransactions,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        NavigationService.pushReplacement(
                          const TransactionsPage(),
                        );
                      },
                      child: const Text(AppStrings.viewAll),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Recent Transactions List
                BlocBuilder<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                    if (state is TransactionLoading &&
                        _recentTransactions.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (_recentTransactions.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.receipt_long_outlined,
                                size: 64,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No transactions yet',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _recentTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = _recentTransactions[index];
                        final isIncome = transaction.type == 'income';

                        return _buildTransactionItem(
                          title: transaction.note ?? 'No note',
                          description:
                              transaction.counterparty ??
                              transaction.category?.name ??
                              'No category',
                          amount: double.parse(transaction.amount),
                          isIncome: isIncome,
                          date: DateTime.parse(transaction.date),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            // Navigate to respective pages
            switch (index) {
              case 0:
                // Already on dashboard
                break;
              case 1:
                NavigationService.pushReplacement(const TransactionsPage());
                break;
              case 2:
                NavigationService.pushReplacement(const CategoriesPage());
                break;
              case 3:
                NavigationService.pushReplacement(const AccountsPage());
                break;
            }
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: AppStrings.dashboard,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: AppStrings.transactions,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance),
              label: AppStrings.accounts,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            NavigationService.push(const AddTransactionPage());
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required double amount,
    required Color color,
    required IconData icon,
    int? count,
    bool isCount = false,
  }) {
    return Card(
      elevation: 4,
      child: Container(
        height: 120, // Fixed height untuk konsistensi
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const Spacer(),
                if (count != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$count',
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  isCount ? amount.toInt().toString() : _formatCurrency(amount),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String description,
    required double amount,
    required bool isIncome,
    required DateTime date,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isIncome ? AppColors.income : AppColors.expense,
          child: Icon(
            isIncome ? Icons.arrow_upward : Icons.arrow_downward,
            color: Colors.white,
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(description),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${isIncome ? '+' : '-'}${_formatCurrency(amount)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isIncome ? AppColors.income : AppColors.expense,
              ),
            ),
            Text(
              _formatDate(date),
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
        onTap: () {
          // TODO: Navigate to transaction detail
        },
      ),
    );
  }

  String _formatCurrency(double amount) {
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match.group(1)}.')}';
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
