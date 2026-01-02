import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/institutions.dart';
import '../../../data/models/asset_models.dart';

class AddAssetScreen extends StatefulWidget {
  const AddAssetScreen({super.key});

  @override
  State<AddAssetScreen> createState() => _AddAssetScreenState();
}

class _AddAssetScreenState extends State<AddAssetScreen> {
  final _formKey = GlobalKey<FormState>();
  AssetType _selectedType = AssetType.cash;
  String? _selectedInstitution;
  String? _selectedCashName;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _resetFields();
  }

  void _resetFields() {
    _selectedInstitution = _selectedType == AssetType.cash
        ? AppConstants.banks.first
        : (_selectedType == AssetType.stock
              ? AppConstants.brokerages.first
              : null);
    _selectedCashName = _selectedType == AssetType.cash
        ? AppConstants.cashAssetNames.first
        : null;
    _nameController.clear();
    _valueController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('新增資產')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('基本資訊'),
              const SizedBox(height: 16),
              _buildTypeDropdown(),
              const SizedBox(height: 24),
              _buildDynamicFields(),
              const SizedBox(height: 40),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppTheme.primaryColor,
      ),
    );
  }

  Widget _buildTypeDropdown() {
    return DropdownButtonFormField<AssetType>(
      value: _selectedType,
      decoration: const InputDecoration(
        labelText: '資產類別',
        border: OutlineInputBorder(),
      ),
      items: AssetType.values.map((type) {
        String label = '';
        switch (type) {
          case AssetType.cash:
            label = '現金存款';
            break;
          case AssetType.stock:
            label = '股票證券';
            break;
          case AssetType.fund:
            label = '基金/ETF';
            break;
          case AssetType.other:
            label = '其他資產';
            break;
        }
        return DropdownMenuItem(value: type, child: Text(label));
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedType = value;
            _resetFields();
          });
        }
      },
    );
  }

  Widget _buildDynamicFields() {
    return Column(
      children: [
        if (_selectedType == AssetType.cash || _selectedType == AssetType.stock)
          _buildInstitutionDropdown(),
        const SizedBox(height: 24),
        if (_selectedType == AssetType.cash) _buildCashNameDropdown(),
        if (_selectedType == AssetType.stock) _buildStockSymbolInput(),
        if (_selectedType == AssetType.fund || _selectedType == AssetType.other)
          _buildNameInput(),
        const SizedBox(height: 24),
        _buildValueInput(),
      ],
    );
  }

  Widget _buildInstitutionDropdown() {
    List<String> options = _selectedType == AssetType.cash
        ? AppConstants.banks
        : AppConstants.brokerages;
    String label = _selectedType == AssetType.cash ? '選擇銀行' : '選擇券商';

    return DropdownButtonFormField<String>(
      value: _selectedInstitution,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: options
          .map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
          .toList(),
      onChanged: (val) => setState(() => _selectedInstitution = val),
      validator: (val) => val == null ? '請選擇機構' : null,
    );
  }

  Widget _buildCashNameDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCashName,
      decoration: const InputDecoration(
        labelText: '存款類型',
        border: OutlineInputBorder(),
      ),
      items: AppConstants.cashAssetNames
          .map((name) => DropdownMenuItem(value: name, child: Text(name)))
          .toList(),
      onChanged: (val) => setState(() => _selectedCashName = val),
    );
  }

  Widget _buildStockSymbolInput() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: '股票代號',
        hintText: '例如: 2330',
        border: OutlineInputBorder(),
      ),
      validator: (val) => (val == null || val.isEmpty) ? '請輸入代號' : null,
    );
  }

  Widget _buildNameInput() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: '資產名稱',
        border: OutlineInputBorder(),
      ),
      validator: (val) => (val == null || val.isEmpty) ? '請輸入名稱' : null,
    );
  }

  Widget _buildValueInput() {
    String label = _selectedType == AssetType.stock ? '股數' : '金額';
    return TextFormField(
      controller: _valueController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixText: _selectedType == AssetType.stock ? null : '\$ ',
      ),
      validator: (val) {
        if (val == null || val.isEmpty) return '請輸入數值';
        if (double.tryParse(val) == null) return '請輸入有效數字';
        return null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // TODO: Save asset logic
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('資產已新增（預覽）')));
            Navigator.pop(context);
          }
        },
        child: const Text(
          '確認新增',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
