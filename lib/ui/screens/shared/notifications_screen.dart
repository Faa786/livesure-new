import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: () {
              // Mark all as read
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: index % 2 == 0 ? Colors.blue[100] : Colors.green[100],
                child: Icon(
                  index % 2 == 0 ? Icons.shopping_cart : Icons.payment,
                  color: index % 2 == 0 ? Colors.blue : Colors.green,
                ),
              ),
              title: Text(
                index % 2 == 0 ? 'New Order #ORD-2024-${1000 + index}' : 'Payment Received',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                index % 2 == 0 
                    ? 'Order placed by Customer ${index + 1}' 
                    : 'Rs. ${(index + 1) * 500} received from Customer ${index + 1}',
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (index < 3)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  Text(
                    '${index + 5} min ago',
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
              onTap: () {
                // Mark as read and navigate
              },
            ),
          );
        },
      ),
    );
  }
}
