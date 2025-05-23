import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/bookmark/views/bookmarkPage.dart';
import 'features/news/views/newsPage.dart';

final bottomNavProvider = StateProvider<int>((ref) => 0);

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider);
    return Scaffold(
      body: [
        NewsPage(),
        BookmarksPage(),
      ][currentIndex],
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

class AppBottomNav extends ConsumerWidget {
  const AppBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(bottomNavProvider);
    return BottomNavigationBar(
      selectedIconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      selectedItemColor: Theme.of(context).primaryColor,
    // selectedFontSize: 16,
      currentIndex: index,
      onTap: (i) => ref.read(bottomNavProvider.notifier).state = i,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: 'News',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Bookmarks',
        ),
      ],
    );
  }
}
