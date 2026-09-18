import 'package:flutter/material.dart';

import '../../services/rider_earnings_service.dart';
import '../../theme/renon_colors.dart';

class RiderEarningsScreen extends StatefulWidget {
  const RiderEarningsScreen({super.key});

  @override
  State<RiderEarningsScreen> createState() =>
      _RiderEarningsScreenState();
}

class _RiderEarningsScreenState extends State<RiderEarningsScreen> {
  EarningsPeriod _selectedPeriod = EarningsPeriod.week;
  bool _isRefreshing = false;
  bool _isWithdrawing = false;

  final RiderEarningsService _earningsService =
      RiderEarningsService.instance;

  @override
  void initState() {
    super.initState();
    _earningsService.addListener(_onEarningsChanged);
  }

  @override
  void dispose() {
    _earningsService.removeListener(_onEarningsChanged);
    super.dispose();
  }

  void _onEarningsChanged() {
    if (!mounted) return;
    setState(() {});
  }

  double get _baseTotalEarnings {
    switch (_selectedPeriod) {
      case EarningsPeriod.today:
        return 4500;
      case EarningsPeriod.week:
        return 18750;
      case EarningsPeriod.month:
        return 74200;
    }
  }

  int get _baseDeliveryCount {
    switch (_selectedPeriod) {
      case EarningsPeriod.today:
        return 3;
      case EarningsPeriod.week:
        return 14;
      case EarningsPeriod.month:
        return 56;
    }
  }

  double get _totalEarnings {
    return _baseTotalEarnings +
        _earningsService.additionalEarnings;
  }

  int get _deliveryCount {
    return _baseDeliveryCount +
        _earningsService.additionalDeliveries;
  }

  double get _averagePerDelivery {
    if (_deliveryCount == 0) return 0;
    return _totalEarnings / _deliveryCount;
  }

  List<_EarningTransaction> get _transactions {
    final List<_EarningTransaction> baseTransactions;

    switch (_selectedPeriod) {
      case EarningsPeriod.today:
        baseTransactions = [..._todayTransactions];
        break;
      case EarningsPeriod.week:
        baseTransactions = [..._weekTransactions];
        break;
      case EarningsPeriod.month:
        baseTransactions = [..._monthTransactions];
        break;
    }

    final List<_EarningTransaction> liveTransactions =
        _earningsService.newEarnings
            .map(
              (earning) => _EarningTransaction(
                restaurant: earning.restaurant,
                orderId: earning.orderId,
                amount: earning.amount,
                time: earning.time,
                date: earning.date,
                icon: earning.icon,
              ),
            )
            .toList();

    return [
      ...liveTransactions,
      ...baseTransactions,
    ];
  }

  final List<_EarningTransaction> _todayTransactions = [
    _EarningTransaction(
      restaurant: 'Campus Bites',
      orderId: '#RN-20481',
      amount: 1500,
      time: '2:35 PM',
      date: 'Today',
      icon: Icons.restaurant_rounded,
    ),
    _EarningTransaction(
      restaurant: 'Chop & Go',
      orderId: '#RN-20477',
      amount: 1800,
      time: '12:50 PM',
      date: 'Today',
      icon: Icons.fastfood_rounded,
    ),
    _EarningTransaction(
      restaurant: 'Mamas Kitchen',
      orderId: '#RN-20461',
      amount: 1200,
      time: '10:15 AM',
      date: 'Today',
      icon: Icons.restaurant_menu_rounded,
    ),
  ];

