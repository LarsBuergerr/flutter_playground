import 'package:myapp/model/hampter.dart';

import '../view/hampter_view.dart';

class HampterListControllerImpl extends HampterListController {
  HampterListControllerImpl() : super([]);

  @override
  void addHampter(Hampter hampter) {
    state = [...state, hampter];
  }

  @override
  void removeHampter(Hampter hampter) {
    state = state.where((Hampter h) => h != hampter).toList();
  }
}
