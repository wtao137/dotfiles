;; (add-to-list 'load-path "~/.emacs.d/lisp/")
(setq package-archives '(("gnu"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa-stable" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/")))
(package-initialize) ;; You might already have this line
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (solarized-light)))
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(default-frame-alist (quote ((width . 100) (height . 45))))
 '(package-selected-packages
   (quote
    (auctex-latexmk nlinum rainbow-delimiters auctex org-bullets solarized-theme pyim evil)))
 '(preview-gs-options
   (quote
    ("-q" "-dNOSAFER" "-dDELAYSAFER" "-dNOPAUSE" "-DNOPLATFONTS" "-dPrinted" "-dTextAlphaBits=4" "-dGraphicsAlphaBits=4"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 95 :width normal))))
 '(variable-pitch ((t (:foundry "outline" :family "XHei iOS")))))

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'nlinum-mode)
;; disable toolbar
(tool-bar-mode -1)
;; (add-to-list 'default-frame-alist '(font . "Consolas"))
;; Set default font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "Microsoft YaHei" :height 98)))
(require 'pyim)
(require 'pyim-basedict) ; 拼音词库设置，五笔用户 *不需要* 此行设置
(pyim-basedict-enable)   ; 拼音词库，五笔用户 *不需要* 此行设置
(setq default-input-method "pyim")
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.
(setq TeX-PDF-mode t)
(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-method 'synctex)

(eval-after-load 'tex
  '(progn
     (add-to-list 'TeX-view-program-list '("SumatraPDF" ("SumatraPDF -reuse-instance" (mode-io-correlate " -forward-search %b %n -inverse-search \"C:\\home\\emacs\\bin\\emacsclientw --no-wait +%%l \\\"%%f\\\"\" ") " %o")))
     (assq-delete-all 'output-pdf TeX-view-program-selection)
     (add-to-list 'TeX-view-program-selection '(output-pdf "SumatraPDF"))))

;; Configuration for slime 
;; (setq inferior-lisp-program "sbcl")
;; (slime-setup '(slime-fancy slime-tramp slime-asdf))
;; (slime-require :swank-listener-hooks)

;; Configuration for evil
(require 'evil)
(evil-mode t)
(setq evil-default-state 'emacs)
(define-key evil-emacs-state-map (kbd "C-o") 'evil-execute-in-normal-state)
(defun evil-insert-esc ()
  (interactive)
  (let* ((initial-key ?j)
         (final-key ?j)
         (timeout 0.5)
         (event (read-event nil nil timeout)))
    (if event
        ;; timeout met
        (if (and (characterp event) (= event final-key))
            (evil-normal-state)
          (insert initial-key)
          (push event unread-command-events))
      ;; timeout exceeded
      (insert initial-key))))

(define-key evil-insert-state-map (kbd "j") 'evil-insert-esc)
