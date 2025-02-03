import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rappipay_test/app/routes/routes_names.dart';
import 'package:rappipay_test/feature/home/provider/movie_provider.dart';
import 'package:rappipay_ui/rappipay_ui.dart';

class MainDashboardMobile extends ConsumerWidget {
  MainDashboardMobile({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieState = ref.watch(movieNotifierProvider);
    final movieNotifier = ref.read(movieNotifierProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Column(
        children: [
          SizedBox(
            height: AppSpacing.md,
          ),
          Text(
            'Peliculas',
            style: UITextStyle.titles.title2Medium,
          ),
          SizedBox(
            height: AppSpacing.md,
          ),
          AppTextField(
            suffixIcon: Icons.search,
            controller: searchController,
            onChanged: (query) {
              if (query.length > 2) {
                movieNotifier.searchMovie(query);
              } else {
                movieNotifier.resetSearch();
              }
            },
          ),
          movieState.isLoading
              ? Center(child: CircularProgressIndicator())
              : movieState.error != null
                  ? Center(child: Text('Error: ${movieState.error!.message}'))
                  : Flexible(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: movieState.listMovie?.length ?? 0,
                        itemBuilder: (context, index) {
                          final data = movieState.listMovie?[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: BaseCard(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.network(
                                        data!.poster_path != null ? 'https://image.tmdb.org/t/p/w500${data.poster_path}' : '',
                                        height: MediaQuery.of(context).size.width / 2,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            ' ${data.title.toString()}',
                                            style: UITextStyle.paragraphs.paragraph1Regular,
                                          ),
                                          SizedBox(
                                            height: AppSpacing.lg,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: AppSpacing.lg,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 52,
                                    child: AppButton.primary(
                                        onPressed: () {
                                          context.go(RoutesNames.detail, extra: [
                                            data.title.toString(),
                                            data.poster_path != null ? 'https://image.tmdb.org/t/p/w500${data.poster_path}' : '',
                                            data.overview.toString(),
                                          ]);
                                        },
                                        title: 'Más sobre la pelicula...'),
                                  ),
                                  SizedBox(
                                    height: AppSpacing.lg,
                                  ),
                                ],
                              ),
                            )),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
