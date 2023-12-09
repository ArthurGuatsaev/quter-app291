import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quotex291/const/color.dart';
import 'package:quotex291/error/domain/bloc/error_bloc.dart';
import 'package:quotex291/firebase_options.dart';
import 'package:quotex291/history/domain/bloc/history_bloc.dart';
import 'package:quotex291/history/domain/model/history_model.dart';
import 'package:quotex291/history/domain/repository/hist_repo.dart';
import 'package:quotex291/home/domain/bloc/home_bloc.dart';
import 'package:quotex291/loading/domain/repositories/check_repo.dart';
import 'package:quotex291/loading/domain/repositories/loading_repo.dart';
import 'package:quotex291/loading/domain/repositories/remote_confige.dart';
import 'package:quotex291/loading/domain/repositories/services_repo.dart';
import 'package:quotex291/loading/view/bloc/load_bloc.dart';
import 'package:quotex291/nav_manager.dart';
import 'package:quotex291/posts/model/note_model.dart';
import 'package:quotex291/posts/repository/post_repo.dart';
import 'package:quotex291/posts/view/bloc/post_bloc.dart';
import 'package:quotex291/product/domain/bloc/prod_bloc.dart';
import 'package:quotex291/product/domain/model/product_model.dart';
import 'package:quotex291/product/domain/repository/product_repository.dart';
import 'package:quotex291/splash.dart';
import 'package:quotex291/video/domain/bloc/video_bloc.dart';
import 'package:quotex291/video/domain/repository/video_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final appDir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
      [ProductModelSchema, VNotesIssarSchema, HistoryModelSchema],
      directory: appDir.path);
  final StreamController<String> errorController = StreamController();
  // final StreamController<bool> pointController = StreamController();
  final error = ErrorBloc(errorController: errorController);
  final VideoRepository videoRepo = VideoRepository();
  final ProductRepository prodRepo =
      ProductRepository(isar: isar, errorController: errorController);
  final VServices services = VServices();
  final HistoryRepository histRepo = HistoryRepository(isar: isar);
  final VPostRepo postRepo =
      VPostRepo(errorController: errorController, isar: isar);
  final MyCheckRepo checkRepo = MyCheckRepo(errorController: errorController);
  final LoadingRepo onbordRepo = LoadingRepo(errorController: errorController);
  final FirebaseRemote firebaseRemote =
      FirebaseRemote(errorController: errorController);
  final navi = MyNavigatorManager.instance;
  final load = LoadBloc(
    videoRepo: videoRepo,
    postRepo: postRepo,
    servicesRepo: services,
    loadingRepo: onbordRepo,
    checkRepo: checkRepo,
    firebaseRemote: firebaseRemote,
  )
    ..add(FirebaseRemoteInitEvent())
    ..add(PostRepoInitEvent())
    ..add(OnBoardCheckEvent()) // this will need delete <-;
    ..add(VideoRepoInitEvent());

  runApp(
    MyApp(
      navi: navi,
      videoRepo: videoRepo,
      histRepo: histRepo,
      load: load,
      postRepo: postRepo,
      prodRepo: prodRepo,
      checkRepo: checkRepo,
      firebaseRemote: firebaseRemote,
      onbordRepo: onbordRepo,
      error: error,
    ),
  );
}

class MyApp extends StatelessWidget {
  final MyCheckRepo checkRepo;
  final LoadingRepo onbordRepo;
  final FirebaseRemote firebaseRemote;
  final MyNavigatorManager navi;
  final ProductRepository prodRepo;
  final VideoRepository videoRepo;
  final VPostRepo postRepo;
  final HistoryRepository histRepo;
  final LoadBloc load;
  final ErrorBloc error;
  const MyApp({
    super.key,
    required this.prodRepo,
    required this.postRepo,
    required this.histRepo,
    required this.videoRepo,
    required this.navi,
    required this.load,
    required this.error,
    required this.checkRepo,
    required this.onbordRepo,
    required this.firebaseRemote,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => checkRepo,
        ),
        RepositoryProvider(
          create: (context) => onbordRepo,
        ),
        RepositoryProvider(
          create: (context) => firebaseRemote,
        ),
        RepositoryProvider(
          create: (context) => videoRepo,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoadBloc>(
            create: (context) => load,
          ),
          BlocProvider<HistoryBloc>(
            lazy: false,
            create: (context) =>
                HistoryBloc(histRepo: histRepo)..add(GetHistoryEvent()),
          ),
          BlocProvider<ErrorBloc>(
            create: (context) => error,
          ),
          BlocProvider<VideoBloc>(
            lazy: false,
            create: (context) => VideoBloc(videoRepo: videoRepo),
          ),
          BlocProvider<PostBloc>(
            lazy: false,
            create: (context) => PostBloc(postRepo: postRepo),
          ),
          BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
          BlocProvider<ProdBloc>(
              lazy: false,
              create: (context) => ProdBloc(repository: prodRepo)
                ..add(GetProductEvent())
                ..add(InitLocalDataEvent())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navi.key,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
                backgroundColor: backgroundColor, elevation: 0),
            scaffoldBackgroundColor: backgroundColor,
            iconTheme: const IconThemeData(color: Colors.white),
            textTheme: const TextTheme(
              bodySmall: TextStyle(fontSize: 10),
              bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              labelSmall: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
              displaySmall: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300),
              displayMedium: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700),
              labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          onGenerateRoute: navi.onGenerateRoute,
          initialRoute: SplashPage.routeName,
        ),
      ),
    );
  }
}
