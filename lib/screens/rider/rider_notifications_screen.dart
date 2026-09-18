import 'package:flutter/material.dart';

import '../../theme/renon_colors.dart';

class RiderNotificationsScreen extends StatefulWidget {
  const RiderNotificationsScreen({super.key});

  @override
  State<RiderNotificationsScreen> createState() =>
      _RiderNotificationsScreenState();
}

class _RiderNotificationsScreenState
    extends State<RiderNotificationsScreen> {
  final List<_RiderNotification> _notifications = [
    _RiderNotification(
      title: 'New delivery available',
      message: 'A delivery request is available near your current area.',
      time: '8 min ago',
      icon: Icons.local_shipping_outlined,
      isUnread: true,
    ),
    _RiderNotification(
      title: 'Verification update',
      message: 'Your vehicle verification has been approved.',
      time: '1 hr ago',
      icon: Icons.verified_outlined,
      isUnread: true,
    ),
    _RiderNotification(
      title: 'Weekly earnings',
      message: 'You earned ₦48,500 this week. Keep going!',
      time: 'Yesterday',
      icon: Icons.account_balance_wallet_outlined,
      isUnread: false,
    ),
    _RiderNotification(
      title: 'Safety reminder',
      message: 'Remember to wear your helmet and confirm the delivery address.',
      time: 'Yesterday',
      icon: Icons.health_and_safety_outlined,
      isUnread: false,
    ),
    _RiderNotification(
      title: 'Welcome to RENON',
      message: 'Your rider account is ready. Go online whenever you’re ready.',
      time: '3 days ago',
      icon: Icons.waving_hand_outlined,
      isUnread: false,
    ),
  ];

  int get _unreadCount =>
      _notifications.where((notification) => notification.isUnread).length;

  void _markAllRead() {
    setState(() {
      for (final notification in _notifications) {
        notification.isUnread = false;
      }
    });
  }

  void _markRead(_RiderNotification notification) {
    if (!notification.isUnread) return;

    setState(() {
      notification.isUnread = false;
    });
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
          'Notifications',
          style: TextStyle(
            color: RenonColors.ink,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        actions: [
          if (_unreadCount > 0)
            TextButton(
              onPressed: _markAllRead,
              child: const Text(
                'Read all',
                style: TextStyle(
                  color: RenonColors.palm,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState()
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              children: [
                if (_unreadCount > 0) ...[
                  _buildUnreadHeader(),
                  const SizedBox(height: 12),
                ],
                ..._notifications.map(_buildNotificationCard),
              ],
            ),
    );
  }

  Widget _buildUnreadHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: RenonColors.lime.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.notifications_active_outlined,
            color: RenonColors.forest,
            size: 20,
          ),
          const SizedBox(width: 9),
          Text(
            '$_unreadCount unread notification${_unreadCount == 1 ? '' : 's'}',
            style: const TextStyle(
              color: RenonColors.forest,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(_RiderNotification notification) {
    return GestureDetector(
      onTap: () => _markRead(notification),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notification.isUnread
              ? RenonColors.paper
              : RenonColors.paper.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: notification.isUnread
                ? RenonColors.palm.withValues(alpha: 0.18)
                : RenonColors.line,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: RenonColors.smoke,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                notification.icon,
                color: RenonColors.forest,
                size: 22,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            color: RenonColors.ink,
                            fontSize: 14,
                            fontWeight: notification.isUnread
                                ? FontWeight.w900
                                : FontWeight.w700,
                          ),
                        ),
                      ),
                      if (notification.isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(top: 5),
                          decoration: const BoxDecoration(
                            color: RenonColors.palm,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    notification.message,
                    style: const TextStyle(
                      color: RenonColors.muted,
                      fontSize: 12.5,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notification.time,
                    style: const TextStyle(
                      color: RenonColors.softText,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: RenonColors.smoke,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                color: RenonColors.muted,
                size: 38,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'No notifications yet',
              style: TextStyle(
                color: RenonColors.ink,
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'We’ll let you know when there’s something important for you.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: RenonColors.muted,
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RiderNotification {
  _RiderNotification({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.isUnread,
  });

  final String title;
  final String message;
  final String time;
  final IconData icon;
  bool isUnread;
}