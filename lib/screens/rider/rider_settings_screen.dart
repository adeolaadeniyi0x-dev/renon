import 'package:flutter/material.dart';

import '../../theme/renon_colors.dart';

class RiderSettingsScreen extends StatefulWidget {
  const RiderSettingsScreen({super.key});

  @override
  State<RiderSettingsScreen> createState() => _RiderSettingsScreenState();
}

class _RiderSettingsScreenState extends State<RiderSettingsScreen> {
  bool _deliveryAlerts = true;
  bool _earningsUpdates = true;
  bool _promotionalMessages = false;
  bool _soundEffects = true;
  bool _vibration = true;
  bool _locationWhileOnline = true;

  void _showSaved() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Settings updated.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: RenonColors.ink,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RenonColors.cream,
      appBar: AppBar(
        backgroundColor: RenonColors.cream,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
          ),
          color: RenonColors.ink,
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: RenonColors.ink,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        children: [
          _buildSectionLabel('Notifications'),
          _buildSettingsCard(
            children: [
              _buildSwitchTile(
                icon: Icons.local_shipping_outlined,
                title: 'Delivery alerts',
                subtitle: 'Get notified when new deliveries are available.',
                value: _deliveryAlerts,
                onChanged: (value) {
                  setState(() => _deliveryAlerts = value);
                  _showSaved();
                },
              ),
              _divider(),
              _buildSwitchTile(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Earnings updates',
                subtitle: 'Receive updates about your rider earnings.',
                value: _earningsUpdates,
                onChanged: (value) {
                  setState(() => _earningsUpdates = value);
                  _showSaved();
                },
              ),
              _divider(),
              _buildSwitchTile(
                icon: Icons.campaign_outlined,
                title: 'Promotional messages',
                subtitle: 'Receive offers, tips and RENON announcements.',
                value: _promotionalMessages,
                onChanged: (value) {
                  setState(() => _promotionalMessages = value);
                  _showSaved();
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSectionLabel('App experience'),
          _buildSettingsCard(
            children: [
              _buildSwitchTile(
                icon: Icons.volume_up_outlined,
                title: 'Sound effects',
                subtitle: 'Play sounds for important rider actions.',
                value: _soundEffects,
                onChanged: (value) {
                  setState(() => _soundEffects = value);
                  _showSaved();
                },
              ),
              _divider(),
              _buildSwitchTile(
                icon: Icons.vibration_outlined,
                title: 'Vibration',
                subtitle: 'Vibrate for delivery alerts and updates.',
                value: _vibration,
                onChanged: (value) {
                  setState(() => _vibration = value);
                  _showSaved();
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSectionLabel('Privacy & location'),
          _buildSettingsCard(
            children: [
              _buildSwitchTile(
                icon: Icons.location_on_outlined,
                title: 'Location while online',
                subtitle:
                    'Allow RENON to use your location while you are online.',
                value: _locationWhileOnline,
                onChanged: (value) {
                  setState(() => _locationWhileOnline = value);
                  _showSaved();
                },
              ),
              _divider(),
              _buildActionTile(
                icon: Icons.lock_outline_rounded,
                title: 'Privacy',
                subtitle: 'Manage how your account information is used.',
                onTap: () => _showComingSoon('Privacy settings'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSectionLabel('Account'),
          _buildSettingsCard(
            children: [
              _buildActionTile(
                icon: Icons.password_outlined,
                title: 'Change password',
                subtitle: 'Update your RENON account password.',
                onTap: () => _showComingSoon('Change password'),
              ),
              _divider(),
              _buildActionTile(
                icon: Icons.language_outlined,
                title: 'Language',
                subtitle: 'English',
                onTap: () => _showLanguagePicker(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildAppInfo(),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 2,
        bottom: 10,
      ),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          color: RenonColors.muted,
          fontSize: 11,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildSettingsCard({
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: RenonColors.line),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          _iconBox(icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: RenonColors.ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: RenonColors.muted,
                    fontSize: 11.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeTrackColor: RenonColors.palm,
            activeThumbColor: RenonColors.lime,
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              _iconBox(icon),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: RenonColors.ink,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: RenonColors.muted,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: RenonColors.softText,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconBox(IconData icon) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: RenonColors.smoke,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(
        icon,
        color: RenonColors.forest,
        size: 21,
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      height: 1,
      indent: 69,
      endIndent: 15,
      color: RenonColors.line,
    );
  }

  Widget _buildAppInfo() {
    return Column(
      children: [
        const Text(
          'RENON',
          style: TextStyle(
            color: RenonColors.forest,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Rider app • Version 1.0.0',
          style: TextStyle(
            color: RenonColors.softText,
            fontSize: 11.5,
          ),
        ),
      ],
    );
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$feature will be available soon.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _showLanguagePicker() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: RenonColors.cream,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Choose language',
                  style: TextStyle(
                    color: RenonColors.ink,
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(
                    Icons.language_rounded,
                    color: RenonColors.palm,
                  ),
                  title: const Text(
                    'English',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.check_circle_rounded,
                    color: RenonColors.palm,
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}