part of shu_epub.controllers;

/// Controller to parse the EPUB navigation XML document.
class EpubNavigationController {
  final XmlDocument xmlDocument;
  final XmlElement ncxElement;

  const EpubNavigationController._internal({
    required this.xmlDocument,
    required this.ncxElement,
  });

  factory EpubNavigationController.fromString(String json) {
    final stringList = json.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationController(data);
  }

  /// Create an instance of [EpubNavigationController] from the [Uint8List] data
  /// of the navigation XML document.
  factory EpubNavigationController(Uint8List ncxData) {
    final String content = convert.utf8.decode(
      ncxData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final ncxElement = xmlDocument
        .findElements('ncx', namespace: EpubNavigation.namespace)
        .firstOrNull;

    if (ncxElement == null) {
      throw EpubException('Malformed ncx file, could not find ncx element');
    }

    return EpubNavigationController._internal(
      xmlDocument: xmlDocument,
      ncxElement: ncxElement,
    );
  }

  String? getVersion() {
    return ncxElement.getAttribute('version');
  }

  String? getLanguage() {
    return ncxElement.getAttribute('xml:lang') ??
        ncxElement.getAttribute('lang');
  }

  EpubNavigationHead? getHead() {
    throw UnimplementedError();
  }

  EpubNavigationDocumentTitle? getDocTitle() {
    throw UnimplementedError();
  }

  List<EpubNavigationDocumentAuthor> getDocAuthors() {
    throw UnimplementedError();
  }

  EpubNavigationMap? getNavigationMap() {
    // final navMapElement = ncxElement.findElements('navMap').firstOrNull;
    // if (navMapElement == null) {
    //   return null;
    // }
    // return EpubNavigationMap.fromXmlElement(navMapElement);
    throw UnimplementedError();
  }

  EpubNavigationPageList? getPageList() {
    throw UnimplementedError();
  }

  List<EpubNavigationList> getNavigationLists() {
    throw UnimplementedError();
  }
}