import 'dart:developer';

import 'package:get/get.dart';

import 'model.dart';
import 'repository.dart';

class PingService extends GetxController with StateMixin<Pong?> {
  final WelcomeRepository repository;

  PingService({WelcomeRepository? repository})
      : repository = repository ?? WelcomeRepository();

  final Rx<Pong?> _welcome = Rx(null);

  Pong? get welcome => _welcome.value;

  Future<Pong?> ping() async {
    try {
      Pong data = await repository.getPong();
      _welcome.value = data;
      return _welcome.value;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}