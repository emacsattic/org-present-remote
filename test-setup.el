(require 'package)
(package-initialize)
(add-to-list 'package-archives (cons "melpa" "https://melpa.org/packages/"))
(package-refresh-contents)
(mapcar (lambda (package-name) (package-install package-name)) '(elnode org-present))

