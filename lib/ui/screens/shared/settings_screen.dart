import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSettingsGroup(
            'General',
            [
              _buildSettingsTile(
                Icons.language,
                'Language',
                'English',
                () {},
              ),
              _buildSettingsTile(
                Icons.brightness_6,
                'Theme',
                'System Default',
                () {},
              ),
            ],
          ),
          _buildSettingsGroup(
            'Preferences',
            [
              _buildSettingsTile(
                Icons.notifications,
                'Push Notifications',
                'Enabled',
                () {},
              ),
              _buildSettingsTile(
                Icons.location_on,
                'Location Services',
                'Allowed',
                () {},
              ),
              _buildSettingsTile(
                Icons.data_usage,
                'Data Usage',
                'Wi-Fi Only',
                () {},
              ),
            ],
          ),
          _buildSettingsGroup(
            'Business',
            [
              _buildSettingsTile(
                Icons.business,
                'Business Profile',
                '',
                () {},
              ),
              _buildSettingsTile(
                Icons.payment,
                'Payment Settings',
                '',
                () {},
              ),
              _buildSettingsTile(
                Icons.receipt_long,
                'Invoice Preferences',
                '',
                () {},
              ),
            ],
          ),
          _buildSettingsGroup(
            'Support',
            [
              _buildSettingsTile(
                Icons.help,
                'Help Center',
                '',
                () {},
              ),
              _buildSettingsTile(
                Icons.feedback,
                'Send Feedback',
                '',
                () {},
              ),
              _buildSettingsTile(
                Icons.info,
                'About LiveSure OP',
                'Version 1.0.0',
                () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'LiveSure OP',
                    applicationVersion: '1.0.0',
                    applicationIcon: const Icon(Icons.water_drop, size: 48),
                    children: const [
                      Text('Complete ERP + Delivery Management System for 19L Water Plants'),
                      SizedBox(height: 8),
                      Text('© 2024 LiveSure Solutions'),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (subtitle.isNotEmpty) Text(subtitle),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
      onTap: onTap,
    );
  }
}
