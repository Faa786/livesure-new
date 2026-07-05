import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/providers/order_provider.dart';
import '../../../data/providers/customer_provider.dart';
import '../../../ui/widgets/dashboard/stats_card.dart';

class OfficeDashboard extends StatefulWidget {
  const OfficeDashboard({Key? key}) : super(key: key);

  @override
  State<OfficeDashboard> createState() => _OfficeDashboardState();
}

class _OfficeDashboardState extends State<OfficeDashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().loadOrders();
      context.read<CustomerProvider>().loadCustomers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Office Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
          ),
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () => Navigator.pushNamed(context, '/qr-scanner'),
          ),
        ],
      ),
      body: Consumer2<OrderProvider, CustomerProvider>(
        builder: (context, orderProvider, customerProvider, child) {
          if (orderProvider.isLoading || customerProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                      title: 'Total Orders',
                      value: orderProvider.orders.length.toString(),
                      icon: Icons.shopping_cart,
                      color: Colors.blue,
                    ),
                    StatsCard(
                      title: 'Total Customers',
                      value: customerProvider.customers.length.toString(),
                      icon: Icons.people,
                      color: Colors.green,
                    ),
                    StatsCard(
                      title: 'Pending Orders',
                      value: orderProvider.orders.where((o) => o.status == 'pending').length.toString(),
                      icon: Icons.pending,
                      color: Colors.orange,
                    ),
                    StatsCard(
                      title: 'Today\'s Revenue',
                      value: 'Rs. ${_calculateTodayRevenue(orderProvider.orders)}',
                      icon: Icons.attach_money,
                      color: Colors.purple,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Recent Orders',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pushNamed(context, '/orders'),
                                child: const Text('View All'),
                              ),
                            ],
                          ),
                          const Divider(),
                          Expanded(
                            child: ListView.builder(
                              itemCount: orderProvider.orders.take(5).length,
                              itemBuilder: (context, index) {
                                final order = orderProvider.orders[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: _getStatusColor(order.status),
                                    child: Text(
                                      order.orderNumber.substring(order.orderNumber.length - 4),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  title: Text('Order ${order.orderNumber}'),
                                  subtitle: Text('${order.customer?.businessName ?? 'Customer'}'),
                                  trailing: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(order.status).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      order.status.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _getStatusColor(order.status),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/order-details',
                                      arguments: order.id,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create-order'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'processing':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _calculateTodayRevenue(List orders) {
    final today = DateTime.now();
    final todayOrders = orders.where((order) =>
      order.status == 'delivered' &&
      order.orderDate.day == today.day &&
      order.orderDate.month == today.month &&
      order.orderDate.year == today.year
    );
    final total = todayOrders.fold(0.0, (sum, order) => sum + order.totalAmount);
    return total.toStringAsFixed(0);
  }
}
