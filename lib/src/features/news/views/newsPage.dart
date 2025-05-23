import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_news/src/common/splashScreen.dart';
import 'package:my_news/src/features/news/views/shimmerLoading.dart';
import 'package:my_news/src/features/news/views/widget/newsCard.dart';
import 'package:my_news/src/features/search/searchScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app.dart';
import '../../../common/webViewScreeen.dart';
import '../../../core/theme/themeprovider.dart';
import '../../../modals/articleModal.dart';
import '../../bookmark/controller/bookMarkController.dart';
import '../controller/newsController.dart';

// class NewsPage extends StatelessWidget {
//   const NewsPage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('News Page', style: Theme.of(context).textTheme.headlineMedium),
//     );
//   }
// }



class NewsPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage>    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 👈 Keeps this widget alive

  @override
  Widget build(BuildContext context) {
    super.build(context); // 👈 Important: call super.build

    final articlesAsync = ref.watch(articlesProvider);

    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color:           Theme.of(context).primaryColor,
      ), // Change drawer icon color

        title: Text('News Pulse', style: TextStyle(

          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),),
        actions: [
          IconButton(
            icon:  Icon(Icons.search ,          color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SearchPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Invalidate the provider to trigger a refetch
          ref.invalidate(articlesProvider);
          await ref.read(articlesProvider.future);
        },
        child: articlesAsync.when(
          data: (articles) {
            final carouselItems = articles.take(5).toList();

            return SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider(

                    options: CarouselOptions(height: 200, autoPlay: true, enlargeCenterPage: true),
                    items: carouselItems.map((art) {
                      return Builder(builder: (ctx) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => WebViewPage(url: art.url, title: art.title),
                              ),
                            );
                          },
                          child: Stack(children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(art.urlToImage,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 200,
                                    errorBuilder: (c, o, s) => Container(    width: double.infinity,
                                        height: 200,color: Colors.grey[200], child: Icon(Icons.broken_image, size: 80)))),
                            Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                                        gradient: LinearGradient(
                                            colors: [Colors.transparent, Colors.black54], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                                    child: Text(art.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))))
                          ]),
                        );
                      });
                    }).toList(),
                  ),
                  SizedBox(height: 18,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];

                      return NewsCard(article: article);
                    },
                  ),
                ],
              ),
            );
          },
          loading: () => const NewsShimmerList(),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }
}

class drawer extends ConsumerWidget {
  const drawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    final themeNotifier = ref.read(themeNotifierProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(          color: Theme.of(context).primaryColor,
            ),
            child: Text('News Pulse', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),

          _settingTile(
            context: context,
              icon: themeMode != ThemeMode.dark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
              label: themeMode != ThemeMode.dark ? "Dark Mode" : "Light Mode",
              onPressed: () {
                themeNotifier.setTheme(themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
              },
              isDark: isDark),

          _settingTile(
            context: context,
              icon: Icons.login_outlined,
              label:"LogOut",
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('is_logged_in', false);
                // Navigate to splash screen and clear stack
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                      (Route<dynamic> route) => false, // Remove all previous routes
                );
              },
              isDark: isDark),
        ],
      ),
    );
  }

  Widget _settingTile({required BuildContext context,required bool isDark, required IconData icon, required String label, required VoidCallback onPressed}) {
    return Card(
      elevation: 0,
      color: isDark ? Colors.white12 : Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0), side: BorderSide(color: Colors.black54, width: 0.2)),
      child: ListTile(
        leading: Icon(icon, color:Theme.of(context).primaryColor),
        title: Text(label),
        onTap: onPressed, // Add navigation logic here
      ),
    );
  }
}