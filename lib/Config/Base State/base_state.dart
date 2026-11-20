class BaseState<T> {
  final bool isLoading;
  final String? errMsg;
  final T? data;

  const BaseState({this.isLoading = false, this.errMsg, this.data});

    // Returns a copy, changing only the given fields
  // The error is cleared unless a new one is given
  BaseState<T> copyWith({bool? isLoading, String? errMsg, T? data}) {
    return BaseState<T>(
      isLoading: isLoading ?? this.isLoading,
      errMsg: errMsg,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [isLoading, errMsg, data];

}
