// danger
warn("WIPだよ〜〜〜〜〜〜") if github.pr_title.include? "[WIP]"

// danger-flutter_lint
flutter_lint.only_modified_files = true
flutter_lint.report_path = "flutter_analyze_report.txt"
flutter_lint.lint(inline_mode: true)
