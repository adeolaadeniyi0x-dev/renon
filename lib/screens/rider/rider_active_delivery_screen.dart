
import 'package:flutter/material.dart';

import '../../theme/renon_colors.dart';

class RiderActiveDeliveryScreen extends StatefulWidget {
  const RiderActiveDeliveryScreen({
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
  State<RiderActiveDeliveryScreen> createState() =>
      _RiderActiveDeliveryScreenState();
}

class _RiderActiveDeliveryScreenState
    extends State<RiderActiveDeliveryScreen> {
  int _step = 0;
  bool _isProcessing = false;

  final List<String> _steps = [
    'Heading to pickup',
    'Arrived at pickup',
    'Order picked up',
    'Heading to customer',
    'Delivery completed',
  ];

  String get _actionText {
    switch (_step) {
      case 0:
        return 'I’ve arrived at pickup';
      case 1:
        return 'Confirm pickup';
      case 2:
        return 'Start delivery';
      case 3:
        return 'Mark as delivered';
      default:
        return 'Back to deliveries';
    }
  }

  String get _instructionText {
    switch (_step) {
      case 0:
        return 'Head to the pickup location and let the vendor know you’re here.';
      case 1:
        return 'Check the order before leaving the pickup location.';
      case 2:
        return 'You have the order. Start your journey to the customer.';
      case 3:
        return 'Hand the order to the customer and confirm delivery.';
      default:
        return 'This delivery has been completed successfully.';
    }
  }

  IconData get _stepIcon {
    switch (_step) {
      case 0:
        return Icons.navigation_rounded;
      case 1:
        return Icons.storefront_rounded;
      case 2:
        return Icons.inventory_2_rounded;
      case 3:
        return Icons.location_on_rounded;
      default:
        return Icons.check_circle_rounded;
    }
  }

  void _handleAction() {
    if (_isProcessing) return;

    if (_step == 4) {
      Navigator.pop(context);
      return;
    }

    _showConfirmation();
  }

  Future<void> _showConfirmation() async {
    final bool confirmed = await showModalBottomSheet<bool>(
          context: context,
          backgroundColor: RenonColors.paper,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          builder: (context) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 14, 22, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 42,
                        height: 4,
                        decoration: BoxDecoration(
                          color: RenonColors.line,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: RenonColors.smoke,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _stepIcon,
                        color: RenonColors.forest,
                        size: 25,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _confirmationTitle,
                      style: const TextStyle(
                        color: RenonColors.ink,
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _confirmationDescription,
                      style: const TextStyle(
                        color: RenonColors.muted,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: RenonColors.ink,
                                side: const BorderSide(
                                  color: RenonColors.line,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text(
                                'Not yet',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: RenonColors.forest,
                                foregroundColor: RenonColors.paper,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text(
                                'Confirm',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
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
        ) ??
        false;

    if (!confirmed || !mounted) return;

    setState(() {
      _isProcessing = true;
    });

    await Future<void>.delayed(
      const Duration(milliseconds: 450),
    );

    if (!mounted) return;

    setState(() {
      _step++;
      _isProcessing = false;
    });

    _showMessage(_successMessage);
  }

  String get _confirmationTitle {
    switch (_step) {
      case 0:
        return 'You’ve arrived?';
      case 1:
        return 'Confirm pickup';
      case 2:
        return 'Start delivery?';
      case 3:
        return 'Complete delivery?';
      default:
        return 'Delivery complete';
    }
  }

  String get _confirmationDescription {
    switch (_step) {
      case 0:
        return 'Only confirm this when you are physically at the pickup location.';
      case 1:
        return 'Make sure you have received the correct order from the vendor.';
      case 2:
        return 'Confirm that the order is with you and you are ready to head to the customer.';
      case 3:
        return 'Confirm that the customer has received the order before completing this delivery.';
      default:
        return 'This delivery has already been completed.';
    }
  }

  String get _successMessage {
    switch (_step) {
      case 1:
        return 'Marked as arrived at pickup.';
      case 2:
        return 'Order picked up successfully.';
      case 3:
        return 'Delivery started.';
      case 4:
        return 'Delivery completed successfully.';
      default:
        return 'Updated successfully.';
    }
  }

  void _openNavigation(String destination) {
    _showMessage('Opening navigation to $destination...');
  }

  void _showHelpSheet() {
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
            padding: const EdgeInsets.fromLTRB(22, 14, 22, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: RenonColors.line,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Need help?',
                  style: TextStyle(
                    color: RenonColors.ink,
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Get assistance with this delivery or report a problem.',
                  style: TextStyle(
                    color: RenonColors.muted,
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 20),
                _HelpOption(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: 'Chat with support',
                  subtitle: 'Talk to the RENON support team',
                  onTap: () {
                    Navigator.pop(context);
                    _showMessage('Opening support chat...');
                  },
                ),
                const SizedBox(height: 10),
                _HelpOption(
                  icon: Icons.report_problem_outlined,
                  title: 'Report a delivery issue',
                  subtitle: 'Something is wrong with this order',
                  onTap: () {
                    Navigator.pop(context);
                    _showMessage('Delivery issue report opened.');
                  },
                ),
                const SizedBox(height: 10),
                _HelpOption(
                  icon: Icons.shield_outlined,
                  title: 'Safety assistance',
                  subtitle: 'Get help with a safety concern',
                  onTap: () {
                    Navigator.pop(context);
                    _showMessage('Safety assistance selected.');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool completed = _step == 4;

    return Scaffold(
      backgroundColor: RenonColors.cream,
      appBar: AppBar(
        backgroundColor: RenonColors.cream,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: RenonColors.ink,
          ),
        ),
        title: const Text(
          'Active delivery',
          style: TextStyle(
            color: RenonColors.ink,
            fontSize: 19,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showHelpSheet,
            tooltip: 'Help',
            icon: const Icon(
              Icons.help_outline_rounded,
              color: RenonColors.ink,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            _buildStatusCard(completed),
            const SizedBox(height: 16),
            _buildRouteCard(),
            const SizedBox(height: 16),
            _buildCustomerCard(),
            const SizedBox(height: 16),
            _buildOrderCard(),
            const SizedBox(height: 16),
            _buildSafetyCard(),
            const SizedBox(height: 24),
            _buildActionSection(completed),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(bool completed) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: completed ? RenonColors.forest : RenonColors.paper,
        borderRadius: BorderRadius.circular(22),
        border: completed
            ? null
            : Border.all(
                color: RenonColors.line,
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: completed
                      ? RenonColors.lime
                      : RenonColors.smoke,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  completed ? Icons.check_rounded : _stepIcon,
                  color: RenonColors.forest,
                  size: 26,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      completed ? 'Delivery completed' : _steps[_step],
                      style: TextStyle(
                        color: completed
                            ? RenonColors.paper
                            : RenonColors.ink,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      completed
                          ? 'Great job! Your delivery is complete.'
                          : 'Order from ${widget.restaurant}',
                      style: TextStyle(
                        color: completed
                            ? RenonColors.paper.withValues(alpha: 0.72)
                            : RenonColors.muted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (completed)
            _buildCompletedSummary()
          else
            _buildProgress(),
        ],
      ),
    );
  }

  Widget _buildCompletedSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: RenonColors.lime.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.payments_rounded,
            color: RenonColors.lime,
            size: 21,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '${widget.fee} earned from this delivery',
              style: const TextStyle(
                color: RenonColors.paper,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(
            4,
            (index) {
              final bool active = index <= _step;

              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    right: index == 3 ? 0 : 5,
                  ),
                  height: 6,
                  decoration: BoxDecoration(
                    color: active
                        ? RenonColors.lime
                        : RenonColors.line,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 9),
        Text(
          '${_step + 1} of 5 steps',
          style: const TextStyle(
            color: RenonColors.muted,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildRouteCard() {
    return _SectionCard(
      title: 'Delivery route',
      icon: Icons.route_rounded,
      child: Column(
        children: [
          _RoutePoint(
            icon: Icons.radio_button_checked_rounded,
            title: 'PICKUP',
            address: widget.pickup,
            color: RenonColors.palm,
            isActive: _step <= 1,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 4,
              bottom: 4,
            ),
            child: Container(
              width: 2,
              height: 32,
              color: RenonColors.line,
            ),
          ),
          _RoutePoint(
            icon: Icons.location_on_rounded,
            title: 'DROP-OFF',
            address: widget.dropoff,
            color: RenonColors.clay,
            isActive: _step >= 2,
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _RouteMetric(
                icon: Icons.route_rounded,
                value: widget.distance,
                label: 'Distance',
              ),
              const SizedBox(width: 10),
              _RouteMetric(
                icon: Icons.schedule_rounded,
                value: widget.time,
                label: 'Est. time',
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: OutlinedButton.icon(
              onPressed: () {
                final destination =
                    _step < 2 ? widget.pickup : widget.dropoff;

                _openNavigation(destination);
              },
              icon: const Icon(
                Icons.navigation_rounded,
                size: 18,
              ),
              label: Text(
                _step < 2
                    ? 'Navigate to pickup'
                    : 'Navigate to customer',
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: RenonColors.forest,
                side: const BorderSide(
                  color: RenonColors.line,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard() {
    return _SectionCard(
      title: 'Customer',
      icon: Icons.person_outline_rounded,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
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
                SizedBox(height: 4),
                Text(
                  'Block A, Campus Hostel',
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
            onTap: () {
              _showMessage('Calling David...');
            },
          ),
          const SizedBox(width: 8),
          _CircleAction(
            icon: Icons.chat_bubble_rounded,
            onTap: () {
              _showMessage('Opening chat...');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard() {
    return _SectionCard(
      title: 'Order information',
      icon: Icons.receipt_long_outlined,
      child: Column(
        children: [
          _InfoRow(
            title: 'Restaurant',
            value: widget.restaurant,
          ),
          const Divider(
            height: 24,
            color: RenonColors.line,
          ),
          _InfoRow(
            title: 'Order number',
            value: '#RN-20481',
          ),
          const Divider(
            height: 24,
            color: RenonColors.line,
          ),
          _InfoRow(
            title: 'Payment',
            value: 'Prepaid',
          ),
          const Divider(
            height: 24,
            color: RenonColors.line,
          ),
          _InfoRow(
            title: 'Delivery fee',
            value: widget.fee,
            valueColor: RenonColors.forest,
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RenonColors.smoke,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: RenonColors.line,
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.shield_outlined,
            color: RenonColors.forest,
            size: 21,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stay safe',
                  style: TextStyle(
                    color: RenonColors.ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Follow your route, keep the order secure, and only mark the delivery complete after the customer receives it.',
                  style: TextStyle(
                    color: RenonColors.muted,
                    fontSize: 11,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection(bool completed) {
    return Column(
      children: [
        if (!completed)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: RenonColors.paper,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: RenonColors.line,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: RenonColors.smoke,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _stepIcon,
                    color: RenonColors.forest,
                    size: 17,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _steps[_step],
                        style: const TextStyle(
                          color: RenonColors.ink,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _instructionText,
                        style: const TextStyle(
                          color: RenonColors.muted,
                          fontSize: 11,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _isProcessing ? null : _handleAction,
            style: ElevatedButton.styleFrom(
              backgroundColor: RenonColors.forest,
              disabledBackgroundColor:
                  RenonColors.forest.withValues(alpha: 0.55),
              foregroundColor: RenonColors.paper,
              disabledForegroundColor:
                  RenonColors.paper.withValues(alpha: 0.7),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
            ),
            child: _isProcessing
                ? const SizedBox(
                    width: 21,
                    height: 21,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        RenonColors.paper,
                      ),
                    ),
                  )
                : Text(
                    _actionText,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
          ),
        ),
        if (completed) ...[
          const SizedBox(height: 10),
          Text(
            'You earned ${widget.fee} from this delivery',
            style: const TextStyle(
              color: RenonColors.forest,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ],
    );
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
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
          Row(
            children: [
              Icon(
                icon,
                color: RenonColors.forest,
                size: 19,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: RenonColors.ink,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
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
    required this.isActive,
  });

  final IconData icon;
  final String title;
  final String address;
  final Color color;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: isActive ? color : RenonColors.muted,
          size: 21,
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isActive ? color : RenonColors.muted,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                address,
                style: const TextStyle(
                  color: RenonColors.ink,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RouteMetric extends StatelessWidget {
  const _RouteMetric({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: RenonColors.smoke,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: RenonColors.forest,
              size: 18,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: RenonColors.ink,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    style: const TextStyle(
                      color: RenonColors.muted,
                      fontSize: 9,
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: RenonColors.smoke,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: RenonColors.forest,
          size: 19,
        ),
      ),
    );
  }
}

class _HelpOption extends StatelessWidget {
  const _HelpOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: RenonColors.smoke,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: RenonColors.paper,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: RenonColors.forest,
                size: 20,
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
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: RenonColors.muted,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: RenonColors.muted,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.title,
    required this.value,
    this.valueColor = RenonColors.ink,
  });

  final String title;
  final String value;
  final Color valueColor;

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
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: valueColor,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