  final List<_EarningTransaction> _weekTransactions = [
    _EarningTransaction(
      restaurant: 'Campus Bites',
      orderId: '#RN-20481',
      amount: 1500,
      time: '2:35 PM',
      date: 'Today',
      icon: Icons.restaurant_rounded,
    ),
    _EarningTransaction(
      restaurant: 'Chop & Go',
      orderId: '#RN-20477',
      amount: 1800,
      time: '12:50 PM',
      date: 'Today',
      icon: Icons.fastfood_rounded,
    ),
    _EarningTransaction(
      restaurant: 'Mamas Kitchen',
      orderId: '#RN-20461',
      amount: 1200,
      time: '10:15 AM',
      date: 'Today',
      icon: Icons.restaurant_menu_rounded,
    ),
    _EarningTransaction(
      restaurant: 'The Pizza Spot',
      orderId: '#RN-20394',
      amount: 1600,
      time: '5:20 PM',
      date: 'Yesterday',
      icon: Icons.local_pizza_rounded,
    ),
    _EarningTransaction(
      restaurant: 'Campus Grill',
      orderId: '#RN-20371',
      amount: 1400,
      time: '1:40 PM',
      date: 'Yesterday',
      icon: Icons.restaurant_rounded,
    ),
    _EarningTransaction(
      restaurant: 'Chop & Go',
      orderId: '#RN-20342',
      amount: 1750,
      time: '11:25 AM',
      date: 'Yesterday',
      icon: Icons.fastfood_rounded,
    ),
  ];

  final List<_EarningTransaction> _monthTransactions = [
    _EarningTransaction(
      restaurant: 'Campus Bites',
      orderId: '#RN-20481',
      amount: 1500,
      time: '2:35 PM',
      date: 'Today',
      icon: Icons.restaurant_rounded,
    ),
    _EarningTransaction(
      restaurant: 'Chop & Go',
      orderId: '#RN-20477',
      amount: 1800,
      time: '12:50 PM',
      date: 'Today',
      icon: Icons.fastfood_rounded,
    ),
    _EarningTransaction(
      restaurant: 'Mamas Kitchen',
      orderId: '#RN-20461',
      amount: 1200,
      time: '10:15 AM',
      date: 'Today',
      icon: Icons.restaurant_menu_rounded,
    ),
    _EarningTransaction(
      restaurant: 'The Pizza Spot',
      orderId: '#RN-20394',
      amount: 1600,
      time: '5:20 PM',
      date: 'Yesterday',
      icon: Icons.local_pizza_rounded,
    ),
    _EarningTransaction(
      restaurant: 'Campus Grill',
      orderId: '#RN-20371',
      amount: 1400,
      time: '1:40 PM',
      date: 'Yesterday',
      icon: Icons.restaurant_rounded,
    ),
    _EarningTransaction(
      restaurant: 'Chop & Go',
      orderId: '#RN-20342',
      amount: 1750,
      time: '11:25 AM',
      date: 'Yesterday',
      icon: Icons.fastfood_rounded,
    ),
    _EarningTransaction(
      restaurant: 'Mamas Kitchen',
      orderId: '#RN-20288',
      amount: 1300,
      time: '4:10 PM',
      date: 'Aug 31',
      icon: Icons.restaurant_menu_rounded,
    ),
    _EarningTransaction(
      restaurant: 'Campus Bites',
      orderId: '#RN-20251',
      amount: 1550,
      time: '1:05 PM',
      date: 'Aug 30',
      icon: Icons.restaurant_rounded,
    ),
  ];

  double get _availableBalance {
    return 12850 + _earningsService.additionalEarnings;
  }

  double get _pendingBalance => 2400;

