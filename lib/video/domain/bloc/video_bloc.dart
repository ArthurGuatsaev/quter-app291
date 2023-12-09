import 'package:bloc/bloc.dart';
import 'package:quotex291/video/domain/models/video_model.dart';
import 'package:quotex291/video/domain/repository/video_repo.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository videoRepo;
  VideoBloc({required this.videoRepo}) : super(const VideoState()) {
    on<GetVideoEvent>(getVideo);
    on<ChangeIndexEvent>(changeIndex);
  }
  getVideo(GetVideoEvent event, Emitter<VideoState> emit) {
    final videos = videoRepo.videos ?? [];
    emit(state.copyWith(videos: videos));
  }

  changeIndex(ChangeIndexEvent event, Emitter<VideoState> emit) {
    emit(state.copyWith(index: event.index));
  }
}
