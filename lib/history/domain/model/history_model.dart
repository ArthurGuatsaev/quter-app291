import 'package:isar/isar.dart';
part 'history_model.g.dart';

@collection
class HistoryModel {
  Id id = Isar.autoIncrement;
  String? title;
  DateTime? date;

  @ignore
  String get dateString {
    final month =
        '${date!.month}'.length < 2 ? '0${date!.month}' : '${date!.month}';
    final day = '${date!.day}'.length < 2 ? '0${date!.day}' : '${date!.day}';
    return '$day.$month.${date!.year}';
  }
}
