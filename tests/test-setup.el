(require 'package)

(defvar org-present-remote/package-dependencies
  '(elnode org-present))

(package-initialize)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(package-refresh-contents)

(mapcar (lambda (package-name) (package-install package-name)) org-present-remote/package-dependencies)

