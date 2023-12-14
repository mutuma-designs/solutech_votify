import 'dart:developer';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'context.dart';

extension FailureX on Failure {
  toMessage(BuildContext context) {
    var failure = this;

    if (failure is NetworkFailure) {
      return "Internet connection failed";
    }

    if (failure is ServerFailure) {
      return failure.message;
    }

    log("Unknown failure: $failure");

    return "Something went wrong"; //AppLocalizations.of(context).somethingWentWrong;
  }

  showSnackBar(BuildContext context) => context.showErrorSnackBar(
        toMessage(context),
      );
}
