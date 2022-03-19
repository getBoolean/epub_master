import 'dart:io' as io;

import 'package:shu_epub/controllers/controllers.dart';
import 'package:shu_epub/utils/collection_utils.dart';
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
              'Language should be null if lang or xml:lang attribute does not exist',
        );
      },
    );
  });

  group('getHead', () {
    test(
      'on request, expect non empty meta list',
      () async {
        final head = sut.getHead();

        expect(
          head.metadata,
          isNotEmpty,
          reason: 'Head should have at least one element',
        );
      },
    );
  });

  group('getDocTitle', () {
    test(
      'on request, expect titles list not empty',
      () async {
        final docTitle = sut.getDocTitle();

        expect(
          docTitle.titles,
          isNotEmpty,
          reason: 'Document title should be provided',
        );
      },
    );
  });

  group('getDocAuthors', () {
    test(
      'returns the author',
      () async {
        final docAuthors = sut.getDocAuthors();

        expect(
          docAuthors,
          isNotEmpty,
          reason: 'This book provides the author',
        );

        expect(
          docAuthors.firstOrNull?.authors ?? [],
          isNotEmpty,
          reason: 'This book provides the author and should include it as text',
        );
      },
    );

    test(
      'returns the author with text',
      () async {
        final docAuthors = sut.getDocAuthors();

        expect(
          docAuthors.firstOrNull?.authors ?? [],
          isNotEmpty,
          reason: 'This book provides the author and should include it as text',
        );
      },
    );
  });

  group('getNavigationMap', () {
    test(
      'Returns with navigation points',
      () async {
        final navigationMap = sut.getNavigationMap();
        expect(navigationMap.navigationPoints, isNotEmpty);
      },
    );

    test(
      'Returns with navigation no info list',
      () async {
        final navigationMap = sut.getNavigationMap();
        expect(navigationMap.navigationInfoList, isNull);
      },
    );

    test(
      'Returns with navigation no labels',
      () async {
        final navigationMap = sut.getNavigationMap();
        expect(navigationMap.navigationLabels, isNull);
      },
    );

    test(
      'Returns navigation point\'s first item with labels',
      () async {
        final navigationMap = sut.getNavigationMap();

        expect(navigationMap.navigationPoints.first.labels, isNotEmpty);
      },
    );

    test(
      'Returns navigation point\'s first item with id',
      () async {
        final navigationMap = sut.getNavigationMap();

        expect(navigationMap.navigationPoints.first.id, isNotEmpty);
      },
    );

    test(
      'Returns navigation point\'s first item with playOrder as a number',
      () async {
        final navigationMap = sut.getNavigationMap();

        expect(navigationMap.navigationPoints.first.playOrder, isNotNull);
        expect(navigationMap.navigationPoints.first.playOrder, isNotNaN);
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
