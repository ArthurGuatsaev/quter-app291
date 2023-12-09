import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:quotex291/posts/model/note_model.dart';
import 'package:quotex291/posts/model/post_model.dart';
import 'package:quotex291/posts/repository/post_repo.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final VPostRepo postRepo;
  PostBloc({required this.postRepo}) : super(PostState()) {
    on<SaveNoteEvent>(onSaveNote);
    on<GetNotesEvent>(onGetNotes);
    on<DelNoteEvent>(onDelNote);
    on<UpdateNotesEvent>(onUpdateNotes);
    on<ChangeCurrentIdEvent>(onChangeVideoId);
    on<ResetNoteEvent>(onResetNote);
  }

  onSaveNote(SaveNoteEvent event, Emitter<PostState> emit) async {
    await postRepo.saveNote(note: event.note);
    await postRepo.getNoteUpdata();
    add(GetNotesEvent());
  }

  onResetNote(ResetNoteEvent event, Emitter<PostState> emit) async {
    await postRepo.reseteNote();
    await postRepo.getNoteUpdata();
    add(GetNotesEvent());
  }

  onGetNotes(GetNotesEvent event, Emitter<PostState> emit) async {
    if (postRepo.notes != null) {
      final notes = [...postRepo.notes!];
      emit(state.copyWith(notes: notes));
    }
  }

  onUpdateNotes(UpdateNotesEvent event, Emitter<PostState> emit) async {
    await postRepo.getNoteUpdata();
    final notes = postRepo.notes;
    emit(state.copyWith(notes: notes));
  }

  onDelNote(DelNoteEvent event, Emitter<PostState> emit) async {
    await postRepo.deleteNote(event.note);
    add(UpdateNotesEvent());
  }

  onChangeVideoId(ChangeCurrentIdEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(currentId: event.id));
  }
}
