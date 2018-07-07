(require 'checkdoc)
(require 'elnode)
(require 'package-lint)

(with-current-buffer (find-file "org-present-remote.el")
  (checkdoc-current-buffer)
  (package-lint-current-buffer))
