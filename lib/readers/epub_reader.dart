import 'dart:typed_data';

import '../epub_master.dart';
import '../service/archive_service.dart';
import '../utils/file_utils.dart';

class EpubReader {
  const EpubReader();

  static Epub readBook(Uint8List bytes) {
    final archive = ArchiveService.decodeZip(bytes);
    final isEpub = FileUtils.isEpubFile(archive);
    if (!isEpub) {
      throw EpubException('File was not an EPUB');
    }

    final ContainerFile epubContainerFile = ContainerFile.read(archive);
    final PackageMetadata packageMetadata = PackageMetadata.read(archive);

    return Epub(
      packageMetadata: packageMetadata,
      containerFile: epubContainerFile,
    );
  }
}
