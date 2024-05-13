import 'package:cowlar_task/core/constants/app_colors.dart';
import 'package:cowlar_task/core/constants/strings.dart';
import 'package:cowlar_task/core/routes/route_names.dart';
import 'package:cowlar_task/data/models/upcoming_movies_model.dart';
import 'package:cowlar_task/presentation/movie%20list/movie_list_vm.dart';
import 'package:cowlar_task/widgets/custom_box_shadow.dart';
import 'package:cowlar_task/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

part './widgets/_movie_item.dart';

class MovieList extends ConsumerStatefulWidget {
  const MovieList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieListState();
}

class _MovieListState extends ConsumerState<MovieList> {
  @override
  void initState() {
    super.initState();
    ref.read(movieListvmProvider).init();
  }

  @override
  Widget build(BuildContext context) {
    MovieListViewModel controller = ref.watch(movieListvmProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watch'),
          actions: const [Icon(Icons.search)],
        ),
        body: controller.isFetching
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: controller.getListLength,
                itemBuilder: (context, index) {
                  if (controller.shouldFetchMore(index)) {
                    controller.fetchMoreMovies();
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  UpcomingMovie movie = controller.upcomingMovies[index];
                  return MovieItem(
                    movie: movie,
                    onTap: () {
                      context.push(
                        RouteNames.instance.movieDetail,
                        extra: {'movieId': movie.id},
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
