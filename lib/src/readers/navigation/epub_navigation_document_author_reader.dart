part of shu_epub.readers;

class EpubNavigationDocumentAuthorReader {

  /// Create an [EpubNavigationDocumentAuthor] object from the docAuthor XmlElement.
  ///
  /// Throws [EpubException] if the docAuthor element is not the root node
  static EpubNavigationDocumentAuthor fromXmlElement(XmlElement docAuthorElement) {
    final controller = EpubNavigationDocumentAuthorController.fromXmlElement(docAuthorElement);
    return _fromController(controller);
  }

  static EpubNavigationDocumentAuthor fromString(String docAuthorString) {
    final controller = EpubNavigationDocumentAuthorController.fromString(docAuthorString);
    return _fromController(controller);
  }

  /// Create an instance of [EpubNavigationDocumentAuthor] from the [Uint8List] data
  /// of the docAuthor element in the navigation file.
  ///
  /// Throws [EpubException] if the data does not have the docAuthor element
  static EpubNavigationDocumentAuthor fromData(Uint8List docAuthorData) {
    final controller = EpubNavigationDocumentAuthorController(docAuthorData);
    return _fromController(controller);
  }

  static EpubNavigationDocumentAuthor _fromController(
    EpubNavigationDocumentAuthorController controller,
  ) {
    final id = controller.getId();
    final lang = controller.getLanguage();
    final text = controller.getText();
    final image = controller.getImage();

    return EpubNavigationDocumentAuthor(
      id: id,
      language: lang,
      text: text,
      image: image,
    );
  }
}