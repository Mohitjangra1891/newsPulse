import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../modals/articleModal.dart';
import '../repo/newsRepo.dart';

final newsRepoProvider = Provider<NewsRepository>((ref) => NewsRepository());

final articlesProvider = FutureProvider<List<Article>>((ref) async {
  final repo = ref.read(newsRepoProvider);
  return repo.fetchTopHeadlines();
});
final searchProvider = FutureProvider.family<List<Article>, String>((ref, query) {
  if (query.isEmpty) return Future.value([]);
  return ref.read(newsRepoProvider).searchByQuery(query);
});
