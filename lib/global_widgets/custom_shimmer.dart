import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final int numberOfCards;

  const CustomShimmer({super.key, required this.numberOfCards});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: numberOfCards,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade400,
                )));
      },
    );
  }
}
