import 'package:flutter/material.dart';

class RiderEarning {
  const RiderEarning({
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

class RiderEarningsService extends ChangeNotifier {
  RiderEarningsService._();

  static final RiderEarningsService instance =
      RiderEarningsService._();

  final List<RiderEarning> _newEarnings = [];

  double get additionalEarnings {
    double total = 0;

    for (final earning in _newEarnings) {
      total += earning.amount;
    }

    return total;
  }

  int get additionalDeliveries => _newEarnings.length;

  List<RiderEarning> get newEarnings =>
      List.unmodifiable(_newEarnings);

  void recordCompletedDelivery({
    required String restaurant,
    required String orderId,
    required double amount,
    required String time,
    required String date,
    required IconData icon,
  }) {
    final bool alreadyRecorded = _newEarnings.any(
      (earning) => earning.orderId == orderId,
    );

    if (alreadyRecorded) {
      return;
    }

    _newEarnings.insert(
      0,
      RiderEarning(
        restaurant: restaurant,
        orderId: orderId,
        amount: amount,
        time: time,
        date: date,
        icon: icon,
      ),
    );

    notifyListeners();
  }

  void clearMockEarnings() {
    _newEarnings.clear();
    notifyListeners();
  }
}