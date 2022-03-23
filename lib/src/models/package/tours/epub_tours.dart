part of shu_epub.models;

class EpubTours extends Equatable {
  final List<EpubSingleTour> items;

  const EpubTours({
    this.items = const [],
  });

  EpubTours copyWith({
    List<EpubSingleTour>? items,
  }) {
    return EpubTours(
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((item) => item.toMap()),
    };
  }

  factory EpubTours.zero() {
    return EpubTours(items: []);
  }

  factory EpubTours.fromMap(Map<String, dynamic> map) {
    return EpubTours(
      items:
          List<EpubSingleTour>.from(map['items']?.map(EpubSingleTour.fromMap)),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubTours.fromJson(String source) =>
      EpubTours.fromMap(json.decode(source));

  @override
  String toString() => 'EpubTours(items: $items)';

  @override
  List<Object> get props => [items];
}
