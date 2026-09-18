import 'package:flutter/material.dart';

import '../../theme/renon_colors.dart';

class RiderVehicleScreen extends StatefulWidget {
  const RiderVehicleScreen({super.key});

  @override
  State<RiderVehicleScreen> createState() => _RiderVehicleScreenState();
}

class _RiderVehicleScreenState extends State<RiderVehicleScreen> {
  bool _isEditing = false;
  bool _isSaving = false;

  String _vehicleType = 'Motorcycle';
  String _ownershipType = 'Personal';
  String _vehicleMake = 'Honda';
  String _vehicleModel = 'CB125';
  String _vehicleYear = '2024';
  String _vehicleColor = 'Black';
  String _plateNumber = 'EKY 482 AB';

  final _makeController = TextEditingController(text: 'Honda');
  final _modelController = TextEditingController(text: 'CB125');
  final _yearController = TextEditingController(text: '2024');
  final _colorController = TextEditingController(text: 'Black');
  final _plateController = TextEditingController(text: 'EKY 482 AB');

  final Map<String, bool> _documents = {
    'Vehicle Registration': true,
    'Insurance Certificate': true,
    'Driver’s Licence': true,
  };

  @override
  void dispose() {
    _makeController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _colorController.dispose();
    _plateController.dispose();
    super.dispose();
  }

