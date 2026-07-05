import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/providers/dashboard_provider.dart';
import '../../../ui/widgets/dashboard/stats_card.dart';

class OwnerDashboard extends StatefulWidget {
  const OwnerDashboard({Key? key}) : super(key: key);

  @override
  State<OwnerDashboard> createState() => _OwnerDashboardState();
}

class _OwnerDashboardState extends State<OwnerDashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().loadOwnerDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Owner Dashboard'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColorDark,
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  Navigator.pushNamed(context, '/notifications');
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Consumer<DashboardProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final stats = provider.stats;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          children: [
                            StatsCard(
                              title: 'Today\'s Revenue',
                              value: 'Rs. ${stats['todayRevenue']?.toStringAsFixed(0) ?? '0'}',
                              icon: Icons.trending_up,
                              color: Colors.green,
                              percentage: '+12%',
                            ),
                            StatsCard(
                              title: 'Total Orders',
                              value: stats['totalOrders']?.toString() ?? '0',
                              icon: Icons.shopping_cart,
                              color: Colors.blue,
                              percentage: '+8%',
                            ),
                            StatsCard(
                              title: 'Active Customers',
                              value: stats['activeCustomers']?.toString() ?? '0',
                              icon: Icons.people,
                              color: Colors.purple,
                              percentage: '+5%',
                            ),
                            StatsCard(
                              title: 'Pending Deliveries',
                              value: stats['pendingDeliveries']?.toString() ?? '0',
                              icon: Icons.delivery_dining,
                              color: Colors.orange,
                              percentage: '-3%',
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Quick Actions',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    _buildQuickAction(
                                      'New Order',
                                      Icons.add_shopping_cart,
                                      Colors.blue,
                                      () => Navigator.pushNamed(context, '/create-order'),
                                    ),
                                    _buildQuickAction(
                                      'Add Customer',
                                      Icons.person_add,
                                      Colors.green,
                                      () => Navigator.pushNamed(context, '/customers'),
                                    ),
                                    _buildQuickAction(
                                      'View Reports',
                                      Icons.assessment,
                                      Colors.orange,
                                      () => Navigator.pushNamed(context, '/reports'),
                                    ),
                                    _buildQuickAction(
                                      'Manage Riders',
                                      Icons.delivery_dining,
                                      Colors.purple,
                                      () => Navigator.pushNamed(context, '/riders'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Recent Activities',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ...provider.recentActivities.map((activity) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.blue[50],
                                      child: Icon(
                                        activity['type'] == 'order' ? Icons.shopping_cart :
                                        activity['type'] == 'payment' ? Icons.payment :
                                        activity['type'] == 'rider' ? Icons.person :
                                        Icons.delivery_dining,
                                        size: 20,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    title: Text(activity['title'] ?? ''),
                                    subtitle: Text(activity['time'] ?? ''),
                                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                                    onTap: () {},
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    );
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const QuickActionsSheet(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Quick Action'),
      ),
    );
  }

  Widget _buildQuickAction(String title, IconData icon, Color color, VoidCallback onTap) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 56) / 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 10,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuickActionsSheet extends StatelessWidget {
  const QuickActionsSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildActionTile('New Order', Icons.add_shopping_cart, Colors.blue, () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/create-order');
              }),
              _buildActionTile('Add Customer', Icons.person_add, Colors.green, () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/customers');
              }),
              _buildActionTile('Add Rider', Icons.delivery_dining, Colors.orange, () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/riders');
              }),
              _buildActionTile('Bottle Tracking', Icons.qr_code, Colors.purple, () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/bottles');
              }),
              _buildActionTile('Expense', Icons.money_off, Colors.red, () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/expenses');
              }),
              _buildActionTile('Attendance', Icons.fingerprint, Colors.teal, () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/attendance');
              }),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildActionTile(String title, IconData icon, Color color, VoidCallback onTap) {
    return SizedBox(
      width: 100,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
