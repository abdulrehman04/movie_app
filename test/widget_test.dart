import 'package:cowlar_task/data/models/movie_detail_model.dart';
import 'package:cowlar_task/data/models/movie_videos_model.dart';
import 'package:cowlar_task/data/models/response_model.dart';
import 'package:cowlar_task/data/models/upcoming_movies_model.dart';
import 'package:cowlar_task/data/repositories/movie_repo_impl.dart';
import 'package:cowlar_task/data/sources/local/database.dart';
import 'package:cowlar_task/data/sources/local/upcoming_movies_dao.dart';
import 'package:cowlar_task/data/sources/remote/movie_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'widget_test.mocks.dart';

part './_mock_data.dart';

@GenerateMocks([MovieRepoImpl, MovieDataSource, UpcomingMoviesDao])
class MockAppDatabase2 extends Mock implements AppDatabase {
  // mocking it locally to be able to able to provide stubbed MockUpcomingMoviesDao
  @override
  late MockUpcomingMoviesDao upcomingDao;

  MockAppDatabase2() {
    upcomingDao = MockUpcomingMoviesDao();
  }
}

void main() {
  group('Movie repo tests', () {
    late MovieRepoImpl movieRepo;
    late MockAppDatabase2 mockAppDatabase;
    late MockMovieDataSource mockMovieDataSource;

    setUp(() {
      mockAppDatabase = MockAppDatabase2();
      mockMovieDataSource = MockMovieDataSource();
      movieRepo = MovieRepoImpl(mockAppDatabase, mockMovieDataSource);
    });

    test('Fetch upcoming movies success', () async {
      when(mockMovieDataSource.fetchUpcomingMovies(any))
          .thenAnswer((realInvocation) {
        return Future.value(
          ResponseModel(
            data: dummyUpcomingMovieResponse,
            hasError: false,
          ),
        );
      });
      final result = await movieRepo.fetchUpcomingMovies(1);

      expect(
        result,
        isA<ResponseModel<UpcomingMoviesModel>>(),
      ); // Check for Future type
      expect(result.data, isA<UpcomingMoviesModel>());
      expect(result.hasError, false);
    });

    test('Fetch upcoming movies fail', () async {
      when(mockMovieDataSource.fetchUpcomingMovies(2)).thenAnswer(
        (_) {
          return Future.value(
            ResponseModel(
              data: null,
              hasError: true,
            ),
          );
        },
      );
      final result = await movieRepo.fetchUpcomingMovies(2);

      expect(
        result,
        isA<ResponseModel<UpcomingMoviesModel>>(),
      ); // Check for Future type
      expect(result.data, isA<Null>());
      expect(result.hasError, true);
    });

    test('Fetch upcoming movies success', () async {
      when(mockMovieDataSource.fetchUpcomingMovies(any)).thenAnswer(
        (_) {
          return Future.value(
            ResponseModel(
              data: dummyUpcomingMovieResponse,
              hasError: false,
            ),
          );
        },
      );
      final result = await movieRepo.fetchUpcomingMovies(1);

      expect(
        result,
        isA<ResponseModel<UpcomingMoviesModel>>(),
      ); // Check for Future type
      expect(result.data, isA<UpcomingMoviesModel>());
      expect(result.hasError, false);
    });

    test('Fetch movie details success', () async {
      when(mockMovieDataSource.getMovieDetails(any)).thenAnswer(
        (_) {
          return Future.value(
            ResponseModel(
              data: dummyMoviDetailseResponse,
              hasError: false,
            ),
          );
        },
      );
      final result = await movieRepo.getMovieDetails(1);

      expect(
        result,
        isA<ResponseModel<MovieDetailModel>>(),
      );
      expect(result.data, isA<MovieDetailModel>());
      expect(result.hasError, false);
    });

    test('Fetch movie details failure', () async {
      when(mockMovieDataSource.getMovieDetails(any)).thenAnswer(
        (_) {
          return Future.value(
            ResponseModel(
              data: null,
              hasError: true,
            ),
          );
        },
      );
      final result = await movieRepo.getMovieDetails(1);

      expect(
        result,
        isA<ResponseModel<MovieDetailModel>>(),
      );
      expect(result.data, isA<Null>());
      expect(result.hasError, true);
    });

    test('Get movie videos success', () async {
      when(mockMovieDataSource.getMovieVideos(any)).thenAnswer(
        (_) {
          return Future.value(
            ResponseModel(
              data: dummyVideoResponse,
              hasError: false,
            ),
          );
        },
      );
      final result = await movieRepo.getMovieVideos(1);

      expect(
        result,
        isA<ResponseModel<MovieVideosModel>>(),
      );
      expect(result.data, isA<MovieVideosModel>());
      expect(result.hasError, false);
    });

    test('Get movie videos failure', () async {
      when(mockMovieDataSource.getMovieVideos(any)).thenAnswer(
        (_) {
          return Future.value(
            ResponseModel(
              data: null,
              hasError: true,
            ),
          );
        },
      );
      final result = await movieRepo.getMovieVideos(1);

      expect(
        result,
        isA<ResponseModel<MovieVideosModel>>(),
      );
      expect(result.data, isA<Null>());
      expect(result.hasError, true);
    });

    test('Get local upcoming videos', () async {
      when(mockAppDatabase.upcomingDao.getLocalMovies()).thenAnswer(
        (_) {
          return Future.value([
            UpcomingMovie.fromJson(dummyUpcomingMovie),
          ]);
        },
      );
      final result = await movieRepo.getSavedMovies();

      expect(
        result,
        isA<List<UpcomingMovie>>(),
      );
    });

    test('save local upcoming videos', () async {
      when(mockAppDatabase.upcomingDao.saveMovie(any)).thenAnswer(
        (_) {
          return Future.value();
        },
      );
      final result = await movieRepo.saveMovie(
        UpcomingMovie.fromJson(dummyUpcomingMovie),
      );

      expect(result, true);
    });
  });
}
