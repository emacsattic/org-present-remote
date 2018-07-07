(require 'checkdoc)
(require 'elnode)
(require 'package-lint)

(with-current-buffer (find-file "org-present-remote.el")
  (checkdoc-current-buffer))

(with-current-buffer (find-file "org-present-remote.el")
  (package-lint-current-buffer))
