part of shu_epub.models;

class EpubNavigationPageList extends Equatable {
  final String? id;
  final String? classType;
  
  final List<EpubNavigationInfo> navigationInfoList;
  final List<EpubNavigationLabel> navigationLabels;

  /// Should have at least one item
  final List<EpubNavigationPageTarget> pageTargets;
  
  const EpubNavigationPageList({
    this.id,
    this.classType,
    required this.navigationInfoList,
    required this.navigationLabels,
    required this.pageTargets,
  });

  EpubNavigationPageList copyWith({
    String? id,
    String? classType,
    List<EpubNavigationInfo>? navigationInfoList,
    List<EpubNavigationLabel>? navigationLabels,
    List<EpubNavigationPageTarget>? pageTargets,
  }) {
    return EpubNavigationPageList(
      id: id ?? this.id,
      classType: classType ?? this.classType,
      navigationInfoList: navigationInfoList ?? this.navigationInfoList,
      navigationLabels: navigationLabels ?? this.navigationLabels,
      pageTargets: pageTargets ?? this.pageTargets,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'classType': classType,
      'navigationInfoList': navigationInfoList.map((x) => x.toMap()).toList(),
      'navigationLabels': navigationLabels.map((x) => x.toMap()).toList(),
      'pageTargets': pageTargets.map((x) => x.toMap()).toList(),
    };
  }

  factory EpubNavigationPageList.fromMap(Map<String, dynamic> map) {
    return EpubNavigationPageList(
      id: map['id'],
      classType: map['classType'],
      navigationInfoList: List<EpubNavigationInfo>.from(map['navigationInfoList']?.map((x) => EpubNavigationInfo.fromMap(x)) ?? const []),
      navigationLabels: List<EpubNavigationLabel>.from(map['navigationLabels']?.map((x) => EpubNavigationLabel.fromMap(x)) ?? const []),
      pageTargets: List<EpubNavigationPageTarget>.from(map['pageTargets']?.map((x) => EpubNavigationPageTarget.fromMap(x)) ?? const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory EpubNavigationPageList.fromJson(String source) =>
      EpubNavigationPageList.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EpubNavigationPageList(id: $id, classType: $classType, navigationInfoList: $navigationInfoList, navigationLabels: $navigationLabels, pageTargets: $pageTargets)';
  }

  @override
  List<Object> get props {
    return [
      id ?? 'no id',
      classType ?? 'no classType',
      navigationInfoList,
      navigationLabels,
      pageTargets,
    ];
  }
}