import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
/// Shimmer placeholder matching card design/// Shimmer placeholder matching card design
// /// Shimmer placeholder matching card design
class NewsShimmerList extends StatelessWidget {
  const NewsShimmerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: 6,
        itemBuilder: (_, i) {
          if (i == 0) {
            // Headline carousel shimmer
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }
          // Regular card shimmer
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // Thumbnail placeholder
                  Container(
                    height: 84,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Text placeholders
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width * .5,
                          height: 16,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: width * .4,
                          height: 14,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 12,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 80,
                              height: 12,
                              color: Colors.grey.shade300,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Bookmark icon placeholder
                  Container(
                    width: 24,
                    height: 24,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}