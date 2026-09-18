import 'package:flutter/material.dart';

import '../../theme/renon_colors.dart';

class RiderHelpSupportScreen extends StatelessWidget {
  const RiderHelpSupportScreen({super.key});

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
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
          'Help & Support',
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
          _buildHero(),
          const SizedBox(height: 24),
          _sectionLabel('How can we help?'),
          const SizedBox(height: 10),
          _helpCard(
            context,
            icon: Icons.local_shipping_outlined,
            title: 'Delivery issues',
            subtitle: 'Problems with an active or completed delivery.',
          ),
          _helpCard(
            context,
            icon: Icons.account_balance_wallet_outlined,
            title: 'Payments & earnings',
            subtitle: 'Questions about earnings, payouts or charges.',
          ),
          _helpCard(
            context,
            icon: Icons.verified_user_outlined,
            title: 'Account & verification',
            subtitle: 'Help with your rider account or documents.',
          ),
          _helpCard(
            context,
            icon: Icons.two_wheeler_outlined,
            title: 'Vehicle',
            subtitle: 'Vehicle information and verification support.',
          ),
          const SizedBox(height: 24),
          _sectionLabel('Quick help'),
          const SizedBox(height: 10),
          _buildFaqCard(context),
          const SizedBox(height: 24),
          _sectionLabel('Contact RENON'),
          const SizedBox(height: 10),
          _contactCard(
            context,
            icon: Icons.chat_bubble_outline_rounded,
            title: 'Chat with support',
            subtitle: 'Get help from the RENON support team.',
            onTap: () => _showMessage(
              context,
              'Support chat will be available soon.',
            ),
          ),
          const SizedBox(height: 10),
          _contactCard(
            context,
            icon: Icons.email_outlined,
            title: 'Email support',
            subtitle: 'Send us a message about your issue.',
            onTap: () => _showMessage(
              context,
              'Email support will be available soon.',
            ),
          ),
          const SizedBox(height: 24),
          _buildEmergencyNote(),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RenonColors.forest,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.support_agent_rounded,
            color: RenonColors.lime,
            size: 34,
          ),
          SizedBox(height: 16),
          Text(
            'We’ve got you.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'Find answers, report an issue or get help from the RENON support team.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String title) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(
        color: RenonColors.muted,
        fontSize: 11,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _helpCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: RenonColors.line),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: RenonColors.smoke,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: RenonColors.forest,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: RenonColors.ink,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: const TextStyle(
              color: RenonColors.muted,
              fontSize: 11.5,
            ),
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: RenonColors.softText,
        ),
        onTap: () {
          _showMessage(
            context,
            '$title support will be available soon.',
          );
        },
      ),
    );
  }

  Widget _buildFaqCard(BuildContext context) {
    final faqs = [
      (
        'How do I go online?',
        'Use the online toggle on your rider home screen.'
      ),
      (
        'Why am I not receiving deliveries?',
        'Make sure you are online, your location is enabled and your account is verified.'
      ),
      (
        'How are earnings calculated?',
        'Your earnings depend on the delivery and applicable RENON pricing.'
      ),
      (
        'Can I change my vehicle?',
        'Yes. Open Vehicle Information from your rider profile.'
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: RenonColors.line),
      ),
      child: Column(
        children: [
          for (var i = 0; i < faqs.length; i++) ...[
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 15),
              childrenPadding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              title: Text(
                faqs[i].$1,
                style: const TextStyle(
                  color: RenonColors.ink,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              iconColor: RenonColors.palm,
              collapsedIconColor: RenonColors.muted,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    faqs[i].$2,
                    style: const TextStyle(
                      color: RenonColors.muted,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            if (i != faqs.length - 1)
              const Divider(
                height: 1,
                color: RenonColors.line,
              ),
          ],
        ],
      ),
    );
  }

  Widget _contactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: RenonColors.paper,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: RenonColors.line),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: RenonColors.smoke,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: RenonColors.forest,
                ),
              ),
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

  Widget _buildEmergencyNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RenonColors.danger.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: RenonColors.danger.withValues(alpha: 0.14),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: RenonColors.danger,
            size: 22,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'For immediate emergencies or threats to your safety, contact the appropriate emergency service first. RENON support should not replace emergency services.',
              style: TextStyle(
                color: RenonColors.muted,
                fontSize: 11.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}