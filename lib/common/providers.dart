import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view/hampter_view.dart';
import '../controller/hampter_controller.dart';
import '../model/hampter.dart';

final Providers providers = Providers();

class Providers {
  final StateNotifierProvider<HampterListController, List<Hampter>>
      hampterControllerProvider =
      StateNotifierProvider<HampterListController, List<Hampter>>(
          (StateNotifierProviderRef ref) => HampterListControllerImpl());
}
