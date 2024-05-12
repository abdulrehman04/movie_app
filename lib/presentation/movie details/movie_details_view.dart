import 'package:cowlar_task/presentation/movie%20details/movie_details_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetailsView extends ConsumerWidget {
  const MovieDetailsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MovieDetailsViewModel controller = ref.watch(movieDetailsViewModelProvider);
    return Container();
  }
}
