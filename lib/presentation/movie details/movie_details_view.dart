import 'package:cowlar_task/core/constants/app_colors.dart';
import 'package:cowlar_task/core/constants/strings.dart';
import 'package:cowlar_task/core/routes/route_names.dart';
import 'package:cowlar_task/presentation/movie%20details/movie_details_vm.dart';
import 'package:cowlar_task/widgets/button_widgets/custom_long_button.dart';
import 'package:cowlar_task/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

part './widgets/_app_bar.dart';

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
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          MovieDetailAppBar(
            poster: '${ApiUrls.imageBaseUrl}${controller.movie.posterPath}',
            releaseDate:
                'In Theatres ${DateFormat('MMM dd, yyyy').format(controller.movie.releaseDate)}',
            onWatchTrailer: () {
              context.push(
                RouteNames.instance.videoPlayer,
                extra: {'movieId': controller.movie.id},
              );
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidgets.headingWidget('Genres'),
                  10.verticalSpace,
                  Wrap(
                    spacing: 7,
                    runSpacing: 10,
                    children: controller.movie.genres.map((e) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(55),
                          color: Colors.lightGreen,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 15,
                        ),
                        child: TextWidgets.generalText(e.name),
                      );
                    }).toList(),
                  ),
                  10.verticalSpace,
                  Divider(
                    color: Colors.grey[300],
                  ),
                  15.verticalSpace,
                  TextWidgets.headingWidget('Overview'),
                  10.verticalSpace,
                  TextWidgets.generalText(
                    controller.movie.overview,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
