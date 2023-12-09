import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:quotex291/loading/domain/model/failed_model.dart';
import 'package:quotex291/loading/domain/model/loading_model.dart';
import 'package:quotex291/loading/domain/repositories/check_repo.dart';
import 'package:quotex291/loading/domain/repositories/loading_repo.dart';
import 'package:quotex291/loading/domain/repositories/remote_confige.dart';
import 'package:quotex291/loading/domain/repositories/services_repo.dart';
// import 'package:quotex291/loading/view/ui/onboard/widgets/teleg_board.dart';
import 'package:quotex291/nav_manager.dart';
import 'package:quotex291/posts/repository/post_repo.dart';
import 'package:quotex291/video/domain/repository/video_repo.dart';

part 'load_event.dart';
part 'load_state.dart';

class LoadBloc extends Bloc<LoadEvent, LoadState> {
  final StreamController<VLoading> controller = StreamController();
  LoadingRepo? loadingRepo;
  FirebaseRemote? firebaseRemote;
  MyCheckRepo? checkRepo;
  VideoRepository? videoRepo;
  VServices? servicesRepo;
  VPostRepo? postRepo;
  LoadBloc({
    this.loadingRepo,
    this.firebaseRemote,
    this.checkRepo,
    this.postRepo,
    this.videoRepo,
    this.servicesRepo,
  }) : super(LoadState()) {
    controller.stream.listen(
      (event) {
        print(event);
        add(LoadingProgressEvent(event: event));
      },
    );
    on<OnBoardCheckEvent>(onOnboardInit);
    on<FirebaseRemoteInitEvent>(onFirebaseRemoteInit);
    on<CheckRepoInitEvent>(onCheckRepoInit);
    on<VideoRepoInitEvent>(onVideoRepoInit);
    on<LoadingProgressEvent>(onLoadingProgressEvent);
    on<ChangeOnbIndicatorEvent>(onChangeOnbIndicatorIndex);
    on<PostRepoInitEvent>(onPostRepoInit);
    on<SaveUrlEvent>(onSaveUrl);
  }
  onLoadingProgressEvent(
      LoadingProgressEvent event, Emitter<LoadState> emit) async {
    final loadList = [...state.loadingList];
    loadList.add(event.event);
    emit(state.copyWith(loadingList: loadList));
    if (loadList.length == VLoading.values.length - 13) {
      // final url = firebaseRemote?.url ?? 'https://youtube.com/';
      // final tg = firebaseRemote?.tg ?? 'https://telegram.com/';
      // if (state.loadingList.contains(VLoading.finanseModeTrue)) {
      //   if (state.loadingList.contains(VLoading.firstShowTrue)) {
      //     MyNavigatorManager.instance.finPush(url);
      //     MyNavigatorManager.instance.workBPush(tg);
      //   } else {
      //     MyNavigatorManager.instance.finPush(url);
      //     if (state.loadingList.contains(VLoading.tgTrue)) {
      //       MyNavigatorManager.instance.telegaPush(telegaParam(tg));
      //     }
      //   }
      // } else {
      //   if (state.loadingList.contains(VLoading.firstShowTrue)) {
      //     MyNavigatorManager.instance.homePush();
      //     MyNavigatorManager.instance.unworkBPush();
      //   } else {
      //     MyNavigatorManager.instance.homePush();
      //   }
      // }
      // this will need delete; - >
      if (state.loadingList.contains(VLoading.firstShowTrue)) {
        MyNavigatorManager.instance.homePush();
        MyNavigatorManager.instance.unworkBPush();
      } else {
        MyNavigatorManager.instance.homePush();
      }
    }
  }

  onOnboardInit(OnBoardCheckEvent event, Emitter<LoadState> emit) async {
    if (loadingRepo == null) return;
    try {
      await loadingRepo!.getIsFirstShow(controller: controller);
      // await loadingRepo!.isFinanseMode(
      //     isDead: event.isDead,
      //     controller: controller,
      //     isChargh: event.isChargh,
      //     isVpn: event.isVpn,
      //     procentChargh: event.procentChargh,
      //     udid: event.udid);
      // if (state.loadingList.contains(VLoading.finanseModeFalse)) {
      //   await servicesRepo!.logAmplitude();
      // }
    } catch (e) {
      emit(state.copyWith(
          status: StatusLoadState.failed,
          failed: const VFailed(message: 'No internet connection')));
    }
  }

  onFirebaseRemoteInit(
      FirebaseRemoteInitEvent event, Emitter<LoadState> emit) async {
    try {
      if (firebaseRemote == null) return;
      // await servicesRepo!.initApphud(controller: controller);
      // await servicesRepo!.initOneSignal(controller: controller);
      // await servicesRepo!.initAmplitude(controller: controller);
      // await firebaseRemote!.initialize(
      //     streamController: controller, userId: servicesRepo!.userId);
      // add(CheckRepoInitEvent(
      //   isDead: firebaseRemote!.isDead,
      // ));
    } catch (e) {
      emit(state.copyWith(
          status: StatusLoadState.failed,
          failed: const VFailed(message: 'No internet connection')));
    }
  }

  onCheckRepoInit(CheckRepoInitEvent event, Emitter<LoadState> emit) async {
    if (checkRepo == null) return;
    try {
      // await checkRepo!.checkBattery(streamController: controller);
      // await checkRepo!.checkVpn(streamController: controller);
      // await checkRepo!.checkDeviceInfo(streamController: controller);
      // add(OnBoardCheckEvent(
      //     isDead: event.isDead,
      //     isChargh: checkRepo!.isChargh ?? false,
      //     isVpn: checkRepo!.isVpn!,
      //     procentChargh: checkRepo!.procentChargh ?? 70,
      //     udid: checkRepo!.udid!));
    } catch (_) {}
  }

  onChangeOnbIndicatorIndex(
      ChangeOnbIndicatorEvent event, Emitter<LoadState> emit) {
    emit(state.copyWith(onboardIndex: event.index));
  }

  onSaveUrl(SaveUrlEvent event, Emitter<LoadState> emit) async {
    await firebaseRemote!.setLastUrl(lastUrl: event.url);
    emit(state.copyWith(url: event.url));
  }

  onVideoRepoInit(VideoRepoInitEvent event, Emitter<LoadState> emit) async {
    if (videoRepo == null) return;
    await videoRepo!.getVideo(controller: controller);
  }

  onPostRepoInit(PostRepoInitEvent event, Emitter<LoadState> emit) async {
    if (postRepo == null) return;
    await postRepo!.getNote(controller);
  }
}
