import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

const _defaultMessage = "An error happened";

class Failure {
  final String message;
  const Failure(this.message);

  factory Failure.fromAPIError(var e, StackTrace? trace) {
    debugPrint(e.toString());
    debugPrint(trace.toString());

    var message = _defaultMessage;
    if (e is String) message = e;
    if (e is SocketException) {
      message = "Please check your internet connection and try again";
    }
    if (e is TimeoutException) {
      message = "Connection timed out. Please try again";
    }
    return Failure(message);
  }

  factory Failure.fromError(var e, [StackTrace? trace]) =>
      Failure.fromAPIError(e, trace);

  bool get isDefaultMessage => message == _defaultMessage;
}
