(require 'package)

(defvar org-present-remote/package-dependencies
  '(elnode org-present))

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)
(package-refresh-contents)

(mapcar (lambda (package-name) (package-install package-name)) org-present-remote/package-dependencies)

