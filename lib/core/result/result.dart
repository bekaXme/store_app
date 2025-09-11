class Result<T> {
  final T? data;
  final Exception? error;

  Result._({this.data, this.error});

  factory Result.success(T data) => Result._(data: data);
  factory Result.error(Exception error) => Result._(error: error);

  bool get isSuccess => error == null;

  T get value => data as T;

  get statusCode => null;



  R fold<R>({
    required R Function(Exception error) onError,
    required R Function(T data) onSuccess,
  }) {
    if (isSuccess) {
      return onSuccess(data as T);
    } else {
      return onError(error!);
    }
  }
}