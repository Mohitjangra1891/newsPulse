import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_news/src/features/news/views/newsPage.dart';

import '../../../common/webViewScreeen.dart';
import '../../news/controller/newsController.dart';
import '../../news/views/widget/newsCard.dart';
import '../controller/bookMarkController.dart';

// class BookmarksPage extends StatelessWidget {
//   const BookmarksPage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Bookmarks Page', style: Theme.of(context).textTheme.headlineMedium),
//     );
//   }
// }
/// Bookmarks Page
class BookmarksPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarksProvider);
    if (bookmarks.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Bookmarks')),
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            Icon(Icons.bookmarks_outlined ,size: 140,),
            Text('No Bookmarked News.' ,style: TextStyle(fontSize: 24),),
          ],
        )),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text('Bookmarks')),
      body: ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (c,i) {
          final art = bookmarks[i];
          return NewsCard(article: art);
        },
      ),
    );
  }
}
