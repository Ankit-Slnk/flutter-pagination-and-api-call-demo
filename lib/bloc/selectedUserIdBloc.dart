import 'dart:async';
import 'package:rxdart/rxdart.dart';

class SelectedUserIdBloc {
  static SelectedUserIdBloc blocObj = SelectedUserIdBloc();
  static SelectedUserIdBloc get getBloc => getBloc;

  static final blocSubject = PublishSubject<int>();
  static Stream<int> get getSteam => blocSubject.stream;

  setSelectedUserId(int userId) async {
    blocSubject.sink.add(userId);
  }
}
