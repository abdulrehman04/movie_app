part of '../movie_details_view.dart';

class MovieDetailAppBar extends StatelessWidget {
  const MovieDetailAppBar({
    super.key,
    this.onWatchTrailer,
    required this.poster,
    required this.releaseDate,
  });

  final String poster, releaseDate;
  final void Function()? onWatchTrailer;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 0.6.sh,
      stretch: true,
      pinned: true,
      title: TextWidgets.generalText(
        'Watch',
        fontSize: 20,
        color: AppColors.whiteColor,
        fontWeight: FontWeight.w600,
      ),
      leading: context.canPop()
          ? GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: AppColors.whiteColor,
              ),
            )
          : null,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.blurBackground,
          StretchMode.zoomBackground,
        ],
        background: Stack(
          children: [
            Image.network(
              width: 1.sw,
              poster,
              fit: BoxFit.fitWidth,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withOpacity(0.3),
              ),
              alignment: Alignment.center,
            ),
            Positioned(
              bottom: 45,
              left: 15,
              right: 15,
              child: Column(
                children: [
                  TextWidgets.generalText(
                    releaseDate,
                    color: AppColors.whiteColor,
                    fontSize: 17,
                  ),
                  25.verticalSpace,
                  CustomLongButton(
                    title: 'Get Tickets',
                    buttonColor: Colors.blue[300],
                    borderColor: Colors.blue[300],
                    onTap: () {},
                  ),
                  15.verticalSpace,
                  CustomLongButton(
                    title: 'Watch Trailer',
                    buttonColor: Colors.transparent,
                    borderColor: Colors.blue[300],
                    onTap: onWatchTrailer,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
