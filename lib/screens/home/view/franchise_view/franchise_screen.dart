import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import 'package:merc_mania/screens/home/view/franchise_view/franchise_card.dart';

import '../../../../services/database/franchise_service.dart';
import '../../../../services/models/franchise.dart';

class FranchiseScreen extends StatelessWidget {
  const FranchiseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final franchiseService = FranchiseService();
    return Scaffold(
      appBar: StyledAppBar(
        title: Text('Franchise'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:  franchiseService.getFranchise(), 
        builder: (builder, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          if (snapshot.hasData) {
            final franchise = snapshot.data!.docs.map((doc) => Franchise.fromJson(doc.data())).toList();
            return GridView.builder(
              shrinkWrap : true,
              itemCount: franchise.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(5.0),
                child: FranchiseCard(franchise: franchise[index]),
              ), 
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, 
                crossAxisSpacing: 5, 
                mainAxisSpacing: 5), 
            );
          }                                    
          return Text('No data found');    
        }
      ),
    );
  }
}