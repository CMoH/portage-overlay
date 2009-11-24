;;; ini-mode site-lisp configuration

(setq load-path (cons "@SITELISP@" load-path))
(require 'ini-mode)
(setq auto-mode-alist
      (append
       (list (cons "\\.[iI][nN][iI]$" 'ini-mode)
	     (cons "\\.iss.*" 'ini-mode)
	     )
       auto-mode-alist))

