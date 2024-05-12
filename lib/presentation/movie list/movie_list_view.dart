import 'dart:ui';

import 'package:cowlar_task/core/constants/app_colors.dart';
import 'package:cowlar_task/core/constants/strings.dart';
import 'package:cowlar_task/data/models/upcoming_movies_model.dart';
import 'package:cowlar_task/presentation/movie%20list/movie_list_vm.dart';
import 'package:cowlar_task/widgets/custom_box_shadow.dart';
import 'package:cowlar_task/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part './widgets/_movie_item.dart';

class MovieList extends ConsumerWidget {
  const MovieList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MovieListViewModel controller = ref.watch(movieListvmProvider);
    controller.getMovies();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watch'),
          actions: const [Icon(Icons.search)],
        ),
        body: ListView.builder(
          itemCount: controller.upcomingMovies.length,
          itemBuilder: (context, index) {
            UpcomingMovie movie = controller.upcomingMovies[index];
            return MovieItem(movie: movie);
          },
        ),
      ),
    );
  }
}
