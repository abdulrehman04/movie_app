part of '../movie_list_view.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({super.key, required this.movie, this.onTap});

  final UpcomingMovie movie;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: (1.sh / 3) - 70,
        margin: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(
                    '${ApiUrls.imageBaseUrl}${movie.posterPath}',
                  ),
                  fit: BoxFit.fitWidth,
                ),
                boxShadow: [
                  customBoxShadow(0, 0, 5),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withOpacity(0.3),
              ),
              height: (1.sh / 3) - 70,
              alignment: Alignment.center,
            ),
            Positioned(
              bottom: 15,
              left: 15,
              child: TextWidgets.generalText(
                movie.title,
                color: AppColors.whiteColor,
                fontSize: 22,
              ),
            )
          ],
        ),
      ),
    );
  }
}
