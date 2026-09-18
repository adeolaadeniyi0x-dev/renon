import 'package:flutter/material.dart';

import '../../theme/renon_colors.dart';

class RiderVerificationScreen extends StatefulWidget {
  const RiderVerificationScreen({super.key});

  @override
  State<RiderVerificationScreen> createState() =>
      _RiderVerificationScreenState();
}
class _RiderVerificationScreenState extends State<RiderVerificationScreen> {
  bool _isSubmitting = false;

  final String _identityStatus = 'Approved';
  final String _phoneStatus = 'Approved';
  final String _emailStatus = 'Approved';
  String _idStatus = 'Approved';
  String _licenseStatus = 'Pending';
  final String _vehicleStatus = 'Approved';

  int get _completedSteps {
    final statuses = [
      _identityStatus,
      _phoneStatus,
      _emailStatus,
      _idStatus,
      _licenseStatus,
      _vehicleStatus,
    ];

    return statuses.where((status) => status == 'Approved').length;
  }

  double get _progress => _completedSteps / 6;

  Future<void> _submitDocument(String documentName) async {
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;

      if (documentName == 'Driver’s Licence') {
        _licenseStatus = 'Pending';
      } else if (documentName == 'Government ID') {
        _idStatus = 'Pending';
      }
    });

    _showMessage('$documentName submitted for review.');
  }

  void _showMessage(String message) {
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

  Color _statusColor(String status) {
    switch (status) {
      case 'Approved':
        return RenonColors.palm;
      case 'Pending':
        return RenonColors.gold;
      case 'Rejected':
        return RenonColors.danger;
      default:
        return RenonColors.muted;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'Approved':
        return Icons.check_circle_rounded;
      case 'Pending':
        return Icons.schedule_rounded;
      case 'Rejected':
        return Icons.error_rounded;
      default:
        return Icons.radio_button_unchecked_rounded;
    }
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
          'Verification',
          style: TextStyle(
            color: RenonColors.ink,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            _buildProgressCard(),
            const SizedBox(height: 18),
            _buildStatusBanner(),
            const SizedBox(height: 26),
            _buildSectionTitle(
              'Account verification',
              'These checks confirm your identity and account details.',
            ),
            const SizedBox(height: 12),
            _buildVerificationCard(
              icon: Icons.badge_outlined,
              title: 'Identity',
              subtitle: 'Your rider identity has been confirmed.',
              status: _identityStatus,
            ),
            const SizedBox(height: 10),
            _buildVerificationCard(
              icon: Icons.phone_outlined,
              title: 'Phone number',
              subtitle: 'Your phone number is verified.',
              status: _phoneStatus,
            ),
            const SizedBox(height: 10),
            _buildVerificationCard(
              icon: Icons.email_outlined,
              title: 'Email address',
              subtitle: 'Your email address is verified.',
              status: _emailStatus,
            ),
            const SizedBox(height: 26),
            _buildSectionTitle(
              'Documents',
              'Keep your documents clear, valid and up to date.',
            ),
            const SizedBox(height: 12),
            _buildDocumentCard(
              icon: Icons.credit_card_outlined,
              title: 'Government ID',
              subtitle: 'National ID, voter’s card, passport or driver’s licence.',
              status: _idStatus,
              actionLabel:
                  _idStatus == 'Rejected' ? 'Resubmit' : 'View details',
              onAction: () {
                if (_idStatus == 'Rejected') {
                  _submitDocument('Government ID');
                } else {
                  _showDocumentDetails(
                    title: 'Government ID',
                    description:
                        'Your government identification was reviewed by RENON.',
                    status: _idStatus,
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            _buildDocumentCard(
              icon: Icons.drive_eta_outlined,
              title: 'Driver’s Licence',
              subtitle: 'A valid licence is required for motor vehicle deliveries.',
              status: _licenseStatus,
              actionLabel:
                  _licenseStatus == 'Rejected' ? 'Resubmit' : 'Update',
              onAction: () {
                if (_licenseStatus == 'Rejected' ||
                    _licenseStatus == 'Pending') {
                  _showDocumentDetails(
                    title: 'Driver’s Licence',
                    description:
                        'Your driver’s licence is currently being reviewed.',
                    status: _licenseStatus,
                  );
                } else {
                  _submitDocument('Driver’s Licence');
                }
              },
            ),
            const SizedBox(height: 26),
            _buildSectionTitle(
              'Vehicle verification',
              'Your vehicle must match the information on your rider profile.',
            ),
            const SizedBox(height: 12),
            _buildVerificationCard(
              icon: Icons.two_wheeler_outlined,
              title: 'Vehicle',
              subtitle: 'Honda CB125 • EKY 482 AB',
              status: _vehicleStatus,
              onTap: () {
                _showDocumentDetails(
                  title: 'Vehicle verification',
                  description:
                      'Your vehicle information has been verified and is currently active.',
                  status: _vehicleStatus,
                );
              },
            ),
            const SizedBox(height: 26),
            _buildRequirementsCard(),
            const SizedBox(height: 26),
            _buildSecurityNote(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    final percentage = (_progress * 100).round();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RenonColors.forest,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: RenonColors.lime.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.verified_user_outlined,
                  color: RenonColors.lime,
                  size: 25,
                ),
              ),
              const Spacer(),
              Text(
                '$percentage%',
                style: const TextStyle(
                  color: RenonColors.lime,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Verification progress',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$_completedSteps of 6 checks completed',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.68),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 9,
              backgroundColor: Colors.white.withValues(alpha: 0.12),
              valueColor: const AlwaysStoppedAnimation<Color>(
                RenonColors.lime,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBanner() {
    final hasPending = [
      _identityStatus,
      _phoneStatus,
      _emailStatus,
      _idStatus,
      _licenseStatus,
      _vehicleStatus,
    ].contains('Pending');

    final hasRejected = [
      _identityStatus,
      _phoneStatus,
      _emailStatus,
      _idStatus,
      _licenseStatus,
      _vehicleStatus,
    ].contains('Rejected');

    if (hasRejected) {
      return _statusBanner(
        icon: Icons.error_outline_rounded,
        title: 'Action required',
        message:
            'One or more verification items need attention. Resubmit the required document to continue.',
        color: RenonColors.danger,
      );
    }

    if (hasPending) {
      return _statusBanner(
        icon: Icons.hourglass_top_rounded,
        title: 'Verification in progress',
        message:
            'Some documents are being reviewed. We’ll update your account when the review is complete.',
        color: RenonColors.gold,
      );
    }

    return _statusBanner(
      icon: Icons.verified_rounded,
      title: 'You’re fully verified',
      message:
          'Your rider account has passed all verification checks and is ready for deliveries.',
      color: RenonColors.palm,
    );
  }

  Widget _statusBanner({
    required IconData icon,
    required String title,
    required String message,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    color: RenonColors.muted,
                    fontSize: 12.5,
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

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: RenonColors.ink,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: RenonColors.muted,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildVerificationCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String status,
    VoidCallback? onTap,
  }) {
    final statusColor = _statusColor(status);

    return Material(
      color: RenonColors.paper,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: RenonColors.line),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: RenonColors.smoke,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: RenonColors.forest,
                  size: 22,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: RenonColors.ink,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: RenonColors.muted,
                        fontSize: 12,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _statusPill(status, statusColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String status,
    required String actionLabel,
    required VoidCallback onAction,
  }) {
    final statusColor = _statusColor(status);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: RenonColors.line),
      ),
      child: Column(
        children: [
          Row(
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
                  icon,
                  color: RenonColors.forest,
                  size: 22,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: RenonColors.ink,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: RenonColors.muted,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              _statusPill(status, statusColor),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onAction,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: RenonColors.forest,
                    side: const BorderSide(color: RenonColors.line),
                    minimumSize: const Size.fromHeight(44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    actionLabel,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusPill(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _statusIcon(status),
            color: color,
            size: 14,
          ),
          const SizedBox(width: 5),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementsCard() {
    const requirements = [
      'Use valid and unexpired documents.',
      'Make sure your full name matches your account details.',
      'Upload clear photos with all corners visible.',
      'Avoid glare, blur or heavily cropped documents.',
      'Keep your vehicle information accurate.',
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: RenonColors.smoke,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.checklist_rounded,
                color: RenonColors.forest,
                size: 22,
              ),
              SizedBox(width: 9),
              Text(
                'Verification requirements',
                style: TextStyle(
                  color: RenonColors.ink,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...requirements.map(
            (requirement) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_rounded,
                    color: RenonColors.palm,
                    size: 17,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      requirement,
                      style: const TextStyle(
                        color: RenonColors.muted,
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: RenonColors.line),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lock_outline_rounded,
            color: RenonColors.palm,
            size: 21,
          ),
          SizedBox(width: 11),
          Expanded(
            child: Text(
              'Your verification information is used to confirm your eligibility as a RENON rider. Never share your verification codes or account password with anyone.',
              style: TextStyle(
                color: RenonColors.muted,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDocumentDetails({
    required String title,
    required String description,
    required String status,
  }) {
    final statusColor = _statusColor(status);

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: RenonColors.cream,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: RenonColors.ink,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    _statusIcon(status),
                    color: statusColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: const TextStyle(
                  color: RenonColors.muted,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: RenonColors.forest,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}