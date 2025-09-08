import '../../common/common.dart';
import 'add_notes.dart';

class AddNotesRoutes {
  static const String addNotes = '/addNotes';

  static List<GetPage> get getPages {
    return [
      GetPage(
        name: addNotes,
        page: () =>const AddNotePage(),
        transition: Transition.rightToLeft,
      ),
    ];
  }
}