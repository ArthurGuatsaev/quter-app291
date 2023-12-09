import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:quotex291/const/color.dart';
import 'package:quotex291/posts/model/note_model.dart';
import 'package:quotex291/posts/view/bloc/post_bloc.dart';
import 'package:quotex291/video/domain/bloc/video_bloc.dart';
import 'package:quotex291/video/domain/models/video_model.dart';
import 'package:quotex291/video/view/video_player.dart';

Future showModalSheetVideoOpen({
  required BuildContext context,
  required VideoModel tr,
  required int index,
  required TextEditingController textController,
}) async {
  context.read<PostBloc>().add(GetNotesEvent());
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
          color: bgSecondColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Material(
        color: Colors.transparent,
        child: BlocBuilder<VideoBloc, VideoState>(
          buildWhen: (previous, current) =>
              previous.videos.length != current.videos.length,
          builder: (context, state) {
            if (state.videos.isEmpty) {
              return const SizedBox();
            }
            return SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: CustomScrollView(slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VideoPlayerWidget(video: state.videos[state.index]),
                        Container(
                          decoration: const BoxDecoration(
                              color: bgSecondColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${state.videos[state.index].duration}:00',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white.withOpacity(0.7)),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        state.videos[state.index].title,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        state.videos[state.index].description,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Colors.white.withOpacity(0.7)),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                              color: bgSecondColor),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Notes',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color:
                                                Colors.white.withOpacity(0.06),
                                          ),
                                          child: TextField(
                                            controller: textController,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            decoration: InputDecoration(
                                                hintText: 'Enter',
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.blue)),
                                                hintStyle: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.3)),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    borderSide: BorderSide(
                                                        color: Colors.white
                                                            .withOpacity(
                                                                0.12)))),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          if (textController.text.isEmpty) {
                                            return;
                                          }
                                          context.read<PostBloc>().add(
                                                SaveNoteEvent(
                                                  note: VNotesIssar()
                                                    ..iD = state
                                                        .videos[state.index].id
                                                    ..body = textController.text
                                                    ..date = DateTime.now(),
                                                ),
                                              );
                                          textController.clear();
                                        },
                                        child: Image.asset(
                                            'assets/images/notes_turn.png'),
                                      ),
                                    ],
                                  ),
                                  BlocBuilder<PostBloc, PostState>(
                                    buildWhen: (previous, current) =>
                                        previous.currentNotes.length !=
                                        current.currentNotes.length,
                                    builder: (context, state) {
                                      if (state.currentNotes.isEmpty) {
                                        return SizedBox(
                                          height: 300,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    'assets/images/notes_empty.png'),
                                                const SizedBox(height: 10),
                                                const SizedBox(height: 15),
                                                const Text(
                                                  'Empty',
                                                  style: TextStyle(
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white),
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                      "You don't have any added notes yet",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.7)),
                                                    )),
                                                  ],
                                                )
                                              ]),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  BlocBuilder<PostBloc, PostState>(
                    buildWhen: (previous, current) =>
                        previous.currentNotes != current.currentNotes,
                    builder: (context, state) {
                      return SliverList.builder(
                          itemCount: state.currentNotes.length,
                          itemBuilder: (context, index) {
                            final note = state.currentNotes[index];
                            return Container(
                              padding: const EdgeInsets.only(top: 10),
                              color: bgSecondColor,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => context
                                        .read<PostBloc>()
                                        .add(DelNoteEvent(note: note)),
                                    child: Image.asset(
                                      'assets/images/trash.png',
                                      width: 40,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white.withOpacity(0.06),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            note.dateString,
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          ConstrainedBox(
                                            constraints: BoxConstraints.loose(
                                                Size(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        74,
                                                    300)),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    note.body!,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      color: bgSecondColor,
                      height: 400,
                    ),
                  )
                ]),
              ),
            );
          },
        ),
      ),
    ),
  );
}

const _color = Color(0xFF576AD0);
