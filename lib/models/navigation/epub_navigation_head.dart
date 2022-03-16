part of shu_epub.models;

class EpubNavigationHead extends Equatable {
  final List<EpubNavigationHeadMeta> metadata;

  const EpubNavigationHead({
    required this.metadata,
  });

  factory EpubNavigationHead.zero() {
    return EpubNavigationHead(
      metadata: [],
    );
  }

  EpubNavigationHead copyWith({
    List<EpubNavigationHeadMeta>? metadata,
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
      metadata: List<EpubNavigationHeadMeta>.from(
        map['metadata']?.map((x) => EpubNavigationHeadMeta.fromMap(x)),
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