part of shu_epub.models;

class EpubNavigationHead extends Equatable {
  /// metadata about this NCX
  ///
  /// The only required meta is that which contains a content reference to the
  /// OPF unique ID. For backwards compatibility reasons, the value of the name
  /// of that meta remains `dtb:id`.
  final List<EpubNavigationMeta> metadata;

  const EpubNavigationHead({
    required this.metadata,
  });

  factory EpubNavigationHead.zero() {
    return EpubNavigationHead(metadata: []);
  }

  EpubNavigationHead copyWith({
    List<EpubNavigationMeta>? metadata,
  }) {
    return EpubNavigationHead(
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'metadata': metadata.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationHead.fromMap(Map<String, dynamic> map) {
    return EpubNavigationHead(
      metadata: List<EpubNavigationMeta>.from(
        map['metadata']?.map((x) => EpubNavigationMeta.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationHead.fromJson(String source) =>
      EpubNavigationHead.fromMap(json.decode(source));

  @override
  String toString() => 'EpubNavigationHead(metadata: $metadata)';

  @override
  List<Object> get props => [metadata];
}
