class ApiModelKey {
  static const withIdKey = ' withId';
  static const withOwnerIdKey = ' withOwnerId';

  final String data;
  int? withId;
  int? withOwnerId;

  ApiModelKey({
    required this.data,
    this.withId,
    this.withOwnerId
  });

  @override 
  String toString() {
    String string = '${this.data}';
    string += (withId == null) ? '' : '$withIdKey $withId';
    string += (withOwnerId == null) ? '' : '$withOwnerIdKey $withOwnerId';
    return string;
  }

  ApiModelKey copyWith({
    String? data,
    int? withId,
    int? withOwnerId
  }) => ApiModelKey(
    data: data ?? this.data,
    withId: withId ?? this.withId,
    withOwnerId: withOwnerId ?? this.withOwnerId
  );
}