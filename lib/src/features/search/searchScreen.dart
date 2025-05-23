import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_news/src/features/news/views/newsPage.dart';

import '../../common/webViewScreeen.dart';
import '../../core/utils/constant.dart';
import '../../modals/articleModal.dart';
import '../bookmark/controller/bookMarkController.dart';
import '../news/controller/newsController.dart';
import '../news/views/widget/newsCard.dart';

/// Search Page
class SearchPage extends ConsumerStatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final asyncResults = ref.watch(searchProvider(_query));
    final bookmarks = ref.watch(bookmarksProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Search News')),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.search,
                    decoration:  InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: commonBorder(),
                        focusedBorder: commonBorder(),
                        disabledBorder: commonBorder(),
                        errorBorder: commonBorder(),
                        focusedErrorBorder: commonBorder(),
                        hintText: "Search News"),
                    onChanged: (val) {},
                    onSubmitted: (v) => setState(() => _query = v.trim()),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => setState(() => _query = _controller.text.trim()),
                    icon: const Icon(Icons.search_sharp)),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: asyncResults.when(
              loading: () => Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: \$e')),
              data: (articles) => ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];

                  return NewsCard(article: article);
                },
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

/// Shared list UI
class ArticleListView extends ConsumerWidget {
  final List<Article> articles;
  final List<Article> bookmarks;

  ArticleListView({required this.articles, required this.bookmarks});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (c, i) {
        final art = articles[i];
        final date = DateFormat('d MMMM, y').format(art.publishedAt);
        final isBook = bookmarks.any((b) => b.url == art.url);
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: art.urlToImage.isNotEmpty ? Image.network(art.urlToImage, width: 80, fit: BoxFit.cover) : null,
            title: Text(art.title),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (art.description.isNotEmpty) Text(art.description, maxLines: 2, overflow: TextOverflow.ellipsis),
              SizedBox(height: 4),
              Text(art.sourceName),
              Text('[$date]'),
            ]),
            trailing: IconButton(
              icon: Icon(isBook ? Icons.bookmark : Icons.bookmark_border),
              onPressed: () => ref.read(bookmarksProvider.notifier).toggle(art),
            ),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WebViewPage(url: art.url, title: art.title))),
          ),
        );
      },
    );
  }
}
