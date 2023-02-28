import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nasys/screens/admin/branches_screen.dart';
import 'package:nasys/screens/admin/customers_screen.dart';
import 'package:nasys/screens/admin/policies_screen.dart';
import 'package:nasys/screens/admin/staff_screen.dart';
import 'package:nasys/theme/theme.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _numBranches = 0;
  int _numCustomers = 0;
  int _numStaff = 0;
  int _numPolicies = 0;
  int _numCoupons = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final snapshot = await FirebaseFirestore.instance.collection('metadata').doc('counts').get();
    if (snapshot.exists) {
      setState(() {
        _numBranches = snapshot.data()?['numBranches'] ?? 0;
        _numCustomers = snapshot.data()?['numCustomers'] ?? 0;
        _numStaff = snapshot.data()?['numStaff'] ?? 0;
        _numPolicies = snapshot.data()?['numPolicies'] ?? 0;
        _numCoupons = snapshot.data()?['numCoupons'] ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = AppTheme.getTextColor(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.business, color: textColor),
              title: Text('Branches ($_numBranches)', style: TextStyle(color: textColor)),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BranchesScreen())),
            ),
            ListTile(
              leading: Icon(Icons.people, color: textColor),
              title: Text('Customers ($_numCustomers)', style: TextStyle(color: textColor)),
              trailing: Icon(Icons.arrow_forward_ios),
              //onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CustomersScreen())),
            ),
            ListTile(
              leading: Icon(Icons.person, color: textColor),
              title: Text('Staff ($_numStaff)', style: TextStyle(color: textColor)),
              trailing: Icon(Icons.arrow_forward_ios),
              //onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const StaffScreen())),
            ),
            ListTile(
              leading: Icon(Icons.policy, color: textColor),
              title: Text('Policies ($_numPolicies)', style: TextStyle(color: textColor)),
              trailing: Icon(Icons.arrow_forward_ios),
              //onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PoliciesScreen())),
            ),
            ListTile(
              leading: Icon(Icons.card_giftcard, color: textColor),
              title: Text('Coupons ($_numCoupons)', style: TextStyle(color: textColor)),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
