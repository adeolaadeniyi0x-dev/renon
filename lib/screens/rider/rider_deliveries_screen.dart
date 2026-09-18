import 'package:flutter/material.dart';

import '../../services/rider_earnings_service.dart';
import '../../theme/renon_colors.dart';
import 'rider_delivery_details_screen.dart';

class RiderDeliveriesScreen extends StatefulWidget {
  const RiderDeliveriesScreen({super.key});

  @override
  State<RiderDeliveriesScreen> createState() =>
      _RiderDeliveriesScreenState();
}

class _RiderDeliveriesScreenState extends State<RiderDeliveriesScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  DeliverySort _sort = DeliverySort.nearest;

  final List<_DeliveryData> _available = [
    _DeliveryData(
      id: 'DEL-001',
      restaurant: 'Campus Bites',
      pickup: 'Student Union Building',
      dropoff: 'Block A, Campus Hostel',
      distance: '1.8 km',
      amount: '₦1,500',
      time: '12 min',
      status: DeliveryStatus.available,
      icon: Icons.fastfood_rounded,
      customer: 'David',
      orderItems: 'Jollof Rice, Chicken & Coke',
      pickupNote: 'Ask for order #CB2841 at the counter.',
    ),
    _DeliveryData(
      id: 'DEL-002',
      restaurant: 'Chop & Go',
      pickup: 'Main Cafeteria',
      dropoff: 'Block C, New Hostel',
      distance: '2.4 km',
      amount: '₦1,800',
      time: '15 min',
      status: DeliveryStatus.available,
      icon: Icons.restaurant_rounded,
      customer: 'Michael',
      orderItems: 'Fried Rice, Turkey & Water',
      pickupNote: 'Order is being prepared.',
    ),
    _DeliveryData(
      id: 'DEL-003',
      restaurant: 'Mamas Kitchen',
      pickup: 'University Road',
      dropoff: 'Staff Quarters',
      distance: '3.1 km',
      amount: '₦2,200',
      time: '19 min',
      status: DeliveryStatus.available,
      icon: Icons.ramen_dining_rounded,
      customer: 'Blessing',
      orderItems: 'Pounded Yam & Egusi Soup',
      pickupNote: 'Tell the vendor the RENON order number.',
    ),
    _DeliveryData(
      id: 'DEL-004',
      restaurant: 'The Pizza Spot',
      pickup: 'Commercial Area',
      dropoff: 'Block D, Campus Hostel',
      distance: '2.0 km',
      amount: '₦1,650',
      time: '14 min',
      status: DeliveryStatus.available,
      icon: Icons.local_pizza_rounded,
      customer: 'Daniel',
      orderItems: 'Chicken Pizza & 2 Soft Drinks',
      pickupNote: 'Keep the pizza upright during transport.',
    ),
  ];

  final List<_DeliveryData> _active = [
    _DeliveryData(
      id: 'DEL-005',
      restaurant: 'Campus Bites',
      pickup: 'Student Union Building',
      dropoff: 'Block B, Campus Hostel',
      distance: '1.5 km',
      amount: '₦1,400',
      time: '10 min',
      status: DeliveryStatus.pickedUp,
      icon: Icons.fastfood_rounded,
      customer: 'Samuel',
      orderItems: 'Burger, Fries & Drink',
      pickupNote: 'Customer requested careful handling.',
    ),
  ];

  final List<_DeliveryData> _completed = [
    _DeliveryData(
      id: 'DEL-006',
      restaurant: 'Chop & Go',
      pickup: 'Main Cafeteria',
      dropoff: 'Block A, Campus Hostel',
      distance: '2.2 km',
      amount: '₦1,700',
      time: '16 min',
      status: DeliveryStatus.completed,
      icon: Icons.restaurant_rounded,
      customer: 'Tolu',
      orderItems: 'Rice & Chicken',
      pickupNote: '',
    ),
    _DeliveryData(
      id: 'DEL-007',
      restaurant: 'Mamas Kitchen',
      pickup: 'University Road',
      dropoff: 'Block C, New Hostel',
      distance: '2.8 km',
      amount: '₦2,000',
      time: '18 min',
      status: DeliveryStatus.completed,
      icon: Icons.ramen_dining_rounded,
      customer: 'Joshua',
      orderItems: 'Egusi Soup & Semo',
      pickupNote: '',
    ),
    _DeliveryData(
      id: 'DEL-008',
      restaurant: 'The Pizza Spot',
      pickup: 'Commercial Area',
      dropoff: 'Block D, Campus Hostel',
      distance: '1.9 km',
      amount: '₦1,600',
      time: '13 min',
      status: DeliveryStatus.completed,
      icon: Icons.local_pizza_rounded,
      customer: 'Esther',
      orderItems: 'Pepperoni Pizza',
      pickupNote: '',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int availableCount = _available.length;
    final int activeCount = _active.length;

    return Scaffold(
      backgroundColor: RenonColors.cream,
      appBar: AppBar(
        backgroundColor: RenonColors.cream,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Deliveries',
          style: TextStyle(
            color: RenonColors.ink,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _refreshDeliveries,
            icon: const Icon(
              Icons.refresh_rounded,
              color: RenonColors.ink,
            ),
          ),
          IconButton(
            tooltip: 'Filter',
            onPressed: _showFilterSheet,
            icon: const Icon(
              Icons.tune_rounded,
              color: RenonColors.ink,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildSummary(
            availableCount: availableCount,
            activeCount: activeCount,
          ),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDeliveryList(
                  deliveries: _sortedDeliveries(_available),
                  emptyTitle: 'No available deliveries',
                  emptyMessage:
                      'New delivery requests will appear here when customers place orders.',
                  emptyIcon: Icons.near_me_rounded,
                ),
                _buildDeliveryList(
                  deliveries: _active,
                  emptyTitle: 'No active deliveries',
                  emptyMessage:
                      'Accept a delivery and it will appear here until you complete it.',
                  emptyIcon: Icons.delivery_dining_rounded,
                ),
                _buildDeliveryList(
                  deliveries: _completed,
                  emptyTitle: 'No completed deliveries',
                  emptyMessage:
                      'Your completed deliveries and earnings will appear here.',
                  emptyIcon: Icons.check_circle_outline_rounded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary({
    required int availableCount,
    required int activeCount,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: RenonColors.forest,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Expanded(
              child: _SummaryItem(
                icon: Icons.near_me_rounded,
                value: '$availableCount',
                label: 'Available',
              ),
            ),
            Container(
              width: 1,
              height: 38,
              color: RenonColors.paper.withValues(alpha: 0.16),
            ),
            Expanded(
              child: _SummaryItem(
                icon: Icons.delivery_dining_rounded,
                value: '$activeCount',
                label: 'Active',
              ),
            ),
            Container(
              width: 1,
              height: 38,
              color: RenonColors.paper.withValues(alpha: 0.16),
            ),
            Expanded(
              child: _SummaryItem(
                icon: Icons.payments_rounded,
                value: _completedEarnings,
                label: 'Earned',
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _completedEarnings {
    int total = 0;

    for (final delivery in _completed) {
      total += _parseAmount(delivery.amount);
    }

    if (total >= 1000000) {
      return '₦${(total / 1000000).toStringAsFixed(1)}m';
    }

    if (total >= 1000) {
      return '₦${(total / 1000).toStringAsFixed(
        total % 1000 == 0 ? 0 : 1,
      )}k';
    }

    return '₦$total';
  }

  int _parseAmount(String amount) {
    return int.tryParse(
          amount.replaceAll('₦', '').replaceAll(',', '').trim(),
        ) ??
        0;
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: RenonColors.line,
        ),
      ),
      child: TabBar(
        controller: _tabController,
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: RenonColors.forest,
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: RenonColors.lime,
        unselectedLabelColor: RenonColors.muted,
        labelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        tabs: const [
          Tab(text: 'Available'),
          Tab(text: 'Active'),
          Tab(text: 'Completed'),
        ],
      ),
    );
  }

  Widget _buildDeliveryList({
    required List<_DeliveryData> deliveries,
    required String emptyTitle,
    required String emptyMessage,
    required IconData emptyIcon,
  }) {
    if (deliveries.isEmpty) {
      return _buildEmptyState(
        title: emptyTitle,
        message: emptyMessage,
        icon: emptyIcon,
      );
    }

    return RefreshIndicator(
      color: RenonColors.forest,
      backgroundColor: RenonColors.paper,
      onRefresh: _refreshDeliveries,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        itemCount: deliveries.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 14);
        },
        itemBuilder: (context, index) {
          final delivery = deliveries[index];

          return _DeliveryCard(
            delivery: delivery,
            onTap: () => _showDeliveryDetails(delivery),
            onAccept: delivery.status == DeliveryStatus.available
                ? () => _acceptDelivery(delivery)
                : null,
            onPickup: delivery.status == DeliveryStatus.accepted
                ? () => _markPickedUp(delivery)
                : null,
            onComplete: delivery.status == DeliveryStatus.pickedUp
                ? () => _completeDelivery(delivery)
                : null,
          );
        },
      ),
    );
  }

  Widget _buildEmptyState({
    required String title,
    required String message,
    required IconData icon,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: const BoxDecoration(
                color: RenonColors.smoke,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: RenonColors.forest,
                size: 34,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: RenonColors.ink,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: RenonColors.muted,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<_DeliveryData> _sortedDeliveries(
    List<_DeliveryData> deliveries,
  ) {
    final sorted = [...deliveries];

    switch (_sort) {
      case DeliverySort.nearest:
        sorted.sort(
          (a, b) => _distanceValue(a.distance)
              .compareTo(_distanceValue(b.distance)),
        );
        break;

      case DeliverySort.highestEarning:
        sorted.sort(
          (a, b) => _parseAmount(b.amount).compareTo(
            _parseAmount(a.amount),
          ),
        );
        break;

      case DeliverySort.fastest:
        sorted.sort(
          (a, b) => _timeValue(a.time).compareTo(
            _timeValue(b.time),
          ),
        );
        break;
    }

    return sorted;
  }

  double _distanceValue(String distance) {
    return double.tryParse(
          distance.replaceAll('km', '').trim(),
        ) ??
        0;
  }

  int _timeValue(String time) {
    return int.tryParse(
          time.replaceAll('min', '').trim(),
        ) ??
        0;
  }

  Future<void> _refreshDeliveries() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 650),
    );

    if (!mounted) return;

    setState(() {});

    _showMessage(
      'Deliveries refreshed.',
      icon: Icons.refresh_rounded,
    );
  }

  void _acceptDelivery(_DeliveryData delivery) {
    setState(() {
      delivery.status = DeliveryStatus.accepted;
      _available.remove(delivery);
      _active.insert(0, delivery);
    });

    _showMessage(
      'Delivery accepted.',
      icon: Icons.check_circle_rounded,
    );

    _tabController.animateTo(1);
  }

  void _markPickedUp(_DeliveryData delivery) {
    setState(() {
      delivery.status = DeliveryStatus.pickedUp;
    });

    _showMessage(
      'Pickup confirmed. Head to the customer.',
      icon: Icons.inventory_2_rounded,
    );
  }

  void _completeDelivery(_DeliveryData delivery) {
    final double amount = _parseAmount(
      delivery.amount,
    ).toDouble();

    RiderEarningsService.instance.recordCompletedDelivery(
      restaurant: delivery.restaurant,
      orderId: '#RN-${delivery.id.substring(4)}',
      amount: amount,
      time: _currentTime(),
      date: 'Today',
      icon: delivery.icon,
    );

    setState(() {
      delivery.status = DeliveryStatus.completed;
      _active.remove(delivery);
      _completed.insert(0, delivery);
    });

    _showMessage(
      '${delivery.amount} added to your earnings.',
      icon: Icons.payments_rounded,
    );

    _tabController.animateTo(2);
  }

  String _currentTime() {
    final now = TimeOfDay.now();

    final int hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final String minute = now.minute.toString().padLeft(2, '0');
    final String period = now.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  void _showDeliveryDetails(_DeliveryData delivery) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RiderDeliveryDetailsScreen(
          restaurant: delivery.restaurant,
          pickup: delivery.pickup,
          dropoff: delivery.dropoff,
          distance: delivery.distance,
          fee: delivery.amount,
          time: delivery.time,
        ),
      ),
    );
  }

  void _showMessage(
    String message, {
    IconData icon = Icons.info_outline_rounded,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: RenonColors.forest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          content: Row(
            children: [
              Icon(
                icon,
                color: RenonColors.lime,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: RenonColors.paper,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  void _showFilterSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: RenonColors.paper,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Sort deliveries',
                  style: TextStyle(
                    color: RenonColors.ink,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Choose how available requests should be arranged.',
                  style: TextStyle(
                    color: RenonColors.muted,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 18),
                _FilterOption(
                  icon: Icons.near_me_rounded,
                  title: 'Nearest first',
                  subtitle: 'Show deliveries closest to you',
                  selected: _sort == DeliverySort.nearest,
                  onTap: () {
                    setState(() {
                      _sort = DeliverySort.nearest;
                    });
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 10),
                _FilterOption(
                  icon: Icons.payments_rounded,
                  title: 'Highest earning',
                  subtitle: 'Show deliveries with the best fees',
                  selected: _sort == DeliverySort.highestEarning,
                  onTap: () {
                    setState(() {
                      _sort = DeliverySort.highestEarning;
                    });
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 10),
                _FilterOption(
                  icon: Icons.schedule_rounded,
                  title: 'Fastest delivery',
                  subtitle: 'Show shorter estimated delivery times',
                  selected: _sort == DeliverySort.fastest,
                  onTap: () {
                    setState(() {
                      _sort = DeliverySort.fastest;
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: RenonColors.lime,
          size: 19,
        ),
        const SizedBox(height: 6),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: RenonColors.paper,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: RenonColors.paper.withValues(alpha: 0.62),
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _DeliveryCard extends StatelessWidget {
  const _DeliveryCard({
    required this.delivery,
    required this.onTap,
    this.onAccept,
    this.onPickup,
    this.onComplete,
  });

  final _DeliveryData delivery;
  final VoidCallback onTap;
  final VoidCallback? onAccept;
  final VoidCallback? onPickup;
  final VoidCallback? onComplete;

  @override
  Widget build(BuildContext context) {
    final bool isAvailable =
        delivery.status == DeliveryStatus.available;
    final bool isAccepted =
        delivery.status == DeliveryStatus.accepted;
    final bool isPickedUp =
        delivery.status == DeliveryStatus.pickedUp;
    final bool isCompleted =
        delivery.status == DeliveryStatus.completed;

    return Material(
      color: RenonColors.paper,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: isPickedUp
                  ? RenonColors.palm.withValues(alpha: 0.35)
                  : RenonColors.line,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: RenonColors.forest,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      delivery.icon,
                      color: RenonColors.lime,
                      size: 25,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          delivery.restaurant,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: RenonColors.ink,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 5),
                        _StatusBadge(
                          status: delivery.status,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        delivery.amount,
                        style: const TextStyle(
                          color: RenonColors.forest,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'delivery fee',
                        style: TextStyle(
                          color: RenonColors.muted,
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _RouteRow(
                icon: Icons.radio_button_checked_rounded,
                color: RenonColors.palm,
                label: 'PICKUP',
                text: delivery.pickup,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 3,
                  bottom: 3,
                ),
                child: Container(
                  width: 1,
                  height: 18,
                  color: RenonColors.line,
                ),
              ),
              _RouteRow(
                icon: Icons.location_on_rounded,
                color: RenonColors.clay,
                label: 'DROP-OFF',
                text: delivery.dropoff,
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  color: RenonColors.smoke,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.route_rounded,
                      color: RenonColors.forest,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      delivery.distance,
                      style: const TextStyle(
                        color: RenonColors.ink,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.schedule_rounded,
                      color: RenonColors.forest,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      delivery.time,
                      style: const TextStyle(
                        color: RenonColors.ink,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isCompleted) ...[
                const SizedBox(height: 14),
                _buildActionButton(
                  isAvailable: isAvailable,
                  isAccepted: isAccepted,
                  isPickedUp: isPickedUp,
                  onAccept: onAccept,
                  onPickup: onPickup,
                  onComplete: onComplete,
                ),
              ] else ...[
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: RenonColors.smoke,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        color: RenonColors.palm,
                        size: 19,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Delivery completed successfully',
                          style: TextStyle(
                            color: RenonColors.ink,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required bool isAvailable,
    required bool isAccepted,
    required bool isPickedUp,
    required VoidCallback? onAccept,
    required VoidCallback? onPickup,
    required VoidCallback? onComplete,
  }) {
    String label;
    IconData icon;
    VoidCallback? action;

    if (isAvailable) {
      label = 'Accept delivery';
      icon = Icons.check_rounded;
      action = onAccept;
    } else if (isAccepted) {
      label = 'Confirm pickup';
      icon = Icons.inventory_2_rounded;
      action = onPickup;
    } else if (isPickedUp) {
      label = 'Complete delivery';
      icon = Icons.done_all_rounded;
      action = onComplete;
    } else {
      label = 'View delivery';
      icon = Icons.arrow_forward_rounded;
      action = onComplete;
    }

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: action,
        icon: Icon(
          icon,
          size: 19,
        ),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w900,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isAvailable
              ? RenonColors.forest
              : RenonColors.ink,
          foregroundColor: RenonColors.lime,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.status,
  });

  final DeliveryStatus status;

  @override
  Widget build(BuildContext context) {
    final String text;
    final Color color;

    switch (status) {
      case DeliveryStatus.available:
        text = 'AVAILABLE';
        color = RenonColors.palm;
        break;
      case DeliveryStatus.accepted:
        text = 'ACCEPTED';
        color = RenonColors.gold;
        break;
      case DeliveryStatus.pickedUp:
        text = 'OUT FOR DELIVERY';
        color = RenonColors.clay;
        break;
      case DeliveryStatus.completed:
        text = 'COMPLETED';
        color = RenonColors.muted;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 8,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _RouteRow extends StatelessWidget {
  const _RouteRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.text,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: color,
          size: 19,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: RenonColors.ink,
                  fontSize: 13,
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

class _FilterOption extends StatelessWidget {
  const _FilterOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? RenonColors.forest.withValues(alpha: 0.07)
          : RenonColors.smoke,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: RenonColors.forest,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: RenonColors.lime,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: RenonColors.ink,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: RenonColors.muted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              if (selected)
                const Icon(
                  Icons.check_circle_rounded,
                  color: RenonColors.palm,
                  size: 22,
                )
              else
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

enum DeliverySort {
  nearest,
  highestEarning,
  fastest,
}

enum DeliveryStatus {
  available,
  accepted,
  pickedUp,
  completed,
}

class _DeliveryData {
  _DeliveryData({
    required this.id,
    required this.restaurant,
    required this.pickup,
    required this.dropoff,
    required this.distance,
    required this.amount,
    required this.time,
    required this.status,
    required this.icon,
    required this.customer,
    required this.orderItems,
    required this.pickupNote,
  });

  final String id;
  final String restaurant;
  final String pickup;
  final String dropoff;
  final String distance;
  final String amount;
  final String time;
  DeliveryStatus status;
  final IconData icon;
  final String customer;
  final String orderItems;
  final String pickupNote;
}