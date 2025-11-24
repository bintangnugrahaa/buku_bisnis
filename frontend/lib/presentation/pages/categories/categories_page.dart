import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../../data/models/response/category_response_model.dart';
import '../../bloc/category/category_bloc.dart';
import '../../bloc/category/category_event.dart';
import '../../bloc/category/category_state.dart';
import '../accounts/accounts_page.dart';
import '../dashboard/dashboard_page.dart';
import '../transactions/transactions_page.dart';
import 'add_category_page.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedTypeFilter; // null = All, 'income', 'expense'
  int _selectedIndex = 2; // Categories is index 2

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    context.read<CategoryBloc>().add(
      CategoryLoadAll(type: _selectedTypeFilter),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CategoryOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          _loadCategories();
        } else if (state is CategoryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Categories'),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                NavigationService.pushReplacement(const DashboardPage());
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _loadCategories,
              ),
            ],
          ),
          body: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is CategoryError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: AppColors.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.message,
                        style: TextStyle(color: AppColors.error),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadCategories,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (state is CategoryLoaded) {
                // Apply search filter on frontend
                var categories = state.categories;
                if (_searchController.text.isNotEmpty) {
                  final searchLower = _searchController.text.toLowerCase();
                  categories = categories
                      .where((c) => c.name.toLowerCase().contains(searchLower))
                      .toList();
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    _loadCategories();
                  },
                  child: Column(
                    children: [
                      // Search and Filter Section
                      Container(
                        padding: const EdgeInsets.all(16),
                        color: Colors.white,
                        child: Column(
                          children: [
                            // Search bar
                            TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search categories...',
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon: _searchController.text.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          setState(() {
                                            _searchController.clear();
                                          });
                                          _loadCategories();
                                        },
                                      )
                                    : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                              onChanged: (value) {
                                // Debounce search
                                Future.delayed(
                                  const Duration(milliseconds: 500),
                                  () {
                                    if (_searchController.text == value) {
                                      _loadCategories();
                                    }
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 12),
                            // Filter row
                            Row(
                              children: [
                                const Text(
                                  'Type: ',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        FilterChip(
                                          label: const Text('All'),
                                          selected: _selectedTypeFilter == null,
                                          onSelected: (selected) {
                                            setState(() {
                                              _selectedTypeFilter = null;
                                            });
                                            _loadCategories();
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                        FilterChip(
                                          label: const Text('Income'),
                                          selected:
                                              _selectedTypeFilter == 'income',
                                          selectedColor: AppColors.income
                                              .withOpacity(0.2),
                                          onSelected: (selected) {
                                            setState(() {
                                              _selectedTypeFilter = selected
                                                  ? 'income'
                                                  : null;
                                            });
                                            _loadCategories();
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                        FilterChip(
                                          label: const Text('Expense'),
                                          selected:
                                              _selectedTypeFilter == 'expense',
                                          selectedColor: AppColors.expense
                                              .withOpacity(0.2),
                                          onSelected: (selected) {
                                            setState(() {
                                              _selectedTypeFilter = selected
                                                  ? 'expense'
                                                  : null;
                                            });
                                            _loadCategories();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Categories List
                      Expanded(
                        child: categories.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.category_outlined,
                                      size: 80,
                                      color: AppColors.textSecondary,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      _searchController.text.isNotEmpty ||
                                              _selectedTypeFilter != null
                                          ? 'No categories found'
                                          : 'No categories yet',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.textSecondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _searchController.text.isNotEmpty ||
                                              _selectedTypeFilter != null
                                          ? 'Try adjusting your search or filter'
                                          : 'Tap + button to add your first category',
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  final category = categories[index];
                                  final isIncome = category.type == 'income';

                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    elevation: 2,
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(16),
                                      leading: CircleAvatar(
                                        backgroundColor: isIncome
                                            ? AppColors.income
                                            : AppColors.expense,
                                        child: Icon(
                                          isIncome
                                              ? Icons.arrow_upward
                                              : Icons.arrow_downward,
                                          color: Colors.white,
                                        ),
                                      ),
                                      title: Text(
                                        category.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isIncome
                                                  ? AppColors.income
                                                        .withOpacity(0.1)
                                                  : AppColors.expense
                                                        .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              isIncome ? 'Income' : 'Expense',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: isIncome
                                                    ? AppColors.income
                                                    : AppColors.expense,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(
                                          Icons.delete_outline,
                                          color: AppColors.error,
                                        ),
                                        onPressed: () {
                                          _showDeleteConfirmation(
                                            context,
                                            category,
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                );
              }

              // Initial state
              return const Center(child: CircularProgressIndicator());
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
              switch (index) {
                case 0:
                  NavigationService.pushReplacement(const DashboardPage());
                  break;
                case 1:
                  NavigationService.pushReplacement(const TransactionsPage());
                  break;
                case 2:
                  // Already on categories
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
              NavigationService.push(const AddCategoryPage());
            },
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, CategoryModel category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Category'),
          content: Text('Are you sure you want to delete "${category.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<CategoryBloc>().add(
                  CategoryDelete(id: category.id),
                );
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );
  }
}
