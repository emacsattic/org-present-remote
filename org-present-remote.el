;;; org-present-remote --- provides a Web remote control for org-present

;; Copyright © 2018 Duncan Bayne

;; Author: Duncan Bayne <duncan@bayne.id.au>
;; Version: 0.1
;; Package-Requires: (org-present elnode)
;; Keywords: org-present
;; URL: https://gitlab.com/duncan-bayne/org-present-remote

(require 'elnode)

;; the HTML displayed in the remote control web page
(defvar org-present-remote/html-template
  "<!doctype html>
   <html>
     <head>
       <meta charset='utf-8' />
       <title>%s</title> <!-- presentation name -->
       <style type='text/css'>
         h1 {
           font-size: 9vmin;
         }
         h2 {
           font-size: 7vmin;
         }
         body {
           font-size: 5vmin;
         }
         .next {
           float: right;
         }
         .prev {
           float: left;
         }
         .logo {
           text-align: center;
         }
         .next, .prev {
           font-size: 12vmin;
         }
         img.icon {
           height: 160px;
         }
       </style>
     </head>
     <body>
       <div class='next'><a href='/next'>Next</a></div>
       <div class='prev'><a href='/prev'>Prev</a></div>
       <div class='logo'><a href='http://orgmode.org/'><img class='icon' src='http://orgmode.org/img/org-mode-unicorn-logo.png' alt='org-mode' /></a></div>
       <hr>
       <h1>%s</h1> <!-- presentation name -->
       <h2>%s</h2> <!-- slide title -->
     </body>
   </html>")

;; the TCP/IP port on which to listen
(defvar org-present-remote/port 8009)

;; the buffer used by the remote
(defvar org-present-remote/remote-buffer)

;; the title of the remote page
(defvar org-present-remote/remote-title)

;; which remote control routes should be hooked up to which handlers
(defvar org-present-remote/routes
  '(("^.*//prev$" . org-present-remote/prev-handler)
    ("^.*//next$" . org-present-remote/next-handler)
    ("^.*//$" . org-present-remote/default-handler)))

(defun org-present-remote/html ()
  "Build the page HTML from the template and selected variables."
  (format org-present-remote/html-template
          (org-present-remote/html-escape (buffer-name org-present-remote/remote-buffer))
          (org-present-remote/html-escape (buffer-name org-present-remote/remote-buffer))
          (org-present-remote/html-escape org-present-remote/remote-title)))

(defun org-present-remote/prev-handler (httpcon)
  "Call org-present-prev when someone GETs /prev, and return the remote control page."
  (with-current-buffer org-present-remote/remote-buffer (org-present-prev))
  (elnode-http-start httpcon 200 '("Content-type" . "text/html"))
  (elnode-http-return httpcon (org-present-remote/html)))

(defun org-present-remote/next-handler (httpcon)
  "Call org-present-next when someone GETs /prev, and return the remote control page."
  (with-current-buffer org-present-remote/remote-buffer (org-present-next))
  (elnode-http-start httpcon 200 '("Content-type" . "text/html"))
  (elnode-http-return httpcon (org-present-remote/html)))

(defun org-present-remote/default-handler (httpcon)
  "Return the remote control page."
  (elnode-http-start httpcon 200 '("Content-type" . "text/html"))
  (elnode-http-return httpcon (org-present-remote/html)))

(defun org-present-remote/root-handler (httpcon)
  (elnode-hostpath-dispatcher httpcon org-present-remote/routes))

(defun org-present-remote/html-escape (str)
  "Escape significant HTML characters in 'str'.
Shamelessly lifted from https://github.com/nicferrier/elnode/blob/master/examples/org-present.el"
  (replace-regexp-in-string
   "<\\|\\&"
   (lambda (src)
     (cond
      ((equal src "&") "&amp;")
      ((equal src "<")  "&lt;")))
   str))

(defun org-present-remote/remote-set-title (name heading)
  "Set the title to display in the remote control."
  (setq org-present-remote/remote-title heading))

(defun org-present-remote/remote-on (host)
  "Turn the org-present remote control on."
  (interactive "sStart remote control for this buffer on host: ")
  (setq elnode-error-log-to-messages nil)
  (elnode-stop org-present-remote/port)
  (setq org-present-remote/remote-buffer (current-buffer))
  (add-hook 'org-present-after-navigate-functions 'org-present-remote/remote-set-title)
  (message (concatenate 'string "Starting org-present-remote server on " host))
  (elnode-start 'org-present-remote/root-handler :port org-present-remote/port :host host))

(defun org-present-remote/remote-off ()
  "Turn the org-present remote control off."
  (interactive)
  (elnode-stop org-present-remote/port)
  (setq org-present-remote/remote-buffer nil))

;; courtesy Xah Lee ( http://ergoemacs.org/emacs/modernization_elisp_lib_problem.html )
(defun org-present-remote/trim-string (string)
  "Remove whitespace (space, tab, emacs newline (LF, ASCII 10)) in beginning and ending of STRING."
  (replace-regexp-in-string
   "\\`[ \t\n]*" ""
   (replace-regexp-in-string "[ \t\n]*\\'" "" string)))
