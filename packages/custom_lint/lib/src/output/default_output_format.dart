import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:cli_util/cli_logging.dart';

import 'render_lints.dart';
import 'output_format.dart';

/// The default output format.
class DefaultOutputFormat implements OutputFormat {
  @override
  bool get sorted => true;

  @override
  void render({
    required Iterable<AnalysisError> errors,
    required Logger log,
    required Progress progress,
  }) {
    if (errors.isEmpty) {
      log.stdout('No issues found!');
      return;
    }

    for (final error in errors) {
      log.stdout(
        '  ${error.location.relativePath}:${error.location.startLine}:${error.location.startColumn}'
        ' • ${error.message} • ${error.code} • ${error.severity.name}',
      );
    }

    // Display a summary separated from the lints
    log.stdout('');
    final errorCount = errors.length;
    log.stdout('$errorCount issue${errorCount > 1 ? 's' : ''} found.');
  }
}
