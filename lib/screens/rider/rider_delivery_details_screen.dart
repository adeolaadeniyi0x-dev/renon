import 'package:flutter/material.dart';

import '../../theme/renon_colors.dart';
import 'rider_active_delivery_screen.dart';

class RiderDeliveryDetailsScreen extends StatefulWidget {
  const RiderDeliveryDetailsScreen({
    super.key,
    this.restaurant = 'Campus Bites',
    this.pickup = 'Student Union Building',
    this.dropoff = 'Block A, Campus Hostel',
    this.distance = '1.8 km',
    this.fee = '₦1,500',
    this.time = '12 min',
  });

  final String restaurant;
  final String pickup;
  final String dropoff;
  final String distance;
  final String fee;
  final String time;

  @override
  State<RiderDeliveryDetailsScreen> createState() =>
      _RiderDeliveryDetailsScreenState();
}

class _RiderDeliveryDetailsScreenState
    extends State<RiderDeliveryDetailsScreen> {
  bool _accepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RenonColors.cream,
      appBar: AppBar(
        backgroundColor: RenonColors.cream,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: RenonColors.ink,
          ),
        ),
        title: const Text(
          'Delivery details',
          style: TextStyle(
            color: RenonColors.ink,
            fontSize: 19,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Help',
            onPressed: _showHelp,
            icon: const Icon(
              Icons.help_outline_rounded,
              color: RenonColors.ink,
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 34),
          physics: const BouncingScrollPhysics(),
          children: [
            _buildOrderHeader(),
            const SizedBox(height: 16),
            _buildRouteCard(),
            const SizedBox(height: 16),
            _buildEarningsCard(),
            const SizedBox(height: 16),
            _buildCustomerCard(),
            const SizedBox(height: 16),
            _buildOrderInfo(),
            const SizedBox(height: 16),
            _buildPickupInstruction(),
            const SizedBox(height: 16),
            _buildSafetyCard(),
            const SizedBox(height: 24),
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHeader() {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: RenonColors.line,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: RenonColors.forest,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Icon(
                  Icons.storefront_rounded,
                  color: RenonColors.lime,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.restaurant,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: RenonColors.ink,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Delivery request',
                      style: TextStyle(
                        color: RenonColors.muted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              _StatusBadge(
                label: _accepted ? 'ACCEPTED' : 'NEW',
                color: _accepted
                    ? RenonColors.palm
                    : RenonColors.gold,
              ),
            ],
          ),
          const SizedBox(height: 17),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 11,
            ),
            decoration: BoxDecoration(
              color: RenonColors.smoke,
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.receipt_long_rounded,
                  color: RenonColors.forest,
                  size: 18,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Order #RN-20481',
                    style: TextStyle(
                      color: RenonColors.ink,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(
                  'Campus delivery',
                  style: TextStyle(
                    color: RenonColors.muted,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: RenonColors.line,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.route_rounded,
                color: RenonColors.forest,
                size: 21,
              ),
              SizedBox(width: 8),
              Text(
                'Delivery route',
                style: TextStyle(
                  color: RenonColors.ink,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _RoutePoint(
            icon: Icons.radio_button_checked_rounded,
            title: 'PICKUP',
            address: widget.pickup,
            color: RenonColors.palm,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 4,
              bottom: 4,
            ),
            child: Row(
              children: [
                Container(
                  width: 1,
                  height: 26,
                  color: RenonColors.line,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Collect order here',
                  style: TextStyle(
                    color: RenonColors.muted,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          _RoutePoint(
            icon: Icons.location_on_rounded,
            title: 'DROP-OFF',
            address: widget.dropoff,
            color: RenonColors.clay,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: RenonColors.smoke,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.route_rounded,
                  color: RenonColors.forest,
                  size: 20,
                ),
                const SizedBox(width: 9),
                Text(
                  widget.distance,
                  style: const TextStyle(
                    color: RenonColors.ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.schedule_rounded,
                  color: RenonColors.forest,
                  size: 20,
                ),
                const SizedBox(width: 7),
                Text(
                  widget.time,
                  style: const TextStyle(
                    color: RenonColors.ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RenonColors.forest,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 47,
                height: 47,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.payments_rounded,
                  color: RenonColors.lime,
                ),
              ),
              const SizedBox(width: 13),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your earnings',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Estimated delivery earnings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                widget.fee,
                style: const TextStyle(
                  color: RenonColors.lime,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.10),
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: Colors.white.withValues(alpha: 0.65),
                size: 16,
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  'Final earnings may change if the delivery is adjusted.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.65),
                    fontSize: 10,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: RenonColors.line,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Customer',
            style: TextStyle(
              color: RenonColors.ink,
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(
                  color: RenonColors.smoke,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: RenonColors.forest,
                ),
              ),
              const SizedBox(width: 11),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'David',
                      style: TextStyle(
                        color: RenonColors.ink,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Customer',
                      style: TextStyle(
                        color: RenonColors.muted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              _CircleAction(
                icon: Icons.phone_rounded,
                onTap: () => _showMessage(
                  'Calling customer...',
                ),
              ),
              const SizedBox(width: 9),
              _CircleAction(
                icon: Icons.chat_bubble_rounded,
                onTap: () => _showMessage(
                  'Opening customer chat...',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderInfo() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: RenonColors.line,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order information',
            style: TextStyle(
              color: RenonColors.ink,
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 16),
          const _InfoRow(
            title: 'Order number',
            value: '#RN-20481',
          ),
          const Divider(
            height: 24,
            color: RenonColors.line,
          ),
          _InfoRow(
            title: 'Estimated time',
            value: widget.time,
          ),
          const Divider(
            height: 24,
            color: RenonColors.line,
          ),
          _InfoRow(
            title: 'Distance',
            value: widget.distance,
          ),
          const Divider(
            height: 24,
            color: RenonColors.line,
          ),
          const _InfoRow(
            title: 'Payment',
            value: 'Prepaid',
          ),
        ],
      ),
    );
  }

  Widget _buildPickupInstruction() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: RenonColors.lime.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: RenonColors.lime.withValues(alpha: 0.55),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb_outline_rounded,
            color: RenonColors.forest,
            size: 21,
          ),
          SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Before pickup',
                  style: TextStyle(
                    color: RenonColors.forest,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Confirm the order number with the vendor before collecting the package.',
                  style: TextStyle(
                    color: RenonColors.forest,
                    fontSize: 11,
                    height: 1.45,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyCard() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: RenonColors.line,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: RenonColors.smoke,
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.shield_outlined,
              color: RenonColors.forest,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ride safely',
                  style: TextStyle(
                    color: RenonColors.ink,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Follow campus traffic rules and never use your phone while riding.',
                  style: TextStyle(
                    color: RenonColors.muted,
                    fontSize: 10,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return Column(
      children: [
        if (_accepted)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: RenonColors.lime.withValues(alpha: 0.30),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: RenonColors.forest,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Delivery accepted. Continue to your active delivery.',
                    style: TextStyle(
                      color: RenonColors.forest,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton.icon(
            onPressed: _accepted
                ? _openActiveDelivery
                : _confirmAccept,
            icon: Icon(
              _accepted
                  ? Icons.arrow_forward_rounded
                  : Icons.check_rounded,
              size: 20,
            ),
            label: Text(
              _accepted
                  ? 'Go to active delivery'
                  : 'Accept delivery',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: RenonColors.forest,
              foregroundColor: RenonColors.lime,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton(
            onPressed: _accepted
                ? null
                : _confirmDecline,
            style: OutlinedButton.styleFrom(
              foregroundColor: RenonColors.muted,
              disabledForegroundColor:
                  RenonColors.softText,
              side: const BorderSide(
                color: RenonColors.line,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Decline delivery',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _confirmAccept() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: RenonColors.paper,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: RenonColors.line,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    color: RenonColors.lime.withValues(
                      alpha: 0.25,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delivery_dining_rounded,
                    color: RenonColors.forest,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Accept this delivery?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: RenonColors.ink,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You’ll earn ${widget.fee} for this delivery.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: RenonColors.muted,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: RenonColors.muted,
                          side: const BorderSide(
                            color: RenonColors.line,
                          ),
                          minimumSize: const Size(
                            double.infinity,
                            50,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Not now',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          _acceptDelivery();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              RenonColors.forest,
                          foregroundColor:
                              RenonColors.lime,
                          elevation: 0,
                          minimumSize: const Size(
                            double.infinity,
                            50,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Accept',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmDecline() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: RenonColors.paper,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Decline delivery?',
            style: TextStyle(
              color: RenonColors.ink,
              fontWeight: FontWeight.w900,
            ),
          ),
          content: const Text(
            'This delivery will remain available for another rider.',
            style: TextStyle(
              color: RenonColors.muted,
              height: 1.45,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: RenonColors.muted,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: RenonColors.ink,
                foregroundColor: RenonColors.lime,
                elevation: 0,
              ),
              child: const Text(
                'Decline',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _acceptDelivery() {
    setState(() {
      _accepted = true;
    });

    _showMessage(
      'Delivery accepted successfully.',
      icon: Icons.check_circle_rounded,
    );
  }

  void _openActiveDelivery() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RiderActiveDeliveryScreen(
          restaurant: widget.restaurant,
          pickup: widget.pickup,
          dropoff: widget.dropoff,
          distance: widget.distance,
          fee: widget.fee,
          time: widget.time,
        ),
      ),
    );
  }

  void _showHelp() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: RenonColors.paper,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: RenonColors.line,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Need help?',
                  style: TextStyle(
                    color: RenonColors.ink,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'If something looks wrong with this delivery, contact RENON support before accepting it.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: RenonColors.muted,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 18),
                _HelpOption(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: 'Chat with support',
                  onTap: () {
                    Navigator.pop(context);
                    _showMessage('Opening support chat...');
                  },
                ),
                const SizedBox(height: 10),
                _HelpOption(
                  icon: Icons.report_problem_outlined,
                  title: 'Report a delivery issue',
                  onTap: () {
                    Navigator.pop(context);
                    _showMessage(
                      'Delivery issue reporting coming soon.',
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showMessage(
    String message, {
    IconData icon = Icons.info_outline_rounded,
  }) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                icon,
                color: RenonColors.lime,
                size: 19,
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: RenonColors.forest,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _RoutePoint extends StatelessWidget {
  const _RoutePoint({
    required this.icon,
    required this.title,
    required this.address,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String address;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: color,
          size: 21,
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                address,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: RenonColors.ink,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CircleAction extends StatelessWidget {
  const _CircleAction({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: RenonColors.smoke,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            icon,
            color: RenonColors.forest,
            size: 19,
          ),
        ),
      ),
    );
  }
}

class _HelpOption extends StatelessWidget {
  const _HelpOption({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: RenonColors.smoke,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: RenonColors.forest,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: RenonColors.lime,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: RenonColors.ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: RenonColors.muted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: RenonColors.muted,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: RenonColors.ink,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}