import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rappipay_test/feature/home/provider/movie_provider.dart';
import 'package:rappipay_ui/rappipay_ui.dart';

class HomeMobile extends ConsumerWidget {
  const HomeMobile({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieNotifier = ref.read(movieNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.grey1,
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.black,
        onTap: (value) {
          value != 0
              ? movieNotifier.getTopRatedMovies()
              : movieNotifier.getPopularMovies();
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Popular'),
          BottomNavigationBarItem(
              icon: Icon(Icons.movie_filter_rounded), label: 'Top Rated')
        ],
      ),
    );
  }
}
