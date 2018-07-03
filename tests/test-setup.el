(require 'package)

(defvar org-present-remote/package-dependencies
  '(elnode org org-plus-contrib org-present))

(package-initialize)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(package-refresh-contents)

(mapcar (lambda (package-name) (package-install package-name)) org-present-remote/package-dependencies)

(require 'org)

(message (format "Emacs %s" emacs-version))
(message (format "org %s" org-version))
(message (format "org in %s" (locate-library "org")))
