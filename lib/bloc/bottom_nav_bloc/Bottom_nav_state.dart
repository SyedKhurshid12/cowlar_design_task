import 'package:cowlar_design_task/models/movie_detail_model.dart';
import 'package:meta/meta.dart';


@immutable
abstract class BottomNavBarState {}
class  BottomNavBarInitialState extends BottomNavBarState {}



class BottomNavBarStateLoaded extends BottomNavBarState {
  int currentIndex = 0;


  BottomNavBarStateLoaded({required this.currentIndex});

  BottomNavBarStateLoaded copyWith({
    int? newcurrentIndex,

  }) {
    return BottomNavBarStateLoaded(
        currentIndex: newcurrentIndex ?? this.currentIndex,

    );
  }
}