  Future<void> _refresh() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) return;

    setState(() {
      _isRefreshing = false;
    });

    _showMessage('Earnings updated.');
  }

  Future<void> _withdraw() async {
    if (_isWithdrawing) return;

    final bool confirmed =
        await _showWithdrawalConfirmation();

    if (!confirmed || !mounted) return;

    setState(() {
      _isWithdrawing = true;
    });

    await Future<void>.delayed(
      const Duration(milliseconds: 900),
    );

    if (!mounted) return;

    setState(() {
      _isWithdrawing = false;
    });

    _showMessage(
      'Withdrawal request submitted successfully.',
    );
  }

  Future<bool> _showWithdrawalConfirmation() async {
    return await showModalBottomSheet<bool>(
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
                padding: const EdgeInsets.fromLTRB(
                  22,
                  14,
                  22,
                  24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 42,
                        height: 4,
                        decoration: BoxDecoration(
                          color: RenonColors.line,
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Withdraw earnings',
                      style: TextStyle(
                        color: RenonColors.ink,
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your available earnings will be sent to your saved payout account.',
                      style: TextStyle(
                        color: RenonColors.muted,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: RenonColors.smoke,
                        borderRadius:
                            BorderRadius.circular(17),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Amount',
                            style: TextStyle(
                              color: RenonColors.muted,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _formatNaira(
                              _availableBalance,
                            ),
                            style: const TextStyle(
                              color: RenonColors.ink,
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Row(
                            children: [
                              Icon(
                                Icons.account_balance_rounded,
                                color: RenonColors.forest,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Kuda Bank •••• 4821',
                                  style: TextStyle(
                                    color: RenonColors.ink,
                                    fontSize: 12,
                                    fontWeight:
                                        FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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
                                Navigator.pop(
                                  context,
                                  false,
                                );
                              },
                              style:
                                  OutlinedButton.styleFrom(
                                foregroundColor:
                                    RenonColors.ink,
                                side: const BorderSide(
                                  color: RenonColors.line,
                                ),
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                    15,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.w800,
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
                                Navigator.pop(
                                  context,
                                  true,
                                );
                              },
                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    RenonColors.forest,
                                foregroundColor:
                                    RenonColors.paper,
                                elevation: 0,
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                    15,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Withdraw',
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.w900,
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
  }

  void _showTransactionDetails(
    _EarningTransaction transaction,
  ) {
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
              22,
              14,
              22,
              25,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: RenonColors.line,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration:
                          const BoxDecoration(
                        color: RenonColors.smoke,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        transaction.icon,
                        color: RenonColors.forest,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.restaurant,
                            style: const TextStyle(
                              color: RenonColors.ink,
                              fontSize: 15,
                              fontWeight:
                                  FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            transaction.orderId,
                            style: const TextStyle(
                              color: RenonColors.muted,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '+${_formatNaira(transaction.amount)}',
                      style: const TextStyle(
                        color: RenonColors.forest,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                _DetailRow(
                  label: 'Status',
                  value: 'Completed',
                  valueColor: RenonColors.forest,
                ),
                const Divider(
                  height: 22,
                  color: RenonColors.line,
                ),
                _DetailRow(
                  label: 'Date',
                  value: transaction.date,
                ),
                const Divider(
                  height: 22,
                  color: RenonColors.line,
                ),
                _DetailRow(
                  label: 'Time',
                  value: transaction.time,
                ),
                const Divider(
                  height: 22,
                  color: RenonColors.line,
                ),
                const _DetailRow(
                  label: 'Payment',
                  value: 'Delivery earnings',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPayoutMethod() {
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
              22,
              14,
              22,
              25,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: RenonColors.line,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Payout method',
                  style: TextStyle(
                    color: RenonColors.ink,
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'This is where your rider earnings will be paid.',
                  style: TextStyle(
                    color: RenonColors.muted,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: RenonColors.smoke,
                    borderRadius:
                        BorderRadius.circular(17),
                    border: Border.all(
                      color: RenonColors.line,
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.account_balance_rounded,
                        color: RenonColors.forest,
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kuda Bank',
                              style: TextStyle(
                                color: RenonColors.ink,
                                fontSize: 13,
                                fontWeight:
                                    FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '•••• 4821',
                              style: TextStyle(
                                color:
                                    RenonColors.muted,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.check_circle_rounded,
                        color: RenonColors.forest,
                        size: 21,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showMessage(
                        'Payout method editing will be available soon.',
                      );
                    },
                    style:
                        OutlinedButton.styleFrom(
                      foregroundColor:
                          RenonColors.forest,
                      side: const BorderSide(
                        color: RenonColors.line,
                      ),
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Change payout method',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatNaira(double amount) {
    final String value = amount.toStringAsFixed(0);
    final StringBuffer formatted =
        StringBuffer();

    for (int i = 0; i < value.length; i++) {
      if (i > 0 &&
          (value.length - i) % 3 == 0) {
        formatted.write(',');
      }
      formatted.write(value[i]);
    }

    return '₦$formatted';
  }

  String get _periodLabel {
    switch (_selectedPeriod) {
      case EarningsPeriod.today:
        return 'Today';
      case EarningsPeriod.week:
        return 'This week';
      case EarningsPeriod.month:
        return 'This month';
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RenonColors.cream,
      appBar: AppBar(
        backgroundColor: RenonColors.cream,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 20,
        title: const Text(
          'Earnings',
          style: TextStyle(
            color: RenonColors.ink,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showPayoutMethod,
            tooltip: 'Payout method',
            icon: const Icon(
              Icons.account_balance_wallet_outlined,
              color: RenonColors.ink,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: RenonColors.forest,
        backgroundColor: RenonColors.paper,
        child: ListView(
          physics:
              const AlwaysScrollableScrollPhysics(),
          padding:
              const EdgeInsets.fromLTRB(20, 8, 20, 35),
          children: [
            _buildHeroCard(),
            const SizedBox(height: 16),
            _buildPeriodSelector(),
            const SizedBox(height: 16),
            _buildStatsGrid(),
            const SizedBox(height: 16),
            _buildBalanceCard(),
            const SizedBox(height: 24),
            _buildTransactionsHeader(),
            const SizedBox(height: 10),
            _buildTransactions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: RenonColors.forest,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: RenonColors.lime
                      .withValues(alpha: 0.14),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.trending_up_rounded,
                  color: RenonColors.lime,
                  size: 22,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Text(
                  '$_periodLabel earnings',
                  style: TextStyle(
                    color: RenonColors.paper
                        .withValues(alpha: 0.75),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (_isRefreshing)
                const SizedBox(
                  width: 17,
                  height: 17,
                  child:
                      CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(
                      RenonColors.lime,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            _formatNaira(_totalEarnings),
            style: const TextStyle(
              color: RenonColors.paper,
              fontSize: 34,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'From $_deliveryCount completed deliveries',
            style: TextStyle(
              color: RenonColors.paper
                  .withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 22),
          Container(
            height: 1,
            color: RenonColors.paper
                .withValues(alpha: 0.12),
          ),
          const SizedBox(height: 17),
          Row(
            children: [
              const Icon(
                Icons.arrow_upward_rounded,
                color: RenonColors.lime,
                size: 17,
              ),
              const SizedBox(width: 5),
              const Text(
                'Your earnings are growing',
                style: TextStyle(
                  color: RenonColors.paper,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: RenonColors.line,
        ),
      ),
      child: Row(
        children: [
          _PeriodButton(
            label: 'Today',
            selected:
                _selectedPeriod ==
                    EarningsPeriod.today,
            onTap: () {
              setState(() {
                _selectedPeriod =
                    EarningsPeriod.today;
              });
            },
          ),
          _PeriodButton(
            label: 'This week',
            selected:
                _selectedPeriod ==
                    EarningsPeriod.week,
            onTap: () {
              setState(() {
                _selectedPeriod =
                    EarningsPeriod.week;
              });
            },
          ),
          _PeriodButton(
            label: 'This month',
            selected:
                _selectedPeriod ==
                    EarningsPeriod.month,
            onTap: () {
              setState(() {
                _selectedPeriod =
                    EarningsPeriod.month;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon:
                Icons.local_shipping_outlined,
            label: 'Deliveries',
            value: '$_deliveryCount',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            icon: Icons.payments_outlined,
            label: 'Avg. delivery',
            value:
                _formatNaira(_averagePerDelivery),
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceCard() {
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
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration:
                    const BoxDecoration(
                  color: RenonColors.smoke,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_balance_wallet_rounded,
                  color: RenonColors.forest,
                  size: 21,
                ),
              ),
              const SizedBox(width: 11),
              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available balance',
                      style: TextStyle(
                        color: RenonColors.ink,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Ready for withdrawal',
                      style: TextStyle(
                        color: RenonColors.muted,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                _formatNaira(_availableBalance),
                style: const TextStyle(
                  color: RenonColors.forest,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: RenonColors.smoke,
              borderRadius:
                  BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.hourglass_bottom_rounded,
                  color: RenonColors.gold,
                  size: 18,
                ),
                const SizedBox(width: 9),
                const Expanded(
                  child: Text(
                    'Pending earnings',
                    style: TextStyle(
                      color: RenonColors.muted,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  _formatNaira(_pendingBalance),
                  style: const TextStyle(
                    color: RenonColors.ink,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed:
                  _isWithdrawing
                      ? null
                      : _withdraw,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    RenonColors.forest,
                disabledBackgroundColor:
                    RenonColors.forest
                        .withValues(alpha: 0.55),
                foregroundColor:
                    RenonColors.paper,
                elevation: 0,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                ),
              ),
              child: _isWithdrawing
                  ? const SizedBox(
                      width: 21,
                      height: 21,
                      child:
                          CircularProgressIndicator(
                        strokeWidth: 2.4,
                        valueColor:
                            AlwaysStoppedAnimation<
                                Color>(
                          RenonColors.paper,
                        ),
                      ),
                    )
                  : const Text(
                      'Withdraw earnings',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsHeader() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Earnings history',
                style: TextStyle(
                  color: RenonColors.ink,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Your completed delivery earnings',
                style: TextStyle(
                  color: RenonColors.muted,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        Text(
          '${_transactions.length} records',
          style: const TextStyle(
            color: RenonColors.muted,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactions() {
    if (_transactions.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: _transactions
          .map(
            (transaction) => Padding(
              padding:
                  const EdgeInsets.only(
                bottom: 10,
              ),
              child: _TransactionCard(
                transaction: transaction,
                onTap: () {
                  _showTransactionDetails(
                    transaction,
                  );
                },
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius:
            BorderRadius.circular(22),
        border: Border.all(
          color: RenonColors.line,
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            color: RenonColors.muted,
            size: 38,
          ),
          SizedBox(height: 12),
          Text(
            'No earnings yet',
            style: TextStyle(
              color: RenonColors.ink,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Complete deliveries to start building your earnings history.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: RenonColors.muted,
              fontSize: 11,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

enum EarningsPeriod {
  today,
  week,
  month,
}

class _EarningTransaction {
  const _EarningTransaction({
    required this.restaurant,
    required this.orderId,
    required this.amount,
    required this.time,
    required this.date,
    required this.icon,
  });

  final String restaurant;
  final String orderId;
  final double amount;
  final String time;
  final String date;
  final IconData icon;
}

class _PeriodButton extends StatelessWidget {
  const _PeriodButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration:
              const Duration(milliseconds: 180),
          padding:
              const EdgeInsets.symmetric(
            vertical: 11,
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            color: selected
                ? RenonColors.forest
                : RenonColors.paper,
            borderRadius:
                BorderRadius.circular(12),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected
                  ? RenonColors.paper
                  : RenonColors.muted,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius:
            BorderRadius.circular(20),
        border: Border.all(
          color: RenonColors.line,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration:
                const BoxDecoration(
              color: RenonColors.smoke,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: RenonColors.forest,
              size: 19,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  overflow:
                      TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: RenonColors.ink,
                    fontSize: 14,
                    fontWeight:
                        FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  label,
                  overflow:
                      TextOverflow.ellipsis,
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
    );
  }
}

class _TransactionCard
    extends StatelessWidget {
  const _TransactionCard({
    required this.transaction,
    required this.onTap,
  });

  final _EarningTransaction transaction;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: RenonColors.paper,
      borderRadius:
          BorderRadius.circular(19),
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(19),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(19),
            border: Border.all(
              color: RenonColors.line,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration:
                    const BoxDecoration(
                  color: RenonColors.smoke,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  transaction.icon,
                  color: RenonColors.forest,
                  size: 20,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.restaurant,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: RenonColors.ink,
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${transaction.orderId} • ${transaction.date} • ${transaction.time}',
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        color:
                            RenonColors.muted,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: [
                  Text(
                    '+${_formatTransactionAmount(transaction.amount)}',
                    style:
                        const TextStyle(
                      color:
                          RenonColors.forest,
                      fontSize: 12,
                      fontWeight:
                          FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color:
                        RenonColors.muted,
                    size: 17,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTransactionAmount(
    double amount,
  ) {
    final String value =
        amount.toStringAsFixed(0);
    final StringBuffer formatted =
        StringBuffer();

    for (int i = 0; i < value.length; i++) {
      if (i > 0 &&
          (value.length - i) % 3 == 0) {
        formatted.write(',');
      }
      formatted.write(value[i]);
    }

    return '₦$formatted';
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.valueColor =
        RenonColors.ink,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
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
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}