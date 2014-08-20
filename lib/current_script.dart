import 'dart:io';
import 'package:stack_trace/stack_trace.dart';
import 'package:path/path.dart' as path;

File currentScript() {
  Uri uri = new Trace.current(1).frames[0].uri;

  RegExp fileRe = new RegExp(r'^file://');
  RegExp packageRe = new RegExp(r'^package:');

  if (fileRe.hasMatch(uri.toString())) {
    return new File.fromUri(uri);
  } else if (packageRe.hasMatch(uri.toString())) {
    String filePath = path.absolute(uri.toString().replaceFirst(packageRe, 'packages/'));
    Uri fileUri = new Uri.file(filePath);

    return new File.fromUri(fileUri);
  } else {
    return null;
  }
}