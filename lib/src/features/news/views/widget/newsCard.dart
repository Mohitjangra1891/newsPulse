import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_news/src/features/news/views/shimmerLoading.dart';
import 'package:my_news/src/features/search/searchScreen.dart';

import '../../../../common/webViewScreeen.dart';
import '../../../../modals/articleModal.dart';
import '../../../bookmark/controller/bookMarkController.dart';

class NewsCard extends ConsumerWidget {
  final Article article;

  const NewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarksProvider);
    final isBookmarked = bookmarks.any((a) => a.url == article.url);
    final formattedDate = DateFormat('d MMMM, y').format(article.publishedAt);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => WebViewPage(url: article.url, title: article.title),
            ),
          );
        },
        child: Material(

          elevation: 4,
          borderRadius: BorderRadius.circular(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: Image
                  Container(
                    width: 120,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade200,
                    ),
                    child: article.urlToImage.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        article.urlToImage,
                        fit: BoxFit.cover,
                        width: 120,
                        height: 100,  errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                        );
                      },
                      ),
                    )
                        : const Icon(Icons.image, size: 40, color: Colors.grey),
                  ),

                  const SizedBox(width: 10),

                  // Right: Texts and Bookmark
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and bookmark icon
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                article.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                isBookmarked ? Icons.bookmark : Icons.bookmark_border,

                                size: 22,
                              ),
                              onPressed: () =>
                                  ref.read(bookmarksProvider.notifier).toggle(article),
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          article.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              article.sourceName,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500 ,

                              ),
                            ),
                            // const SizedBox(width: 10),
                            Spacer(),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,

                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
