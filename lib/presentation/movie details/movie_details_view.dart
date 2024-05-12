import 'package:cowlar_task/presentation/movie%20details/movie_details_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetailsView extends ConsumerStatefulWidget {
  const MovieDetailsView({super.key, required this.movieId});
  final int movieId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MovieDetailsViewState();
}

class _MovieDetailsViewState extends ConsumerState<MovieDetailsView> {
  @override
  void initState() {
    super.initState();
    ref.read(movieDetailsViewModelProvider).init(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    MovieDetailsViewModel controller = ref.watch(movieDetailsViewModelProvider);
    return Container();
  }
}
