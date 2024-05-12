import 'package:cowlar_task/presentation/movie%20list/movie_list_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieList extends ConsumerWidget {
  const MovieList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MovieListViewModel controller = ref.watch(movieListvmProvider);
    controller.getMovies();
    return Scaffold(
      body: Center(child: Text('Movie list')),
    );
  }
}
