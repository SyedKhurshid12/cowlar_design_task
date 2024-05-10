import 'package:cowlar_design_task/bloc/bottom_nav_bloc/Bottom_nav_state.dart';
import 'package:cowlar_design_task/bloc/bottom_nav_bloc/bottom_nav_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  BottomNavBarBloc() : super(BottomNavBarStateLoaded(currentIndex: 0)) {
    on<TabTapped>((event, emit) async {
      emit((state as BottomNavBarStateLoaded)
          .copyWith(newcurrentIndex: event.index));
    });
  }
}
