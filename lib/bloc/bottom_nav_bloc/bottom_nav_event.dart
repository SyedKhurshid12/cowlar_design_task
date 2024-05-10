
import 'package:meta/meta.dart';

@immutable
abstract class BottomNavBarEvent {}

class TabTapped extends BottomNavBarEvent {
  final int index;

  TabTapped(this.index);
}