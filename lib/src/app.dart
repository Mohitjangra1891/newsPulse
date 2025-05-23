import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_news/src/common/splashScreen.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/theme.dart';
import 'core/theme/themeprovider.dart';
import 'features/bookmark/views/bookmarkPage.dart';
import 'features/news/views/newsPage.dart';


class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: LightTheme.themeData,
      darkTheme: DarkTheme.themeData,
      themeMode: themeMode,
      home: SplashScreen()
    );
  }
}

//
// class AppBottomNav extends ConsumerWidget {
//   const AppBottomNav({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final index = ref.watch(bottomNavProvider);
//     return BottomNavigationBar(
//       currentIndex: index,
//       onTap: (i) => ref.read(bottomNavProvider.notifier).state = i,
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.article),
//           label: 'News',
//         ),
//
//         BottomNavigationBarItem(
//           icon: Icon(Icons.bookmark),
//           label: 'Bookmarks',
//         ),
//       ],
//     );
//   }
// }
