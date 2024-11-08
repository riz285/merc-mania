import 'package:flutter/material.dart';

import 'franchise_card.dart';
import '../../../../services/models/franchise.dart';

class FranchiseListView extends StatelessWidget {
  final List<Franchise> franchise;
  const FranchiseListView({super.key, required this.franchise});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) => FranchiseCard(franchise: franchise[index]), 
            separatorBuilder: (context, index) => SizedBox(width: 5),
    );
  }
}