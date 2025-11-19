import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../network/clients/cancel_token.dart';
import '../exceptions/exceptions.dart';
import 'connectivity/connection_manager.dart';

Future<void> upload({
  required String uploadUrl,
  required File imageFile,
  void Function(double)? uploadProgressFn,
  CancellationToken? cancelToken,
}) async {
  try {
    var hasConnectivity = await ConnectivityManager().call();
    if (!hasConnectivity) {
      throw const NetworkException();
    }

    uploadProgressFn?.call(0.25);
    List<int> imageBytes = imageFile.readAsBytesSync();

    await Dio().put(
      uploadUrl,
      data: imageBytes,
      options: Options(
        contentType:
            lookupMimeType(imageFile.path) ?? 'application/octet-stream',
        headers: {
          'Content-Length': imageFile.lengthSync().toString(),
        },
      ),
      cancelToken: cancelToken,
      onSendProgress: (int sent, int total) {
        // This doesn't work yet?
        // https://github.com/cfug/dio/issues/1835
        uploadProgressFn?.call(sent / total);
      },
    );

    uploadProgressFn?.call(1);
  } on DioException catch (e, _) {
    if (CancelToken.isCancel(e)) {
      debugPrint('Request canceled');
    }

    var statusCode = e.response?.statusCode ?? 0;
    if (statusCode >= 500) {
      throw ServerException(e.message);
    }

    debugPrint(e.toString());

    throw UnknownException(e.message);
  } catch (e, _) {
    debugPrint(e.toString());
    throw UnknownException(e.toString());
  }
}

Future<void> uploadInBytes({
  required String uploadUrl,
  required Uint8List imageBytes,
  void Function(double)? uploadProgressFn,
  CancellationToken? cancelToken,
}) async {
  try {
    var hasConnectivity = await ConnectivityManager().call();
    if (!hasConnectivity) {
      throw const NetworkException();
    }

    uploadProgressFn?.call(0.25);

    await Dio().put(
      uploadUrl,
      data: imageBytes,
      options: Options(
        contentType: 'application/octet-stream',
        headers: {
          'Content-Length': imageBytes.length.toString(),
        },
      ),
      cancelToken: cancelToken,
      onSendProgress: (int sent, int total) {
        // This doesn't work yet?
        // https://github.com/cfug/dio/issues/1835
        uploadProgressFn?.call(sent / total);
      },
    );

    uploadProgressFn?.call(1);
  } on DioException catch (e, _) {
    if (CancelToken.isCancel(e)) {
      debugPrint('Request canceled');
    }

    var statusCode = e.response?.statusCode ?? 0;
    if (statusCode >= 500) {
      throw ServerException(e.message);
    }

    debugPrint(e.toString());

    throw UnknownException(e.message);
  } catch (e, _) {
    debugPrint(e.toString());
    throw UnknownException(e.toString());
  }
}

Future<void> downloadImage({
  required String fileName,
  required String downloadUri,
  void Function(double)? downloadProgressFn,
  CancellationToken? cancelToken,
}) async {
  try {
    var hasConnectivity = await ConnectivityManager().call();
    if (!hasConnectivity) {
      throw const NetworkException();
    }

    final appDocDirectory = await _getAppDocDirectory();
    final finalVideoPath = path.join(appDocDirectory.path, "$fileName.png");

    await Dio().download(
      downloadUri,
      finalVideoPath,
      cancelToken: cancelToken,
      onReceiveProgress: (int sent, int total) {
        downloadProgressFn?.call(sent / total);
      },
    );
    downloadProgressFn?.call(1);

    await _saveDownloadedVideoToGallery(finalVideoPath);
    await _removeDownloadedVideo(finalVideoPath);
  } on DioException catch (e, _) {
    if (CancelToken.isCancel(e)) {
      debugPrint('Request canceled');
    }

    var statusCode = e.response?.statusCode ?? 0;
    if (statusCode >= 500) {
      throw ServerException(e.message);
    }

    debugPrint(e.toString());

    throw UnknownException(e.message);
  } catch (e, _) {
    debugPrint(e.toString());

    throw UnknownException(e.toString());
  }
}

