(require 'package)

(package-initialize)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("gnu" . "https://elpa.gnu.org/packages/")))


(package-refresh-contents)
(mapcar #'package-install '(org-plus-contrib elnode fakir org-present package-lint s))

(require 'org)

(print (format "Emacs %s" emacs-version))
(print (format "org %s" org-version))
(print (format "org in %s" (locate-library "org")))
