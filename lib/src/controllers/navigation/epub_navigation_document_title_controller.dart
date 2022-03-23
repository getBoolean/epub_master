part of shu_epub.controllers;

class EpubNavigationDocumentTitleController {
  final XmlElement docTitleElement;

  static const elementName = 'docTitle';

  const EpubNavigationDocumentTitleController._internal({
    required this.docTitleElement,
  });

  /// Throws [EpubException] if the docTitle element is not the root node
  factory EpubNavigationDocumentTitleController.fromXmlElement(
      XmlElement docTitleElement) {
    if (docTitleElement.name.qualified != elementName) {
      throw EpubException(
        'Invalid data, expected $elementName to be the root node but it was not found',
      );
    }

    return EpubNavigationDocumentTitleController._internal(
      docTitleElement: docTitleElement,
    );
  }

  /// Create an instance of [EpubNavigationDocumentTitleController] from the [String] representation
  /// of the navMap element
  ///
  /// Throws [EpubException] if the string does not have the navMap element
  factory EpubNavigationDocumentTitleController.fromString(
      String docTitleString) {
    final stringList = docTitleString.codeUnits;
    final data = Uint8List.fromList(stringList);
    return EpubNavigationDocumentTitleController(data);
  }

  /// Create an instance of [EpubNavigationDocumentTitleController] from the [Uint8List] data
  /// of the docTitle element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the docTitle element
  factory EpubNavigationDocumentTitleController(Uint8List docTitleData) {
    final String content = convert.utf8.decode(
      docTitleData,
      allowMalformed: true,
    );

    final xmlDocument = XmlUtils.parseToXmlDocument(content);
    final docTitleElement = xmlDocument.findElements('docTitle').firstOrNull;

    if (docTitleElement == null) {
      throw EpubException(
        'Malformed navigation file, could not find required $elementName element',
      );
    }

    return EpubNavigationDocumentTitleController.fromXmlElement(
      docTitleElement,
    );
  }

  String? getId() {
    throw UnimplementedError();
  }

  String? getLanguage() {
    throw UnimplementedError();
  }

  EpubNavigationImage? getImage() {
    throw UnimplementedError();
  }

  String? getText() {
    throw UnimplementedError();
  }
}