(require 'checkdoc)
(require 'elnode)

(with-current-buffer (find-file "../org-present-remote.el")
  (checkdoc-current-buffer t)
  (package-lint-current-buffer))
