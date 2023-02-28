import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nasys/data/models/branch.dart';
import 'package:nasys/theme/theme.dart';

class BranchDetailScreen extends StatefulWidget {
  final String branchId;

  const BranchDetailScreen({Key? key, required this.branchId})
      : super(key: key);

  @override
  _BranchDetailScreenState createState() => _BranchDetailScreenState();
}

class _BranchDetailScreenState extends State<BranchDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _policyController = TextEditingController();
  final _staffIdsController = TextEditingController();
  final _couponIdsController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadBranchData();
  }

  Future<void> _loadBranchData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final branchDoc = await FirebaseFirestore.instance
          .collection('branches')
          .doc(widget.branchId)
          .get();
      final branch = Branch.fromFirestore(branchDoc);
      _nameController.text = branch.name;
      _addressController.text = branch.address;
      _phoneController.text = branch.phone ?? '';
      _emailController.text = branch.email ?? '';
      _policyController.text = branch.policy ?? '';
      _staffIdsController.text = branch.staffIds?.join(', ') ?? '';
      _couponIdsController.text = branch.couponIds?.join(', ') ?? '';
    } catch (e) {
      print('Error loading branch data: $e');
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveBranchData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      final branch = Branch(
        id: widget.branchId,
        name: _nameController.text,
        address: _addressController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        policy: _policyController.text,
        staffIds:
            _staffIdsController.text.split(',').map((id) => id.trim()).toList(),
        couponIds: _couponIdsController.text
            .split(',')
            .map((id) => id.trim())
            .toList(),
      );
      await FirebaseFirestore.instance
          .collection('branches')
          .doc(widget.branchId)
          .set(branch.toFirestore());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Branch details saved')));
    } catch (e) {
      print('Error saving branch data: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error saving branch details')));
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textColor = AppTheme.getTextColor(context);
    final hintTextStyle = TextStyle(color: textColor.withOpacity(0.5));

    return Scaffold(
      appBar: AppBar(title: const Text('Branch Details')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name', style: TextStyle(color: textColor)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nameController,
                        validator: (value) =>
                            value!.isEmpty ? 'Name is required' : null,
                        decoration: InputDecoration(
                          hintText: 'Enter the branch name',
                          border: OutlineInputBorder(),
                          hintStyle: hintTextStyle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('Address', style: TextStyle(color: textColor)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _addressController,
                        validator: (value) =>
                            value!.isEmpty ? 'Address is required' : null,
                        decoration: InputDecoration(
                          hintText: 'Enter the branch address',
                          border: OutlineInputBorder(),
                          hintStyle: hintTextStyle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('Phone', style: TextStyle(color: textColor)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _phoneController,
                        validator: (value) =>
                            value!.isEmpty ? 'Phone is required' : null,
                        decoration: InputDecoration(
                          hintText: 'Enter the branch phone number',
                          border: OutlineInputBorder(),
                          hintStyle: hintTextStyle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('Email', style: TextStyle(color: textColor)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) =>
                            value!.isEmpty ? 'Email is required' : null,
                        decoration: InputDecoration(
                          hintText: 'Enter the branch email address',
                          border: OutlineInputBorder(),
                          hintStyle: hintTextStyle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('Policy', style: TextStyle(color: textColor)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _policyController,
                        decoration: InputDecoration(
                          hintText: 'Enter the branch policy',
                          border: OutlineInputBorder(),
                          hintStyle: hintTextStyle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('Staff IDs', style: TextStyle(color: textColor)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _staffIdsController,
                        decoration: InputDecoration(
                          hintText: 'Enter comma-separated staff IDs',
                          border: OutlineInputBorder(),
                          hintStyle: hintTextStyle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('Coupon IDs', style: TextStyle(color: textColor)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _couponIdsController,
                        decoration: InputDecoration(
                          hintText: 'Enter comma-separated coupon IDs',
                          border: OutlineInputBorder(),
                          hintStyle: hintTextStyle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _saveBranchData,
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
