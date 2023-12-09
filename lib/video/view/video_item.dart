import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotex291/const/color.dart';
import 'package:quotex291/posts/view/bloc/post_bloc.dart';
import 'package:quotex291/video/domain/bloc/video_bloc.dart';
import 'package:quotex291/video/domain/models/video_model.dart';
import 'package:quotex291/widgets/pop/modal_open_video.dart';

class VideoItem extends StatelessWidget {
  final int index;
  final VideoModel video;
  const VideoItem({super.key, required this.video, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: bgSecondColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              context.read<VideoBloc>().add(ChangeIndexEvent(index: index));
              context.read<PostBloc>().add(ChangeCurrentIdEvent(id: video.id));
              showModalSheetVideoOpen(
                  context: context,
                  index: index,
                  tr: video,
                  textController: TextEditingController());
            },
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 120 / 80,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        video.image,
                        fit: BoxFit.fitHeight,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              video.title,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${video.duration}:00',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