  Future<void> _saveVehicle() async {
    if (_makeController.text.trim().isEmpty ||
        _modelController.text.trim().isEmpty ||
        _yearController.text.trim().isEmpty ||
        _colorController.text.trim().isEmpty ||
        _plateController.text.trim().isEmpty) {
      _showMessage('Please complete all vehicle details.');
      return;
    }

    setState(() {
      _isSaving = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    setState(() {
      _vehicleMake = _makeController.text.trim();
      _vehicleModel = _modelController.text.trim();
      _vehicleYear = _yearController.text.trim();
      _vehicleColor = _colorController.text.trim();
      _plateNumber = _plateController.text.trim();
      _isEditing = false;
      _isSaving = false;
    });

    _showMessage('Vehicle information updated successfully.');
  }

  void _cancelEditing() {
    _makeController.text = _vehicleMake;
    _modelController.text = _vehicleModel;
    _yearController.text = _vehicleYear;
    _colorController.text = _vehicleColor;
    _plateController.text = _plateNumber;

    setState(() {
      _isEditing = false;
    });
  }

  void _showVehicleTypePicker() {
    const types = [
      'Motorcycle',
      'Car',
      'Bicycle',
      'Van',
      'Tricycle',
    ];

    _showSelectionSheet(
      title: 'Vehicle type',
      options: types,
      selected: _vehicleType,
      onSelected: (value) {
        setState(() {
          _vehicleType = value;
        });
      },
    );
  }

  void _showOwnershipPicker() {
    const types = [
      'Personal',
      'Company Vehicle',
      'Leased',
      'Rented',
    ];

    _showSelectionSheet(
      title: 'Ownership type',
      options: types,
      selected: _ownershipType,
      onSelected: (value) {
        setState(() {
          _ownershipType = value;
        });
      },
    );
  }

  void _showSelectionSheet({
    required String title,
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelected,
  }) {
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
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: RenonColors.line,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: RenonColors.ink,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ...options.map(
                  (option) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      option,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: RenonColors.ink,
                      ),
                    ),
                    trailing: option == selected
                        ? const Icon(
                            Icons.check_circle_rounded,
                            color: RenonColors.palm,
                          )
                        : null,
                    onTap: () {
                      Navigator.pop(context);
                      onSelected(option);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _uploadDocument(String documentName) {
    setState(() {
      _documents[documentName] = true;
    });

    _showMessage('$documentName marked as uploaded.');
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: RenonColors.charcoal,
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: RenonColors.ink,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Vehicle Information',
          style: TextStyle(
            color: RenonColors.ink,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          if (!_isEditing)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _isEditing = true;
                  });
                },
                child: const Text(
                  'Edit',
                  style: TextStyle(
                    color: RenonColors.palm,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVerificationBanner(),
              const SizedBox(height: 22),
              _buildVehicleOverview(),
              const SizedBox(height: 28),
              _buildSectionTitle(
                'Vehicle details',
                'Keep your vehicle information up to date.',
              ),
              const SizedBox(height: 12),
              _buildDetailsCard(),
              const SizedBox(height: 28),
              _buildSectionTitle(
                'Vehicle documents',
                'Documents are required before you can receive deliveries.',
              ),
              const SizedBox(height: 12),
              _buildDocumentsCard(),
              const SizedBox(height: 28),
              _buildImportantNotice(),
              if (_isEditing) ...[
                const SizedBox(height: 24),
                _buildSaveButtons(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerificationBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RenonColors.palm.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: RenonColors.palm.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: RenonColors.palm.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.verified_rounded,
              color: RenonColors.palm,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vehicle verified',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: RenonColors.ink,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Your vehicle has been approved for RENON deliveries.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: RenonColors.muted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleOverview() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RenonColors.charcoal,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: RenonColors.lime,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  _vehicleType == 'Motorcycle'
                      ? Icons.two_wheeler_rounded
                      : _vehicleType == 'Bicycle'
                          ? Icons.pedal_bike_rounded
                          : Icons.directions_car_rounded,
                  color: RenonColors.ink,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$_vehicleMake $_vehicleModel',
                      style: const TextStyle(
                        color: RenonColors.paper,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$_vehicleYear • $_vehicleColor',
                      style: const TextStyle(
                        color: RenonColors.softText,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: RenonColors.lime.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'ACTIVE',
                  style: TextStyle(
                    color: RenonColors.lime,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: RenonColors.paper.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.confirmation_number_outlined,
                  color: RenonColors.softText,
                  size: 19,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Plate number',
                  style: TextStyle(
                    color: RenonColors.softText,
                    fontSize: 13,
                  ),
                ),
                const Spacer(),
                Text(
                  _plateNumber,
                  style: const TextStyle(
                    color: RenonColors.paper,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
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
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: RenonColors.muted,
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: RenonColors.line),
      ),
      child: Column(
        children: [
          _buildSelectionField(
            label: 'Vehicle type',
            value: _vehicleType,
            icon: Icons.two_wheeler_rounded,
            enabled: _isEditing,
            onTap: _showVehicleTypePicker,
          ),
          const Divider(height: 26, color: RenonColors.line),
          _buildTextField(
            controller: _makeController,
            label: 'Make',
            icon: Icons.factory_outlined,
            enabled: _isEditing,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _modelController,
            label: 'Model',
            icon: Icons.directions_car_outlined,
            enabled: _isEditing,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _yearController,
                  label: 'Year',
                  icon: Icons.calendar_today_outlined,
                  enabled: _isEditing,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTextField(
                  controller: _colorController,
                  label: 'Color',
                  icon: Icons.palette_outlined,
                  enabled: _isEditing,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _plateController,
            label: 'Plate number',
            icon: Icons.confirmation_number_outlined,
            enabled: _isEditing,
            textCapitalization: TextCapitalization.characters,
          ),
          const SizedBox(height: 16),
          _buildSelectionField(
            label: 'Ownership',
            value: _ownershipType,
            icon: Icons.person_outline_rounded,
            enabled: _isEditing,
            onTap: _showOwnershipPicker,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool enabled,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      style: const TextStyle(
        color: RenonColors.ink,
        fontWeight: FontWeight.w700,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: RenonColors.muted,
          fontSize: 13,
        ),
        prefixIcon: Icon(
          icon,
          color: enabled ? RenonColors.palm : RenonColors.muted,
          size: 20,
        ),
        filled: true,
        fillColor: enabled ? RenonColors.smoke : RenonColors.cream,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: RenonColors.line,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: RenonColors.palm,
            width: 1.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: RenonColors.line,
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionField({
    required String label,
    required String value,
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: enabled ? RenonColors.smoke : RenonColors.cream,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: RenonColors.line),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: enabled ? RenonColors.palm : RenonColors.muted,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: RenonColors.muted,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    value,
                    style: const TextStyle(
                      color: RenonColors.ink,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            if (enabled)
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: RenonColors.muted,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentsCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: RenonColors.line),
      ),
      child: Column(
        children: [
          _buildDocumentTile(
            title: 'Vehicle Registration',
            subtitle: 'Registration document',
            icon: Icons.description_outlined,
          ),
          const Divider(
            height: 1,
            indent: 18,
            endIndent: 18,
            color: RenonColors.line,
          ),
          _buildDocumentTile(
            title: 'Insurance Certificate',
            subtitle: 'Valid insurance document',
            icon: Icons.security_outlined,
          ),
          const Divider(
            height: 1,
            indent: 18,
            endIndent: 18,
            color: RenonColors.line,
          ),
          _buildDocumentTile(
            title: 'Driver’s Licence',
            subtitle: 'Valid driving licence',
            icon: Icons.badge_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentTile({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final uploaded = _documents[title] ?? false;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: uploaded
                  ? RenonColors.palm.withValues(alpha: 0.09)
                  : RenonColors.smoke,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: uploaded ? RenonColors.palm : RenonColors.muted,
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
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: RenonColors.muted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (uploaded)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: RenonColors.palm.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: RenonColors.palm,
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Verified',
                    style: TextStyle(
                      color: RenonColors.palm,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            )
          else
            IconButton(
              tooltip: 'Upload',
              onPressed: () => _uploadDocument(title),
              icon: const Icon(
                Icons.upload_file_rounded,
                color: RenonColors.palm,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImportantNotice() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RenonColors.gold.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: RenonColors.gold.withValues(alpha: 0.20),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: RenonColors.gold,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Make sure your vehicle information matches your official documents. Incorrect information may delay verification or affect your ability to receive delivery requests.',
              style: TextStyle(
                color: RenonColors.ink,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _isSaving ? null : _cancelEditing,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
              side: const BorderSide(
                color: RenonColors.line,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: RenonColors.ink,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: _isSaving ? null : _saveVehicle,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(54),
              backgroundColor: RenonColors.lime,
              foregroundColor: RenonColors.ink,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: _isSaving
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: RenonColors.ink,
                    ),
                  )
                : const Text(
                    'Save changes',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}