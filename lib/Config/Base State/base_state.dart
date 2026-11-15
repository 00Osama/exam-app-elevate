class BaseState<T> {
  final bool isLoading;
  final String? errMsg;
  final T? data;

  const BaseState({this.isLoading = false, this.errMsg, this.data});

  BaseState<T> copyWith({
    bool? isLoading,
    String? errMsg,
    T? data,
  }) {
    return BaseState<T>(
      isLoading: isLoading ?? this.isLoading,
      errMsg: errMsg ?? this.errMsg,
      data: data ?? this.data,
    );
  }
}
