import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nasys/data/models/branch.dart';
import 'package:nasys/screens/admin/branches/branch_detail_screen.dart';

class BranchesScreen extends StatelessWidget {
  const BranchesScreen({Key? key}) : super(key: key);

  Future<List<Branch>> _getBranches() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('branches')
        .orderBy('name')
        .get();
    return snapshot.docs.map((doc) => Branch.fromFirestore(doc)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Branches')),
      body: FutureBuilder<List<Branch>>(
        future: _getBranches(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final branches = snapshot.data!;
            return ListView.builder(
              itemCount: branches.length,
              itemBuilder: (context, index) {
                final branch = branches[index];
                return ListTile(
                  title: Text(branch.name),
                  subtitle: Text(branch.address),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BranchDetailScreen(branchId: branch.id)));
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the screen to add a new branch
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
