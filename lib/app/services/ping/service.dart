import 'dart:developer';

import 'package:get/get.dart';

import 'model.dart';
import 'repository.dart';

class PingService extends GetxController with StateMixin<Pong?> {
  final WelcomeRepository repository;

  PingService({WelcomeRepository? repository})
      : repository = repository ?? WelcomeRepository();

  final Rx<Pong?> _pong = Rx(null);

  Pong? get pong => _pong.value;

  Future<Pong?> ping() async {
    try {
      Pong data = await repository.getPong();
      _pong.value = data;
      return _pong.value;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
