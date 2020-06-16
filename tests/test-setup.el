(require 'package)

(package-initialize)

(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")))

(package-refresh-contents)
(mapcar #'package-install '(org-plus-contrib elnode org-present package-lint))

(require 'org)

(print (format "Emacs %s" emacs-version))
(print (format "org %s" org-version))
(print (format "org in %s" (locate-library "org")))
