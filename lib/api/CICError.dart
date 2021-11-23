class CICError {
  final _message;
  final _prefix;

  CICError([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataError extends CICError {
  FetchDataError([String message = ""])
      : super(message, "Error During Communication: ");
}

class BadRequestError extends CICError {
  BadRequestError([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedError extends CICError {
  UnauthorisedError([message]) : super(message, "Unauthorised: ");
}

class InvalidInputError extends CICError {
  InvalidInputError([String message = ""]) : super(message, "Invalid Input: ");
}
