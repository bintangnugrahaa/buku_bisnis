import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/navigation/navigation_service.dart';
import '../dashboard/dashboard_page.dart';
import '../transactions/transactions_page.dart';
import '../accounts/accounts_page.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  int _selectedIndex = 3; // Reports tab

  // Dummy data for reports
  final Map<String, dynamic> _reportData = {
    'currentMonth': {'income': 12500000, 'expense': 8200000, 'profit': 4300000},
    'lastMonth': {'income': 11200000, 'expense': 7800000, 'profit': 3400000},
    'yearToDate': {
      'income': 125000000,
      'expense': 82000000,
      'profit': 43000000,
    },
  };

  // Temporarily commented out for Monthly Trend
  /*
  final List<Map<String, dynamic>> _monthlyData = [
    {'month': 'Jan', 'income': 10500000, 'expense': 7200000},
    {'month': 'Feb', 'income': 11200000, 'expense': 7800000},
    {'month': 'Mar', 'income': 12500000, 'expense': 8200000},
    {'month': 'Apr', 'income': 13200000, 'expense': 8900000},
    {'month': 'May', 'income': 11800000, 'expense': 8100000},
    {'month': 'Jun', 'income': 14200000, 'expense': 9500000},
  ];
  */

  final List<Map<String, dynamic>> _topCategories = [
    {'name': 'Sales Revenue', 'amount': 8500000, 'percentage': 68},
    {'name': 'Service Revenue', 'amount': 3000000, 'percentage': 24},
    {'name': 'Other Income', 'amount': 1000000, 'percentage': 8},
  ];

  final List<Map<String, dynamic>> _topExpenses = [
    {'name': 'Office Rent', 'amount': 4500000, 'percentage': 55},
    {'name': 'Raw Materials', 'amount': 1200000, 'percentage': 15},
    {'name': 'Utilities', 'amount': 800000, 'percentage': 10},
    {'name': 'Commission', 'amount': 700000, 'percentage': 8},
    {'name': 'Others', 'amount': 1000000, 'percentage': 12},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.reports),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            NavigationService.pushReplacement(const DashboardPage());
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Summary Cards
            Text(
              'Financial Summary',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: _buildSummaryCard(
                      'This Month',
                      _reportData['currentMonth']['income'].toDouble(),
                      _reportData['currentMonth']['expense'].toDouble(),
                      _reportData['currentMonth']['profit'].toDouble(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: _buildSummaryCard(
                      'Last Month',
                      _reportData['lastMonth']['income'].toDouble(),
                      _reportData['lastMonth']['expense'].toDouble(),
                      _reportData['lastMonth']['profit'].toDouble(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _buildSummaryCard(
              'Year to Date',
              _reportData['yearToDate']['income'].toDouble(),
              _reportData['yearToDate']['expense'].toDouble(),
              _reportData['yearToDate']['profit'].toDouble(),
              isFullWidth: true,
            ),

            const SizedBox(height: 32),

            // Monthly Trend - Temporarily hidden
            /* 
            Text(
              'Monthly Trend (6 Months)',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                            'Income vs Expense',
                            style: TextStyle(fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildLegend('Income', AppColors.income),
                              const SizedBox(width: 8),
                              _buildLegend('Expense', AppColors.expense),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 250, // Increased height even more
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: _monthlyData.map((data) {
                            final maxAmount = _monthlyData
                                .map((e) => [e['income'], e['expense']])
                                .expand((e) => e)
                                .reduce((a, b) => a > b ? a : b)
                                .toDouble();

                            return Container(
                              width: 60, // Increased from 55 to 60
                              margin: const EdgeInsets.only(right: 16), // Increased margin back
                              child: Column(
                                children: [
                                  // Chart area with fixed height
                                  SizedBox(
                                    height: 170, // Reduced chart height slightly
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 22, // Increased bar width
                                          height: (data['income'] / maxAmount * 110), // Reduced max height
                                          decoration: BoxDecoration(
                                            color: AppColors.income,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Container(
                                          width: 22, // Increased bar width
                                          height: (data['expense'] / maxAmount * 110), // Reduced max height
                                          decoration: BoxDecoration(
                                            color: AppColors.expense,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16), // More space above label
                                  // Label area with more space
                                  Container(
                                    width: 60, // Same as container width
                                    height: 35, // Increased height for label
                                    alignment: Alignment.center,
                                    child: Text(
                                      data['month'],
                                      style: const TextStyle(
                                        fontSize: 12, // Increased font size slightly
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
            */

            // Quick Actions
            Text(
              'Generate Reports',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildReportCard(
                  'Profit & Loss',
                  Icons.trending_up,
                  AppColors.primary,
                  () {},
                ),
                _buildReportCard(
                  'Balance Sheet',
                  Icons.account_balance,
                  AppColors.secondary,
                  () {},
                ),
                _buildReportCard(
                  'Cash Flow',
                  Icons.account_balance_wallet,
                  AppColors.info,
                  () {},
                ),
                _buildReportCard(
                  'Income/Expense',
                  Icons.bar_chart,
                  AppColors.warning,
                  () {},
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Top Categories - moved to bottom
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Top Income Categories',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: _topCategories.map((category) {
                                return _buildCategoryItem(
                                  category['name'],
                                  category['amount'].toDouble(),
                                  category['percentage'],
                                  AppColors.income,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Top Expense Categories',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: _topExpenses.map((expense) {
                                return _buildCategoryItem(
                                  expense['name'],
                                  expense['amount'].toDouble(),
                                  expense['percentage'],
                                  AppColors.expense,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          // Navigate to respective pages
          switch (index) {
            case 0:
              NavigationService.pushReplacement(const DashboardPage());
              break;
            case 1:
              NavigationService.pushReplacement(const TransactionsPage());
              break;
            case 2:
              NavigationService.pushReplacement(const AccountsPage());
              break;
            case 3:
              // Already on reports
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
            icon: Icon(Icons.account_balance),
            label: AppStrings.accounts,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: AppStrings.reports,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    double income,
    double expense,
    double profit, {
    bool isFullWidth = false,
  }) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.1),
              AppColors.primary.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow('Income', income, AppColors.income),
            const SizedBox(height: 8),
            _buildSummaryRow('Expense', expense, AppColors.expense),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            _buildSummaryRow(
              'Profit',
              profit,
              profit >= 0 ? AppColors.income : AppColors.expense,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            _formatCurrency(amount),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  // Temporarily commented out for Monthly Trend
  /*
  Widget _buildLegend(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
  */

  Widget _buildCategoryItem(
    String name,
    double amount,
    int percentage,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '$percentage%',
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: percentage / 100,
                  backgroundColor: AppColors.border,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  _formatCurrency(amount),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (name != _topCategories.last['name'] &&
              name != _topExpenses.last['name'])
            const Divider(height: 24),
        ],
      ),
    );
  }

  Widget _buildReportCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.1),
                color.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatCurrency(double amount) {
    return 'Rp ${amount.abs().toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match.group(1)}.')}';
  }
}
