import 'dart:io' as io;

import 'package:shu_epub/controllers/controllers.dart';
import 'package:shu_epub/models/models.dart';
import 'package:test/test.dart';

void main() {
  late EpubNavigationController sut;

  setUpAll(() async {
    final data =
        await io.File('test/assets/Guardians/OEBPS/toc.ncx').readAsBytes();
    sut = EpubNavigationController(data);
  });

  group('getVersion', () {
    test(
      'on input and version attribute exists, expect a non null String',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" version="2005-1" xml:lang="en-US"></ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final version = controller.getVersion();

        expect(
          version,
          isNotNull,
          reason:
              'Version should be a non null value if version attribute exists',
        );
      },
    );
    test(
      'on input and version attribute does not exist, expect null',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" xml:lang="en-US"></ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final version = controller.getVersion();

        expect(
          version,
          isNull,
          reason: 'Version should be null if version attribute does not exist',
        );
      },
    );
  });

  group('getLanguage', () {
    test(
      'on input with xml:lang attribute, expect a non null String',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" xml:lang="en-US"></ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final language = controller.getLanguage();

        expect(
          language,
          isNotNull,
          reason: 'Language should not be null if xml:lang attribute exists',
        );
      },
    );
    test(
      'on input with lang attribute, expect a non null String',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/" lang="en-US"></ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final language = controller.getLanguage();

        expect(
          language,
          isNotNull,
          reason: 'Language should not be null if lang attribute exists',
        );
      },
    );
    test(
      'on input without xml:lang attribute, expect null',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/"></ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final language = controller.getLanguage();

        expect(
          language,
          isNull,
          reason:
              'Language should be null if both lang and xml:lang attribute do not exist',
        );
      },
    );
  });

  group('getHead', () {
    test(
      'on input without head, expect a null value',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final head = controller.getHead();

        expect(
          head,
          isNull,
          reason: 'Head should be null if the head element does not exist',
        );
      },
    );

    test(
      'on input with head, expect a non null value',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <head></head>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final head = controller.getHead();

        expect(
          head,
          isNotNull,
          reason: 'Head should be a non null value if the head element exists',
        );
      },
    );

    test(
      'on input with head and one meta element, expect meta list with one item of the same values',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <head>
    <meta content="org-example-5059463624137734586" name="dtb:uid"/>
  </head>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationMeta(
            content: 'org-example-5059463624137734586',
            name: 'dtb:uid',
          ),
        ];
        final head = controller.getHead();

        expect(
          head?.metadata,
          expectedValue,
          reason:
              'Head\'s metadata list should have the expected EpubNavigationMeta object',
        );
      },
    );

    test(
      'on input with head and no meta elements, expect an empty list',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <head>
  </head>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final head = controller.getHead();

        expect(
          head?.metadata,
          isEmpty,
          reason:
              'Head\'s metadata field should be an empty list if there are no meta elements',
        );
      },
    );
  });

  group('getDocTitle', () {
    test(
      'on input and docTitle exists, expect a non null value',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <docTitle>
  </docTitle>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final docTitle = controller.getDocTitle();

        expect(
          docTitle,
          isNotNull,
          reason:
              'EpubNavigationDocumentTitle should not be null if the docTitle element exists',
        );
      },
    );

    test(
      'on input and docTitle exists with no text children, expect text to be null',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <docTitle>
  </docTitle>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final docTitle = controller.getDocTitle();

        expect(
          docTitle?.text,
          isNull,
          reason: 'text should be null if the no text element does not exists',
        );
      },
    );

    test(
      'on input and docTitle exists with one text element child, text should be a non null value',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <docTitle>
    <text>Selections from "Great Pictures, As Seen and Described by Famous Writers"</text>
  </docTitle>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final docTitle = controller.getDocTitle();

        expect(
          docTitle?.text,
          isNotNull,
          reason: 'text should not be null if the text element does exists',
        );
      },
    );
  });

  group('getDocAuthors', () {
    test(
      'on input without docAuthor elements, expect empty list',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final docAuthors = controller.getDocAuthors();

        expect(
          docAuthors,
          isEmpty,
          reason: 'List should be empty if there are no docAuthor elements',
        );
      },
    );

    test(
      'on input with one docAuthor element, expect a list of length 1 with it',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <docAuthor>
      <text>Esther Singleton</text>
  </docAuthor>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationDocumentAuthor(text: 'Esther Singleton'),
        ];
        final docAuthors = controller.getDocAuthors();

        expect(
          docAuthors,
          expectedValue,
          reason: 'List should have the corresponding author object',
        );
      },
    );

    test(
      'on input with three docAuthor elements, expect a list of length 3 with them in order',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <docAuthor>
      <text>Esther Singleton</text>
  </docAuthor>
  <docAuthor>
      <text>Author 2</text>
  </docAuthor>
  <docAuthor>
      <text>Author 3</text>
  </docAuthor>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationDocumentAuthor(text: 'Esther Singleton'),
          EpubNavigationDocumentAuthor(text: 'Author 2'),
          EpubNavigationDocumentAuthor(text: 'Author 3'),
        ];
        final docAuthors = controller.getDocAuthors();

        expect(
          docAuthors,
          expectedValue,
          reason: 'List should have the corresponding author objects',
        );
      },
    );

    test(
      'on input with a docAuthor element without a text element, expect a list of length 1 with the item having null text',
      () async {
        final input = '''
<ncx xmlns="http://www.daisy.org/z3986/2005/ncx/">
  <docAuthor>
  </docAuthor>
</ncx>
''';
        final controller = EpubNavigationController.fromString(input);
        final expectedValue = [
          EpubNavigationDocumentAuthor(),
        ];
        final docAuthors = controller.getDocAuthors();

        expect(
          docAuthors.first.text,
          expectedValue,
          reason: 'List should have the author object with a null text value',
        );
      },
    );
  });

  group('getNavigationMap', () {
    test(
      'Returns with navigation points',
      () async {
        final navigationMap = sut.getNavigationMap();
        expect(navigationMap?.navigationPoints, isNotEmpty);
      },
    );

    test(
      'Returns with navigation no info list',
      () async {
        final navigationMap = sut.getNavigationMap();
        expect(navigationMap?.navigationInfoList, isNull);
      },
    );

    test(
      'Returns with navigation no labels',
      () async {
        final navigationMap = sut.getNavigationMap();
        expect(navigationMap?.navigationLabels, isNull);
      },
    );

    test(
      'Returns navigation point\'s first item with labels',
      () async {
        final navigationMap = sut.getNavigationMap();

        expect(navigationMap?.navigationPoints.first.labels, isNotEmpty);
      },
    );

    test(
      'Returns navigation point\'s first item with id',
      () async {
        final navigationMap = sut.getNavigationMap();

        expect(navigationMap?.navigationPoints.first.id, isNotEmpty);
      },
    );

    test(
      'Returns navigation point\'s first item with playOrder as a number',
      () async {
        final navigationMap = sut.getNavigationMap();

        expect(navigationMap?.navigationPoints.first.playOrder, isNotNull);
        expect(navigationMap?.navigationPoints.first.playOrder, isNotNaN);
      },
    );
  });

  group('getPageList', () {
    test(
      'is null',
      () async {
        final pageList = sut.getPageList();
        expect(pageList, isNull);
      },
    );
  });

  group('getNavigationLists', () {
    test(
      'is empty',
      () async {
        final navLists = sut.getNavigationLists();
        expect(navLists, isEmpty);
      },
    );
  });
}
