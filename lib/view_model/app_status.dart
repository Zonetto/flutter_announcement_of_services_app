class Success extends Result {
  int? code;
  Object? response;
  Success({this.code, this.response});
}

class Error extends Result {
  int? code;
  Object? errorResponse;
  Error({this.code, this.errorResponse});
}

abstract class Result {}