Future<String> downloadFile({
  required String fileName,
  required String downloadUri,
  bool allowMultiple = false,
  void Function(double)? downloadProgressFn,
  CancellationToken? cancelToken,
}) async {
  try {
    var hasConnectivity = await ConnectivityManager().call();
    if (!hasConnectivity) {
      throw const NetworkException();
    }

    final appDocDirectory = await _getAppDocDirectory();
    final finalFilePath = await _getFilePath(
      fileName: fileName,
      downloadUri,
      appDocDirectory,
      allowMultiple: allowMultiple,
    );

    if (File(finalFilePath).existsSync()) {
      return finalFilePath;
    }

    await Dio().download(
      downloadUri,
      finalFilePath,
      cancelToken: cancelToken,
      onReceiveProgress: (int sent, int total) {
        downloadProgressFn?.call(sent / total);
      },
    );
    downloadProgressFn?.call(1);

    return finalFilePath;
  } on DioException catch (e, _) {
    if (CancelToken.isCancel(e)) {
      debugPrint('Request canceled');
    }

    var statusCode = e.response?.statusCode ?? 0;
    if (statusCode >= 500) {
      throw ServerException(e.message);
    }

    debugPrint(e.toString());

    throw UnknownException(e.message);
  } catch (e, _) {
    debugPrint(e.toString());

    throw UnknownException(e.toString());
  }
}

Future<int> getFileSize(String filePath) async {
  try {
    var hasConnectivity = await ConnectivityManager().call();
    if (!hasConnectivity) {
      return 0;
    }

    var res = await Dio().head(filePath);

    if (res.headers.map['content-length'] != null) {
      return int.parse(res.headers.map['content-length']![0]);
    }

    return 0;
  } on DioException catch (e, _) {
    if (CancelToken.isCancel(e)) {
      debugPrint('Request canceled');
    }

    var statusCode = e.response?.statusCode ?? 0;
    if (statusCode >= 500) {
      return 0;
    }

    debugPrint(e.toString());
    return 0;
  } catch (e, _) {
    debugPrint(e.toString());
    return 0;
  }
}

Future<Directory> _getAppDocDirectory() async {
  if (Platform.isIOS) {
    return getApplicationDocumentsDirectory();
  }

  return (await getExternalStorageDirectory())!;
}

Future<void> _saveDownloadedVideoToGallery(String path) async {
  await ImageGallerySaver.saveFile(path);
}

Future<void> _removeDownloadedVideo(String videoPath) async {
  try {
    Directory(videoPath).deleteSync(recursive: true);
  } catch (error, _) {
    debugPrint('$error');
  }
}

Future<String> _getFilePath(
  String fileUri,
  Directory dir, {
  String? fileName,
  bool allowMultiple = false,
}) async {
  String? localPath;

  String newPath = dir.path;
  if (Platform.isAndroid) {
    newPath = "${dir.path.split("Android")[0]}SparTrans";
  }

  final newDir = Directory(newPath);
  if (!newDir.existsSync()) {
    await newDir.create(recursive: true);
  }

  fileName ??= fileUri.split('/').last;
  final extension = path.extension(fileName);
  final fileNameWithoutExtension = path.basenameWithoutExtension(fileName);

  if (allowMultiple) {
    localPath = await _getUniqueFilePath(
        newDir, fileName, extension, fileNameWithoutExtension);
  } else {
    localPath = "${newDir.path}/$fileNameWithoutExtension$extension";
    log(extension);
  }

  return localPath;
}

Future<String> _getUniqueFilePath(
  Directory dir,
  String fileName,
  String extension,
  String fileNameWithoutExtension,
) async {
  int counter = 1;
  String uniqueFileName = fileName;

  while (await File("${dir.path}/$uniqueFileName").exists()) {
    uniqueFileName = "$fileNameWithoutExtension($counter)$extension";
    counter++;
  }

  return "${dir.path}/$uniqueFileName";
}

Future<String> getContentType(String filePath) async {
  try {
    var hasConnectivity = await ConnectivityManager().call();
    if (!hasConnectivity) {
      return 'application/octet-stream';
    }

    var res = await Dio().head(filePath);

    if (res.headers.map['content-type'] != null) {
      log('Content Type ${res.headers.map['content-type']?[0]}');
      return res.headers.map['content-type']![0];
    }

    return 'application/octet-stream';
  } on DioException catch (e, _) {
    if (CancelToken.isCancel(e)) {
      debugPrint('Request canceled');
    }

    var statusCode = e.response?.statusCode ?? 0;
    if (statusCode >= 500) {
      return 'application/octet-stream';
    }

    debugPrint(e.toString());
    return 'application/octet-stream';
  } catch (e, _) {
    debugPrint(e.toString());
    return 'application/octet-stream';
  }
}

void openFile(String filePath) async {
  await OpenFilex.open(filePath);
}

Future<void> openFileUrlDoc(String url) async {
  await launchUrlString(url);
}

Future<void> openUrl(String url) async {
  await launchUrlString(url);
}
