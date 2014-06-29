; -*- Emacs-Lisp -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; COPYRIGHT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; This file and the files distributed along with this file are totally free of
;;; use if they are not protected by any copyright rules present in the content
;;; of these files. You can modify, redistribute, copy part of this file or the
;;; files distributed along with this file without any restrictions if they are
;;; not protected by any copyright rules present in the content of these files.

;;; Parts of this file are copied or inspired by examples found of the Emacs
;;; Wiki at <http://www.emacswiki.org/>

;;; Sylvain Bougerel

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; GUIDE LINES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; This emacs configuration was made with ease of use, yet power in mind.

;;; I found too much of binding `C-x C-r C-f' not very pleasant to use as it
;;; bend my hands in very inconveniant direction.

;;; Abbrevs on the contrary are very intuitive tool. I often make many abbrev do
;;; the same thing. This empowers greatly my programming: it allows me to make
;;; mistakes and yet, understands what I want to do.

;;; This file also makes use of abbrev-swapping. In different context, you have
;;; different abbrevs working. In a comment, the code-only abbrev will not
;;; expand.

;;; In an attempt to automatise a maximum of stuffs, tags table are also visited
;;; automatically when I want to find a tag, auto-insertion is always activated,
;;; the general abbrev table provide an extensive auto-correction list, and a
;;; handful of programing design pattern are provided.

;;; To sum up this Emacs configuration is aimed at making life easy without
;;; having to memorize a pletora of command, yet retaining all the power of
;;; Emacs.

;;; This config is mainly targetted at C/C++ programmer, I am one myself and I
;;; grew this file over years in order to be proficiant at C/C++
;;; programming.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; TODOS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Complete auto-insert templates

;;; Complete tempo snippet with design patterns, in a separate

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; GENERAL SETTINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(server-start) ; start the server now.

(setq load-path
      (cons "~/.emacs.d/site-lisp/" load-path))

(require 'profiles)
(profile-define "others"
                "Sylvain Bougerel" "sylvain.bougerel.devel@gmail.com"
                'coding-style "gnu"
                'short-license '(my-insert-file-with-prefix
                                 "~/.emacs.d/licenses/gplv3")
                )
(profile-define "thales"
                "Sylvain Bougerel" "sylvain.bougerel@asia.thalesgroup.com"
                'coding-style "bsd" ; for compatibility with vi users
                'short-license '(my-insert-file-with-prefix
                                 "~/.emacs.d/licenses/thales")
                )
(profile-set-default "others")
(profile-load-path-alist)

;; do not display splash screen
(setq inhibit-startup-message t)

;; paste at point and not at cursor
(setq mouse-yank-at-point t)

;; read the compressed files
(auto-compression-mode 1)

;; ask "y or n" to confirm
(fset 'yes-or-no-p 'y-or-n-p)

;; fontifying everywhere
(global-font-lock-mode t)

;; mark is highlighted in blue
(transient-mark-mode t)

;; Title on the frame to the name of the current buffer
(setq frame-title-format "%b - Emacs")
(setq frame-icon-format "%b - Emacs")

;; Paren matching
(show-paren-mode t)
(setq show-paren-style "expression")

;; Disable forced trucation for side-by-side windows
(setq truncate-partial-width-windows nil)

;; Set visible bell on
(setq visible-bell t)

;; Mouse wheel support
(mouse-wheel-mode 1)

;; adios menubar
(menu-bar-mode -1)

;; I like abbrev
(setq default-abbrev-mode t)

;; Stand alone configuration
(set-foreground-color "wheat")
(set-background-color "dark slate gray")
(set-cursor-color "magenta")
(set-mouse-color "white")
(set-frame-font "DejaVu Sans Mono-9" t)

;; Frame-based (emacsclient) configuration
(add-to-list 'default-frame-alist '(foreground-color . "wheat"))
(add-to-list 'default-frame-alist '(cursor-color . "magenta"))
(add-to-list 'default-frame-alist '(mouse-color . "white"))
(add-to-list 'default-frame-alist '(background-color . "dark slate gray"))
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-9"))

;; Auto insertion on empty files
(require 'file-template)
(add-hook 'find-file-not-found-functions
          'file-template-find-file-not-found-hook 'append)
(setq file-template-insert-automatically t)
(setq file-template-paths '("~/.emacs.d/templates/"))
(setq file-template-search-current-dir nil)
(setq file-template-mapping-alist
      '(
        ("AUTHORS" . "authors.tmpl")
        ("\\.[Hh]\\'" . "cheader.tmpl")
        ("\\.h\\(pp\\|xx\\|\\+\\+\\)\\'" . "cheader.tmpl")
        ("\\.c\\'" . "cbody.tmpl")
        ("\\.c\\(pp\\|xx\\|\\+\\+\\)\\'" . "cppbody.tmpl")
        ("\\.C\\'" . "cppbody.tmpl")
        ("\\.xsd\\'" . "xsd.tmpl")
        ("\\.l\\'" . "lex.tmpl")
        ("\\.ll\\'" . "lex.tmpl")
        ("\\.l\\(pp\\|xx\\|\\+\\+\\)\\'" . "lex.tmpl")
        ("\\.y\\'" . "yacc.tmpl")
        ("\\.yy\\'" . "yacc.tmpl")
        ("\\.y\\(pp\\|xx\\|\\+\\+\\)\\'" . "yacc.tmpl")
        ))

;; Some other auto modes
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode)) ; more often C++...
(add-to-list 'auto-mode-alist '("README" . text-mode) t)
(add-to-list 'auto-mode-alist '("NEWS" . text-mode) t)
(add-to-list 'auto-mode-alist '("COPYING" . text-mode) t)
(add-to-list 'auto-mode-alist '("\\.l\\'" . c-mode) t)
(add-to-list 'auto-mode-alist '("\\.l\\(pp\\|xx\\|\\+\\+\\)\\'" . c++-mode) t)
(add-to-list 'auto-mode-alist '("\\.y\\(pp\\|xx\\|\\+\\+\\)\\'" . c++-mode) t)
(add-to-list 'auto-mode-alist '("\\.xsd\\'" . nxml-mode) t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; SKELETONS & TEMPO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Do not insert newline after skeleton insertation
(setq skeleton-end-hook nil)

(define-skeleton my-no-self-insert
  "No self insertion"
  ""
  >)
(put 'my-no-self-insert 'no-self-insert t)

(define-skeleton my-skel-c-main
  "Insert a main, cool..."
  ""
  "int main (int argc, char **argv, char **env)" >
  "\n{" > "\n" > _ "\n}" > "\n")
(put 'my-skel-c-main 'no-self-insert t)

(define-skeleton my-skel-c-if
  "Insert parenthesis after C style \`if\' construct"
  ""
  "if (" _ ")" >)
(put 'my-skel-c-if 'no-self-insert t)

(define-skeleton my-skel-c-for
  "Insert parenthesis after C style \`for\' construct"
  ""
  "for (" _ ")" >)
(put 'my-skel-c-for 'no-self-insert t)

(define-skeleton my-skel-c-while
  "Insert parenthesis after C \`while\' construct"
  "" "while (" _ ")" >)
(put 'my-skel-c-while 'no-self-insert t)

(define-skeleton my-skel-c-do-while
  "Insert a standard C style \`do while\' construct"
  "" "do" >)
(put 'my-skel-c-do-while 'no-self-insert t)

(define-skeleton my-skel-c-else
  "Insert a standard C style \`else\' construct"
  "" "else" >)
(put 'my-skel-c-else 'no-self-insert t)

(define-skeleton my-skel-c-else-if
  "Insert paranthesis in C \`else if\' construct"
  "" "else if (" _ ")" >)
(put 'my-skel-c-else-if 'no-self-insert t)

(define-skeleton my-skel-javadoc
  "Insert the brief and close the comment"
  "" "*" > "\n*  " > _ "\n*/" >)
(put 'my-skel-javadoc 'no-self-insert t)

(require 'tempo-snippets)
(define-key tempo-snippets-keymap [tab] 'tempo-snippets-next-field)
(define-key tempo-snippets-keymap [backtab] 'tempo-snippets-previous-field)
(define-key tempo-snippets-keymap "\r" 'tempo-snippets-clear-latest)
(setq tempo-snippets-grow-in-front t)

(defadvice tempo-define-template (after no-self-insert-in-abbrevs activate)
  "Skip self-insert if template function is called by an abbrev."
  (put (intern (concat "tempo-template-" (ad-get-arg 0))) 'no-self-insert t))

(tempo-define-snippet "c-for-it"
  '(> "for (" (p "Type: " type) "::iterator " (p "Iterator: " it) " = "
      (p "Container: " container) ".begin();" n >
      (s it) " != " (s container) ".end(); ++" (s it) ")" n "{" > n > n "}"
      >))

(tempo-define-snippet "c-unary-functor"
  '(" /**" > n "*  @brief  Unary functor " > n "*/" > n
    > "struct " (p "Name: " name) n "{" > n
    > (p "Return: " return) n >
    "operator() (const " (p "Type: " type) "& _p)" > n
    "{" > n > n "}" > n "};" >))

(tempo-define-snippet "c-binary-functor"
  '(" /**" > n "*  @brief  Binary functor " > n "*/" > n
    > "struct " (p "Name: " name) n "{" > n
    > (p "Return: " return) n >
    "operator() (const " (p "Type: " type) "& _a, const " (s type) "& _b)" > n
    "{" > n > n "}" > n "};" >))

(tempo-define-snippet "c-comparator"
  '(" /**" > n "*  @brief  Comparison functor " > n "*/" > n
    > "struct " (p "Name: " name) n "{" > n
    "bool operator() (const " (p "Type: " type) "& _a, const "
    (s type) "& _b)" > n "{" > n > n "}" > n "};" >))

(tempo-define-snippet "c-get-set"
  '(" /**" > n > "*  @name   " (p "Name: " name) > n
    "*  @brief  Accessors for the attribute `_m_" (s name) "'." > n
    "*  @see    _m_" (s name) > n "*/" > n " //@{" > n n " /**" > n
    "*  @brief  Read-only (constant) accessor." > n
    "*/" > n > "const " (p "Return: " ret) "& " (s name) " () const" > n
    "{ return _m_" (s name) "; }" > n n " /**" > n
    "*  @brief  Read/write accessor." > n "*/" > n > (s ret) "& " (s name)
    " ()" > n "{ return _m_" (s name) "; }" > n n " //@}" >))

(tempo-define-snippet "c-interface"
  '(" /**" > n "*  @brief  Interface " > n
    "*/" > n > "class " (p "Name: " name) n "{" > n "public:" > n
    " /**" > n "*  @brief  " > n "*/" > n
    "virtual " (p "Return: " ret) " " (p "Function: " fun) " (" p ") = 0;" > n n
    " /**" > n "*  @brief  Virtual desctructor required for polymorphism." > n
    "*/" > n "virtual ~" (s name) " ()" > n "{ }" > n "};" >))

(tempo-define-snippet "c-class"
  '(" /**" > n "*  @brief  Class " > n
    "*/" > n > "class " (p "Name: " name) n "{" > n
    "typedef " (s name) " self_type;" > n n "public:" > n
    " /**" > n "*  @brief  Default constructor " > n "*/" > n
    > (s name) " ()" > n "{" > n > n "}" > n
    n " /**" > n "*  @brief  Copy constructor " > n "*/" > n
    > (s name) " (const self_type& _s)" > n "{" > n > n "}" > n
    n " /**" > n "*  @brief  Assignment operator " > n "*/" > n
    "Self& operator= (const self_type& _s)" > n "{" >
    n "if (&_s != this)" > n "{" > n > n "}" > n
    "return *this;" > n "}" > n
    n "private:" > n n "};" >))

(tempo-define-snippet "c-noncopy-class"
  '("#include <boost/utility.hpp>" > n n
    " /**" > n "*  @brief  Class " > n
    "*/" > n > "class " (p "Name: " name) n
    ": boost::noncopyable" > n "{" > n "public:" > n " /**" > n
    "*  @brief  Default constructor " > n "*/" > n
    > (s name) " ()" > n "{" > n > n "}" > n
    n "private:" > n n "};" >))

(tempo-define-snippet "c-child-class"
  '(" /**" > n "*  @brief  Class " > n
    "*/" > n > "class " (p "Name: " name) n ":" >
    "public " (p "Parent: " parent) n "{" > n
    "typedef " (s name) " self_type;" > n
    "typedef " (s parent) " base_type;" > n n "public:" > n
    " /**" > n "*  @brief  Default constructor " > n "*/" > n
    > (s name) " ()" > n > ": Base()" > n "{" > n > n "}" > n
    n " /**" > n "*  @brief  Copy constructor " > n "*/" > n
    > (s name) " (const self_type& _s)" > n > ": base_type()" > n "{" > n > n "}" > n
    n " /**" > n "*  @brief  Assignment operator " > n "*/" > n
    "Self& operator= (const self_type& _s)" > n "{" >
    n "if (&_s != this)" > n "{" > n > n "}" > n
    "return *this;" > n "}" > n
    n "private:" > n n "};" >))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; UTILITIES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar my-key-swapped-p nil
  "Tell whether or not I swapped my keyboard: t if I did, nil otherwise.")

(defun my-swap-keyboard ()
  "Swap some keys of my keyboard.\nPresently: ?- and ?_ only are swapped."
  (interactive)
  (if my-key-swapped-p
      (progn
        (keyboard-translate ?_ ?_)
        (keyboard-translate ?- ?-)
        (setq my-key-swapped-p nil)
        (message "Keyboard restored")
        )
    (keyboard-translate ?_ ?-)
    (keyboard-translate ?- ?_)
    (setq my-key-swapped-p t)
    (message "Keyboard swapped")
    ))

(defun my-insert-file-with-prefix (filename &optional prefix)
  "Insert file FILENAME in the current buffer at point and fill
every paragraph with `fill-paragraph'.

Optional argument PREFIX must be a string or null. If null,
prefix is set to the content of string that is starts at
`point-at-bol' and finishes at `point'. After all occurrences of
new line, the content of PREFIX is inserted. This operation takes
place after insertion of the text and before calling
`fill-paragraph'."
  (interactive "fFile to insert: ")
  (unless (string-or-null-p prefix)
    (error "Argument prefix must be a string or null"))
  (save-excursion
    (save-restriction
      (narrow-to-region (point-at-bol) (point))
      (unless prefix (setq prefix (buffer-string)))
      (save-restriction
        (narrow-to-region (point) (point))
        (insert-file-contents filename)
        (save-match-data
          (goto-char (point-min))
          (while (re-search-forward "\n" nil t)
              (replace-match (concat "\n" prefix)))))
      )))

(defun my-next-eol ()
  "Move to the next blank eol."
  (interactive)
  (forward-paragraph)
  (end-of-line))
(byte-compile 'my-next-eol)

(defun my-prev-eol ()
  "Move to the previous blank eol."
  (interactive)
  (backward-paragraph)
  (unless (= (point) (line-end-position)) (backward-char)))
(byte-compile 'my-prev-eol)

(defun my-comment-context-p ()
  "Return true if we are in a comment context."
  (save-excursion
    (save-restriction
      (widen)
      (nth 4 (parse-partial-sexp (point-min) (point))))))
(byte-compile 'my-comment-context-p)

(defun my-string-context-p ()
  "Return true if we are in a string context."
  (save-excursion
    (save-restriction
      (widen)
      (nth 3 (parse-partial-sexp (point-min) (point))))))
(byte-compile 'my-string-context-p)

(defun my-coding-context-p ()
  "Return true if we are in a coding context."
  (save-excursion
    (save-restriction
      (widen)
      (let ((P (parse-partial-sexp (point-min) (point))))
        (and (null (nth 3 P))
             (null (nth 4 P)))))))
(byte-compile 'my-coding-context-p)

(defun my-javadoc-context-p ()
  "Return true if we are in the comment context and the line starts with either
  \"/**\" or \"*\"."
  (save-excursion
    (save-match-data
      (if (my-comment-context-p)
          (progn
            (beginning-of-line)
            (looking-at "[ \t]*\\(\\*\\)\\|\\(/\\*\\*\\)"))))))
(byte-compile 'my-javadoc-context-p)

(defun my-c-compactor ()
  "Compact a multi-line sequence of characters starting by '{' and
  finishing by '}' that is located around the point ('{' is searched
  backward while '}' is searched forward)"
  (interactive)
  (save-excursion
    (save-match-data
      (save-restriction
        (widen)
        (let ((INIT (point))
              (LVL 1)
              (BEG nil)
              (END nil))
          (while (and (/= LVL 0)
                      (re-search-backward "\\({\\)\\|\\(}\\)" (point-min) t))
            (if (my-coding-context-p)
                (cond ((= (char-after (point)) ?}) (setq LVL (1+ LVL)))
                      ((= (char-after (point)) ?{) (setq LVL (1- LVL))))))
          (if (/= LVL 0) (error "Not within a `{}' block")
            (setq BEG (point)) (goto-char INIT) (setq LVL 1)
            (while (and (/= LVL 0)
                        (re-search-forward "\\({\\)\\|\\(}\\)" (point-max) t))
              (if (my-coding-context-p)
                  (cond ((= (char-before (point)) ?}) (setq LVL (1- LVL)))
                        ((= (char-before (point)) ?{) (setq LVL (1+ LVL))))))
            (if (/= LVL 0) (error "Not within a `{}' block")
              (setq END (point)) (goto-char BEG)
              (narrow-to-region BEG END)
              (while (re-search-forward "[\n\r\t ]+" nil t)
                (replace-match " ")))))))))
(byte-compile 'my-c-compactor)

(defun my-javadoc-return (javadoc-margin)
  "Clear the blanks, insert new line and indent, insert '*', insert the
javadoc-margin."
  (while (or (= (char-before) 32) (= (char-before) 9)) ; 32: space, 9: tab
    (delete-char -1))
  (newline-and-indent)
  (insert (apply 'concat "*" (make-list javadoc-margin " ")))
  )
(byte-compile 'my-javadoc-return)

(defun my-at (pattern thenaction &optional elseaction)
  "Look if the previous characters match pattern, execute thenaction if pattern
  if found, or optional elseaction otherwise."
  (let ((OK nil))
    (save-excursion
      (backward-char (length pattern))
      (setq pattern (append pattern nil))
      (while (and pattern (< (point) (point-max)) (= (car pattern) (char-after)))
        (forward-char)
        (setq pattern (cdr pattern)))
      (if (null pattern) (setq OK t)
        (forward-char (length pattern))))
    (if OK (funcall thenaction)
      (if elseaction (funcall elseaction)))))
(byte-compile 'my-at)

(defun my-delete-indentation ()
  "Delete all the white space at the beginning of the line. And leave the cursor
  where it supposed to be in the text."
  (interactive "*")
  (let ((POS (point))
        (DIFFTXT 0)
        (COLS 0))
    (back-to-indentation)
    (setq DIFFTXT (- POS (point)))
    (setq POS (point))
    (setq COLS (current-column))
    (beginning-of-line)
    (delete-char (- POS (point)))
    ;; normalize with column
    (indent-to (* (/ (1- COLS) tab-width) tab-width))
    (if (> DIFFTXT 0) (forward-char DIFFTXT))
    ))
(byte-compile 'my-delete-indentation)

(defun my-rename (OLD NEW)
  "Rename a word by another word. Do not replace part of the word, replace either the all word or nothing."
  (interactive "*srename: \nsrename %s by: \n")
  (save-excursion
    (save-restriction
      (save-match-data
        (if mark-active (narrow-to-region (point) (mark)))
        (goto-char (point-min))
        (let ((case-fold-search nil) ;; case-sensitive search here!
              (COUNT 0)
              (REGEXP (concat "\\([^_a-zA-Z0-9]\\|^\\)" OLD "\\([^_a-zA-Z0-9]\\|$\\)" ))
              (REPLACE (concat "\\1" NEW "\\2")))
          (while (re-search-forward REGEXP (point-max) t)
            (when (my-coding-context-p)
              (replace-match REPLACE t nil)
              (setq COUNT (1+ COUNT))))
          (message "Renamed %d occurence(s)." COUNT))))))
(byte-compile 'my-rename)

(defun my-file-untabify ()
  "Change all tabs into spaces in a file"
  (interactive "*")
  (save-restriction
    (widen)
    (untabify (point-min) (point-max))
    ))
(byte-compile 'my-file-untabify)

(defadvice find-tag (before c-tag-file activate)
  "Automatically visit tags file when finding tags, and if in a GNU/Automake
project, automatically building tags."
  (let ((tag-file (concat default-directory "TAGS")))
    (unless (and (file-exists-p tag-file)
                 (file-exists-p (concat default-directory "Makefile.in"))
                 (file-exists-p (concat default-directory "Makefile")))
      (shell-command "make tags >/dev/null 2&>1"))
    (visit-tags-table tag-file)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; HOOKS SETTINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'text-mode-hook
          '(lambda ()
             (modify-syntax-entry ?_ "w")
             (auto-fill-mode 1)
             (setq fill-column 80)
             (define-mode-abbrev "emacs" "Emacs")
             ))

(add-hook 'change-log-mode-hook
          '(lambda ()
             (setq add-log-full-name (profile-current-name))
             (setq add-log-mailing-address (profile-current-mailing-address))
             (auto-fill-mode 1)
             (setq show-trailing-whitespace t)
             (define-mode-abbrev "emacs" "Emacs")
             ))

(define-abbrev-table 'my-javadoc-abbrev-table
  '(
;    ("@br" "@brief")
;    ("@au" "@author")
;    ("@pa" "@param")
;    ("@re" "@return")
;    ("@s" "@see")
;    ("@se" "@see")
;    ("@au" "@author")
;    ("@en" "@enum")
    ("emacs" "Emacs")
    )
  "The abbrev for java docs"
;  :regexp "\\<\\(\\w+\\)\\W"
  )

(add-hook 'c-mode-common-hook
          '(lambda ()
             (message "C mode common hook begin")
             (modify-syntax-entry ?_ "w")
             (local-set-key [?\C-x ?\C-.] 'find-file-at-point)
             (setq c-syntactic-indentation t)
             (c-toggle-hungry-state 1)
;            (c-toggle-auto-newline 1) ; eventually decided to turn it off
             (c-toggle-electric-state 1)
             (local-set-key "*" '(lambda ()
                                   (interactive)
                                   (my-at "/*" 'my-skel-javadoc
                                          '(lambda () (c-electric-star nil)))))
             (local-set-key "!" '(lambda ()
                                   (interactive)
                                   (my-at "/*" 'my-skel-javadoc
                                          '(lambda () (self-insert-command 1)))))
             (local-set-key "\r" '(lambda ()
                                    (interactive)
                                    (if (my-javadoc-context-p)
                                        (my-javadoc-return 2) (newline))))
             (c-set-style (profile-current-get 'coding-style))
             (setq indent-tabs-mode nil) ; non-nil tab, nil no-tabs
             (auto-fill-mode 1)
             (setq fill-column 80)
             (setq adaptive-fill-mode t)
             (setq show-trailing-whitespace t)
             (setq skeleton-further-elements '((abbrev-mode nil)))
             (define-abbrev local-abbrev-table "main" "" 'my-skel-c-main)
             (define-abbrev local-abbrev-table "imain" "" 'my-skel-c-main)
             (define-abbrev local-abbrev-table "intmain" "" 'my-skel-c-main)
             (define-abbrev local-abbrev-table "td" "typedef")
             (define-abbrev local-abbrev-table "ret" "return")
             (define-abbrev local-abbrev-table "rt" "return")
             (define-abbrev local-abbrev-table "vd" "void")
             (add-hook 'before-save-hook 'delete-trailing-whitespace)
             (add-hook 'before-save-hook 'my-file-untabify)
             (message "C mode common hook end")
             ))

(defun c-context-abbrev-expand-hook ()
  "Swap abbrev tables according to context"
  (if (looking-at "[ \t]*[\n\r]")
      (setq local-abbrev-table c-mode-abbrev-advancement-table)
    (if (my-string-context-p)
        (setq local-abbrev-table nil)
      (if (my-comment-context-p)
          (setq local-abbrev-table my-javadoc-abbrev-table)
        (setq local-abbrev-table c-mode-abbrev-table)))))

(add-hook 'c-mode-hook
          '(lambda ()
             (message "C mode hook begin")
             ;; swappy abbrevs for comments and advancement :)
;             (make-local-variable 'pre-abbrev-expand-hook)
;             (add-hook 'pre-abbrev-expand-hook 'c-context-abbrev-expand-hook)
             (define-abbrev-table 'c-mode-abbrev-advancement-table
               '(
                 ("for" "" my-skel-c-for)
                 ("wihle" "" my-skel-c-while)
                 ("whlie" "" my-skel-c-while)
                 ("while" "" my-skel-c-while)
                 ("if" "" my-skel-c-if)
                 ("else" "" my-skel-c-else)
                 ("elseif" "" my-skel-c-else-if)
                 ("elsif" "" my-skel-c-else-if)
                 ("elif" "" my-skel-c-else-if)
                 ("do" "" my-skel-c-do-while)
;                 ("#i" "#include")
;                 ("#in" "#include")
;                 ("#inc" "#include")
;                 ("#if" "#ifndef")
;                 ("#de" "#define")
;                 ("#ifd" "#ifdef")
;                 ("#e" "#endif")
                 )
               "The abbrev table for the C mode."
;               :regexp "\\<\\(\\w+\\)\\W*"
               '(:parents '(c-mode-abbrev-table)) ; inheritence property
               )
             (message "C mode hook end")
             ))

(defun c++-context-abbrev-expand-hook ()
  "Swap abbrev tables according to context"
  (if (looking-at "[ \t]*[\n\r]")
      (setq local-abbrev-table c++-mode-abbrev-advancement-table)
    (if (my-string-context-p)
        (setq local-abbrev-table nil)
      (if (my-comment-context-p)
          (setq local-abbrev-table my-javadoc-abbrev-table)
        (setq local-abbrev-table c++-mode-abbrev-table)))))

(add-hook 'c++-mode-hook
          '(lambda ()
             (message "C++ mode hook begin")
             ;; swappy abbrevs for comments and advancement :)
;             (make-local-variable 'pre-abbrev-expand-hook)
;             (add-hook 'pre-abbrev-expand-hook 'c++-context-abbrev-expand-hook)
             (define-abbrev local-abbrev-table "std" "std:")
             (define-abbrev local-abbrev-table "sd" "std:")
             (define-abbrev local-abbrev-table "sdt" "std:")
             (define-abbrev local-abbrev-table "thi" "this")
             (define-abbrev local-abbrev-table "thsi" "this")
             (define-abbrev local-abbrev-table "usname" "using namespace")
             (define-abbrev local-abbrev-table "usn" "using namespace")
             (define-abbrev local-abbrev-table "uns" "using namespace")
             (define-abbrev local-abbrev-table "namesp" "namespace")
             (define-abbrev local-abbrev-table "nsp" "namespace")
             (define-abbrev local-abbrev-table "co" "cout <<")
             (define-abbrev local-abbrev-table "ci" "cin >>")
             (define-abbrev local-abbrev-table "ce" "cerr >>")
             (define-abbrev local-abbrev-table "sc" "std::cout <<")
             (define-abbrev local-abbrev-table "sco" "std::cout <<")
             (define-abbrev local-abbrev-table "sout" "std::cout <<")
             (define-abbrev local-abbrev-table "scout" "std::cout <<")
             (define-abbrev local-abbrev-table "si" "std::cin >>")
             (define-abbrev local-abbrev-table "sci" "std::cin >>")
             (define-abbrev local-abbrev-table "scin" "std::cin >>")
             (define-abbrev local-abbrev-table "se" "std::cerr <<")
             (define-abbrev local-abbrev-table "sce" "std::cerr <<")
             (define-abbrev local-abbrev-table "serr" "std::cerr <<")
             (define-abbrev local-abbrev-table "scerr" "std::cerr <<")
             (define-abbrev local-abbrev-table "sendl" "std::endl")
             (define-abbrev local-abbrev-table "sflush" "std::flush")
             (define-abbrev local-abbrev-table "sstr" "std::string")
             (define-abbrev local-abbrev-table "sstring" "std::string")
             (define-abbrev local-abbrev-table "ir" "iterator")
             (define-abbrev local-abbrev-table "cir" "const_iterator")
             (define-abbrev local-abbrev-table "te" "template")
             (define-abbrev local-abbrev-table "tl" "template")
             (define-abbrev local-abbrev-table "tn" "typename")
             (define-abbrev local-abbrev-table "tt" "template <typename")
             (define-abbrev-table 'c++-mode-abbrev-advancement-table
               '(
                 ("for" "" my-skel-c-for)
                 ("wihle" "" my-skel-c-while)
                 ("whlie" "" my-skel-c-while)
                 ("while" "" my-skel-c-while)
                 ("if" "" my-skel-c-if)
                 ("else" "" my-skel-c-else)
                 ("elseif" "" my-skel-c-else-if)
                 ("elsif" "" my-skel-c-else-if)
                 ("elif" "" my-skel-c-else-if)
                 ("do" "" my-skel-c-do-while)
;                 ("#i" "#include")
;                 ("#in" "#include")
;                 ("#inc" "#include")
;                 ("#if" "#ifndef")
;                 ("#de" "#define")
;                 ("#ifd" "#ifdef")
;                 ("#e" "#endif")
                 ("forit" "" tempo-template-c-for-it)
                 ("fori" "" tempo-template-c-for-it)
                 ("functor" "" tempo-template-c-unary-functor)
                 ("bfunctor" "" tempo-template-c-binary-functor)
                 ("binaryfunctor" "" tempo-template-c-binary-functor)
                 ("comparator" "" tempo-template-c-comparator)
                 ("interface" "" tempo-template-c-interface)
                 ("cclass" "" tempo-template-c-class)
                 ("nclass" "" tempo-template-c-noncopy-class)
                 ("ncclass" "" tempo-template-c-noncopy-class)
                 ("chclass" "" tempo-template-c-child-class)
                 ("childc" "" tempo-template-c-child-class)
                 ("childclass" "" tempo-template-c-child-class)
                 ("getset" "" tempo-template-c-get-set)
                 ("smap" "std::map<" my-no-self-insert)
                 ("sset" "std::set<" my-no-self-insert)
                 ("svec" "std::vector<" my-no-self-insert)
                 ("svector" "std::vector<" my-no-self-insert)
                 ("cc" "const_cast<" my-no-self-insert)
                 ("sc" "static_cast<" my-no-self-insert)
                 ("rc" "reinterpret_cast<" my-no-self-insert)
                 )
               "The abbrev table for the C++ mode."
;               :regexp "\\<\\(\\w+\\)\\W*"
               '(:parents '(c++-mode-abbrev-table)) ; inheritence property
               )
             (message "C++ mode hook end")
             ))

(add-hook 'php-mode-hook
          '(lambda ()
             (local-set-key "\r" 'newline-and-indent)
             (setq show-trailing-whitespace t)
             (auto-fill-mode 1)
             (setq fill-column 80)
             (setq adaptive-fill-mode t)
             (setq indent-tabs-mode nil) ; spaces only
             (define-abbrev local-abbrev-table "f" "function")
             (define-abbrev local-abbrev-table "func" "function")
             (define-abbrev local-abbrev-table "fc" "function")
             ))

(defun my-lisp-hook ()
  (local-set-key "\r" 'newline-and-indent)
  (modify-syntax-entry ?- "w")
  (modify-syntax-entry ?_ "w")
  (setq show-trailing-whitespace t)
  (setq indent-tabs-mode nil) ; spaces only
  (auto-fill-mode 1)
  (setq fill-column 80)
  (setq adaptive-fill-mode t)
  (define-abbrev local-abbrev-table "d" "defun")
  (define-abbrev local-abbrev-table "f" "defun")
  (define-abbrev local-abbrev-table "lbd" "lambda")
  (define-abbrev local-abbrev-table "lamba" "lambda")
  (define-abbrev local-abbrev-table "lamda" "lambda")
  (define-abbrev local-abbrev-table "lamdba" "lambda")
  )
(byte-compile 'my-lisp-hook)

(add-hook 'lisp-mode-hook 'my-lisp-hook)
(add-hook 'emacs-lisp-mode-hook 'my-lisp-hook)

(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key "\r" 'newline-and-indent)
             (modify-syntax-entry ?_ "w")
             (auto-fill-mode 1)
             (setq fill-column 80)
             (setq adaptive-fill-mode t)
             (setq show-trailing-whitespace t)
             (define-abbrev local-abbrev-table "imain"
               "if __name__ == '__main__':\n    ")
             (define-abbrev local-abbrev-table "ret" "return")
             (define-abbrev local-abbrev-table "rt" "return")
             (define-abbrev local-abbrev-table "slef" "self")
             (define-abbrev local-abbrev-table "sef" "self")
             (define-abbrev local-abbrev-table "sf" "self")
             (define-abbrev local-abbrev-table "lbd" "lambda")
             (define-abbrev local-abbrev-table "lamba" "lambda")
             (define-abbrev local-abbrev-table "lamda" "lambda")
             (define-abbrev local-abbrev-table "lamdba" "lambda")
             (define-abbrev local-abbrev-table "true" "True")
             (define-abbrev local-abbrev-table "false" "False")
             ))

(add-hook 'sgml-mode-hook
          '(lambda ()
             (local-set-key "\r" 'newline-and-indent)
             (setq sgml-quick-keys t)
             (setq indent-tabs-mode nil) ; spaces only
             (auto-fill-mode 1)
             (setq fill-column 80)
             (setq adaptive-fill-mode t)
             (setq show-trailing-whitespace t)
             ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; GLOBAL SET KEYS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'pager)
(global-set-key "\C-v"     'pager-page-down)
(global-set-key [next]     'pager-page-down)
(global-set-key "\M-v"     'pager-page-up)
(global-set-key [prior]    'pager-page-up)
(global-set-key '[M-up]    'pager-row-up)
(global-set-key '[M-kp-8]  'pager-row-up)
(global-set-key '[M-down]  'pager-row-down)
(global-set-key '[M-kp-2]  'pager-row-down)
(global-set-key "\C-cr" 'my-rename)
(global-set-key [?\C-c ?\r] 'delete-trailing-whitespace)
(global-set-key "\M-g" 'goto-line) ; I don't use face selection
(global-set-key [backtab]  'my-delete-indentation)
(global-set-key "\C-ck" 'compile) ; I tend to compile often :-)
(global-set-key [?\C-c ?/] 'replace-regexp) ; better than query replace
(global-set-key [?\C-v] 'my-next-eol) ; one useful rebind
(global-set-key [?\M-\r] 'my-next-eol) ; a different more practical way
(global-set-key [?\M-v] 'my-prev-eol)
(global-set-key '[C-return] 'my-prev-eol) ; a different more practical way
(global-set-key '[M-right] 'forward-sexp)
(global-set-key '[M-left] 'backward-sexp)
(global-set-key [?\C-z] 'my-c-compactor)
(global-set-key [f9] 'my-swap-keyboard)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; EMACS SESSION
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(desktop-save-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; AUTO CORRECTION & OTHER GLOBAL ABBREVS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-abbrev-table 'global-abbrev-table '(
    ("abbout" "about" nil 0)
    ("abotu" "about" nil 0)
    ("abouta" "about a" nil 0)
    ("aboutit" "about it" nil 0)
    ("aboutthe" "about the" nil 0)
    ("abscence" "absence" nil 0)
    ("accesories" "accessories" nil 0)
    ("accidant" "accident" nil 0)
    ("accomodate" "accommodate" nil 0)
    ("accordingto" "according to" nil 0)
    ("accross" "across" nil 0)
    ("acheive" "achieve" nil 0)
    ("acheived" "achieved" nil 0)
    ("acheiving" "achieving" nil 0)
    ("acn" "can" nil 0)
    ("acommodate" "accommodate" nil 0)
    ("acomodate" "accommodate" nil 0)
    ("acomplished" "accomplished" nil 0)
    ("actualyl" "actually" nil 0)
    ("acurate" "accurate" nil 0)
    ("addictional" "additional" nil 0)
    ("additinal" "additional" nil 0)
    ("addtional" "additional" nil 0)
    ("addtions" "additions" nil 0)
    ("adequit" "adequate" nil 0)
    ("adequite" "adequate" nil 0)
    ("adn" "and" nil 0)
    ("advanage" "advantage" nil 0)
    ("affraid" "afraid" nil 0)
    ("afterthe" "after the" nil 0)
    ("aganist" "against" nil 0)
    ("aggresive" "aggressive" nil 0)
    ("agian" "again" nil 0)
    ("agreemeent" "agreement" nil 0)
    ("agreemeents" "agreements" nil 0)
    ("agreemnet" "agreement" nil 0)
    ("agreemnets" "agreements" nil 0)
    ("agressive" "aggressive" nil 0)
    ("ahppen" "happen" nil 0)
    ("ahve" "have" nil 0)
    ("allwasy" "always" nil 0)
    ("allwyas" "always" nil 0)
    ("almots" "almost" nil 0)
    ("almsot" "almost" nil 0)
    ("alomst" "almost" nil 0)
    ("alot" "a lot" nil 0)
    ("alraedy" "already" nil 0)
    ("alreayd" "already" nil 0)
    ("alreday" "already" nil 0)
    ("alwasy" "always" nil 0)
    ("alwats" "always" nil 0)
    ("alway" "always" nil 0)
    ("alwyas" "always" nil 0)
    ("amde" "made" nil 0)
    ("ameria" "America" nil 0)
    ("amke" "make" nil 0)
    ("amkes" "makes" nil 0)
    ("anbd" "and" nil 0)
    ("andone" "and one" nil 0)
    ("andt he" "and the" nil 0)
    ("andteh" "and the" nil 0)
    ("andthe" "and the" nil 0)
    ("anothe" "another" nil 0)
    ("anual" "annual" nil 0)
    ("apache" "Apache" nil 0)
    ("apparant" "apparent" nil 0)
    ("apparrent" "apparent" nil 0)
    ("appearence" "appearance" nil 0)
    ("appeares" "appears" nil 0)
    ("applicaiton" "application" nil 0)
    ("applicaitons" "applications" nil 0)
    ("applyed" "applied" nil 0)
    ("appointiment" "appointment" nil 0)
    ("approrpiate" "appropriate" nil 0)
    ("approrpriate" "appropriate" nil 0)
    ("aquisition" "acquisition" nil 0)
    ("aquisitions" "acquisitions" nil 0)
    ("arent" "aren't" nil 0)
    ("arguement" "argument" nil 0)
    ("arguements" "arguments" nil 0)
    ("arnt" "aren't" nil 0)
    ("arond" "around" nil 0)
    ("artical" "article" nil 0)
    ("articel" "article" nil 0)
    ("asdvertising" "advertising" nil 0)
    ("assistent" "assistant" nil 0)
    ("asthe" "as the" nil 0)
    ("atention" "attention" nil 0)
    ("atmospher" "atmosphere" nil 0)
    ("attentioin" "attention" nil 0)
    ("atthe" "at the" nil 0)
    ("audeince" "audience" nil 0)
    ("audiance" "audience" nil 0)
    ("authetication" "authentication" nil 0)
    ("availalbe" "available" nil 0)
    ("awya" "away" nil 0)
    ("aywa" "away" nil 0)
    ("bakc" "back" nil 0)
    ("balence" "balance" nil 0)
    ("ballance" "balance" nil 0)
    ("baout" "about" nil 0)
    ("bcak" "back" nil 0)
    ("beacause" "because" nil 0)
    ("beacuse" "because" nil 0)
    ("becasue" "because" nil 0)
    ("becaus" "because" nil 0)
    ("becausea" "because a" nil 0)
    ("becauseof" "because of" nil 0)
    ("becausethe" "because the" nil 0)
    ("becauseyou" "because you" nil 0)
    ("becomeing" "becoming" nil 0)
    ("becomming" "becoming" nil 0)
    ("becuase" "because" nil 0)
    ("becuse" "because" nil 0)
    ("befoer" "before" nil 0)
    ("beggining" "beginning" nil 0)
    ("begining" "beginning" nil 0)
    ("beginining" "beginning" nil 0)
    ("behabviour" "behaviour" nil 0)
    ("behaivior" "behaviour" nil 0)
    ("behavour" "behaviour" nil 0)
    ("beleiev" "believe" nil 0)
    ("beleieve" "believe" nil 0)
    ("beleif" "belief" nil 0)
    ("beleive" "believe" nil 0)
    ("beleived" "believed" nil 0)
    ("beleives" "believes" nil 0)
    ("beliefe" "belief" nil 0)
    ("beliveve" "believe" nil 0)
    ("benifit" "benefit" nil 0)
    ("benifits" "benefits" nil 0)
    ("betwen" "between" nil 0)
    ("beutiful" "beautiful" nil 0)
    ("blase" "blase" nil 0)
    ("boxs" "boxes" nil 0)
    ("brodcast" "broadcast" nil 0)
    ("butthe" "but the" nil 0)
    ("bve" "be" nil 0)
    ("cafe" "cafe" nil 0)
    ("caharcter" "character" nil 0)
    ("calcullated" "calculated" nil 0)
    ("calulated" "calculated" nil 0)
    ("candidtae" "candidate" nil 0)
    ("candidtaes" "candidates" nil 0)
    ("caontains" "contains" nil 0)
    ("capabilites" "capabilities" nil 0)
    ("catagory" "category" nil 0)
    ("categiory" "category" nil 0)
    ("certian" "certain" nil 0)
    ("challange" "challenge" nil 0)
    ("challanges" "challenges" nil 0)
    ("chaneg" "change" nil 0)
    ("chanegs" "changes" nil 0)
    ("changable" "changeable" nil 0)
    ("changeing" "changing" nil 0)
    ("changng" "changing" nil 0)
    ("charachter" "character" nil 0)
    ("charachters" "characters" nil 0)
    ("charactor" "character" nil 0)
    ("charecter" "character" nil 0)
    ("charector" "character" nil 0)
    ("cheif" "chief" nil 0)
    ("chekc" "check" nil 0)
    ("chnage" "change" nil 0)
    ("cieling" "ceiling" nil 0)
    ("circut" "circuit" nil 0)
    ("claer" "clear" nil 0)
    ("claered" "cleared" nil 0)
    ("claerly" "clearly" nil 0)
    ("cliant" "client" nil 0)
    ("cliche" "cliche" nil 0)
    ("cna" "can" nil 0)
    ("colection" "collection" nil 0)
    ("comanies" "companies" nil 0)
    ("comany" "company" nil 0)
    ("comapnies" "companies" nil 0)
    ("comapny" "company" nil 0)
    ("combintation" "combination" nil 0)
    ("comited" "committed" nil 0)
    ("comittee" "committee" nil 0)
    ("commadn" "command" nil 0)
    ("comming" "coming" nil 0)
    ("commitee" "committee" nil 0)
    ("committe" "committee" nil 0)
    ("committment" "commitment" nil 0)
    ("committments" "commitments" nil 0)
    ("committy" "committee" nil 0)
    ("comntain" "contain" nil 0)
    ("comntains" "contains" nil 0)
    ("compair" "compare" nil 0)
    ("compatable" "compatible" nil 0)
    ("compleated" "completed" nil 0)
    ("compleatly" "completely" nil 0)
    ("compleatness" "completeness" nil 0)
    ("completly" "completely" nil 0)
    ("completness" "completeness" nil 0)
    ("complteted" "completed" nil 0)
    ("composate" "composite" nil 0)
    ("compteted" "completed" nil 0)
    ("comtain" "contain" nil 0)
    ("comtains" "contains" nil 0)
    ("comunicate" "communicate" nil 0)
    ("comunity" "community" nil 0)
    ("condersider" "consider" nil 0)
    ("condolances" "condolences" nil 0)
    ("conected" "connected" nil 0)
    ("conferance" "conference" nil 0)
    ("configration" "configuration" nil 0)
    ("confirmmation" "confirmation" nil 0)
    ("conjuntion" "conjunction" nil 0)
    ("considerit" "considerate" nil 0)
    ("considerite" "considerate" nil 0)
    ("consistant" "consistent" nil 0)
    ("consonent" "consonant" nil 0)
    ("conspiricy" "conspiracy" nil 0)
    ("constuction" "construction" nil 0)
    ("consultent" "consultant" nil 0)
    ("consumeable" "consumable" nil 0)
    ("contitions" "conditions" nil 0)
    ("controlable" "controllable" nil 0)
    ("convertable" "convertible" nil 0)
    ("cooparate" "cooperate" nil 0)
    ("cooporate" "cooperate" nil 0)
    ("corproation" "corporation" nil 0)
    ("corproations" "corporations" nil 0)
    ("corrospond" "correspond" nil 0)
    ("corruptable" "corruptible" nil 0)
    ("cotten" "cotton" nil 0)
    ("coudl" "could" nil 0)
    ("coudln" "couldn" nil 0)
    ("coudn" "couldn" nil 0)
    ("couldnt" "couldn't" nil 0)
    ("couldthe" "could the" nil 0)
    ("cpoy" "copy" nil 0)
    ("creme" "creme" nil 0)
    ("ctaegory" "category" nil 0)
    ("cusotmer" "customer" nil 0)
    ("cusotmers" "customers" nil 0)
    ("cutsomer" "customer" nil 0)
    ("cutsomers" "customers" nil 0)
    ("cxan" "can" nil 0)
    ("danceing" "dancing" nil 0)
    ("dcument" "document" nil 0)
    ("deatils" "details" nil 0)
    ("decison" "decision" nil 0)
    ("decisons" "decisions" nil 0)
    ("decalation" "declaration" nil 0)
    ("defendent" "defendant" nil 0)
    ("definately" "definitely" nil 0)
    ("definitly" "definitely" nil 0)
    ("definded" "defined" nil 0)
    ("dependances" "dependencies" nil 0)
    ("deptartment" "department" nil 0)
    ("desicion" "decision" nil 0)
    ("desicions" "decisions" nil 0)
    ("desision" "decision" nil 0)
    ("desisions" "decisions" nil 0)
    ("detente" "detente" nil 0)
    ("determin" "determine" nil 0)
    ("determins" "determine" nil 0)
    ("develeoprs" "developers" nil 0)
    ("devellop" "develop" nil 0)
    ("develloped" "developed" nil 0)
    ("develloper" "developer" nil 0)
    ("devellopers" "developers" nil 0)
    ("develloping" "developing" nil 0)
    ("devellopment" "development" nil 0)
    ("devellopments" "developments" nil 0)
    ("devellops" "develop" nil 0)
    ("develope" "develop" nil 0)
    ("developement" "development" nil 0)
    ("developements" "developments" nil 0)
    ("developor" "developer" nil 0)
    ("developors" "developers" nil 0)
    ("develpment" "development" nil 0)
    ("devloped" "developed" nil 0)
    ("diaplay" "display" nil 0)
    ("didint" "didn't" nil 0)
    ("didnot" "did not" nil 0)
    ("didnt" "didn't" nil 0)
    ("difefrent" "different" nil 0)
    ("diferences" "differences" nil 0)
    ("differance" "difference" nil 0)
    ("differances" "differences" nil 0)
    ("differant" "different" nil 0)
    ("differemt" "different" nil 0)
    ("differnt" "different" nil 0)
    ("diffrent" "different" nil 0)
    ("directer" "director" nil 0)
    ("directers" "directors" nil 0)
    ("directiosn" "direction" nil 0)
    ("disatisfied" "dissatisfied" nil 0)
    ("discoverd" "discovered" nil 0)
    ("disign" "design" nil 0)
    ("dispaly" "display" nil 0)
    ("dissonent" "dissonant" nil 0)
    ("distribusion" "distribution" nil 0)
    ("distrubution" "distribution" nil 0)
    ("divsion" "division" nil 0)
    ("docuement" "documents" nil 0)
    ("docuemnt" "document" nil 0)
    ("documetn" "document" nil 0)
    ("documnet" "document" nil 0)
    ("documnets" "documents" nil 0)
    ("doese" "does" nil 0)
    ("doesnt" "doesn't" nil 0)
    ("doign" "doing" nil 0)
    ("doimg" "doing" nil 0)
    ("doind" "doing" nil 0)
    ("dollers" "dollars" nil 0)
    ("donig" "doing" nil 0)
    ("dont" "don't" nil 0)
    ("dont" "don't" nil 0)
    ("dosnt" "doesn't" nil 0)
    ("driveing" "driving" nil 0)
    ("drnik" "drink" nil 0)
    ("eclair" "eclair" nil 0)
    ("efel" "feel" nil 0)
    ("effecient" "efficient" nil 0)
    ("efort" "effort" nil 0)
    ("eforts" "efforts" nil 0)
    ("ehr" "her" nil 0)
    ("eligable" "eligible" nil 0)
    ("embarass" "embarrass" nil 0)
    ("emigre" "emigre" nil 0)
    ("enahancements" "enhancements" nil 0)
    ("english" "English" nil 0)
    ("enought" "enough" nil 0)
    ("entree" "entree" nil 0)
    ("equippment" "equipment" nil 0)
    ("equivalant" "equivalent" nil 0)
    ("esle" "else" nil 0)
    ("especally" "especially" nil 0)
    ("especialyl" "especially" nil 0)
    ("espesially" "especially" nil 0)
    ("excellant" "excellent" nil 0)
    ("excercise" "exercise" nil 0)
    ("exchagne" "exchange" nil 0)
    ("exchagnes" "exchanges" nil 0)
    ("excitment" "excitement" nil 0)
    ("exhcange" "exchange" nil 0)
    ("exhcanges" "exchanges" nil 0)
    ("experiance" "experience" nil 0)
    ("experienc" "experience" nil 0)
    ("exprience" "experience" nil 0)
    ("exprienced" "experienced" nil 0)
    ("eyt" "yet" nil 0)
    ("facade" "facade" nil 0)
    ("faeture" "feature" nil 0)
    ("faetures" "features" nil 0)
    ("familair" "familiar" nil 0)
    ("familar" "familiar" nil 0)
    ("familliar" "familiar" nil 0)
    ("fammiliar" "familiar" nil 0)
    ("feild" "field" nil 0)
    ("feilds" "fields" nil 0)
    ("fianlly" "finally" nil 0)
    ("fidn" "find" nil 0)
    ("fifith" "fifth" nil 0)
    ("finalyl" "finally" nil 0)
    ("finnally" "finally" nil 0)
    ("finnish" "finish" nil 0)
    ("firends" "friends" nil 0)
    ("firts" "first" nil 0)
    ("fixit" "fix it" nil 0)
    ("follwo" "follow" nil 0)
    ("follwoing" "following" nil 0)
    ("foloowing" "following" nil 0)
    ("fora" "for a" nil 0)
    ("foriegn" "foreign" nil 0)
    ("forthe" "for the" nil 0)
    ("forwrd" "forward" nil 0)
    ("forwrds" "forwards" nil 0)
    ("foudn" "found" nil 0)
    ("foward" "forward" nil 0)
    ("fowards" "forwards" nil 0)
    ("freind" "friend" nil 0)
    ("freindly" "friendly" nil 0)
    ("freinds" "friends" nil 0)
    ("frmo" "from" nil 0)
    ("fromt he" "from the" nil 0)
    ("fromthe" "from the" nil 0)
    ("furneral" "funeral" nil 0)
    ("fwe" "few" nil 0)
    ("garantee" "guarantee" nil 0)
    ("gaurd" "guard" nil 0)
    ("gemeral" "general" nil 0)
    ("gerat" "great" nil 0)
    ("gerneral" "general" nil 0)
    ("geting" "getting" nil 0)
    ("gettin" "getting" nil 0)
    ("gievn" "given" nil 0)
    ("giveing" "giving" nil 0)
    ("gloabl" "global" nil 0)
    ("goign" "going" nil 0)
    ("gonig" "going" nil 0)
    ("govenment" "government" nil 0)
    ("goverment" "government" nil 0)
    ("gruop" "group" nil 0)
    ("gruops" "groups" nil 0)
    ("grwo" "grow" nil 0)
    ("guidlines" "guidelines" nil 0)
    ("hadbeen" "had been" nil 0)
    ("hadnt" "hadn't" nil 0)
    ("haev" "have" nil 0)
    ("hapen" "happen" nil 0)
    ("hapened" "happened" nil 0)
    ("hapening" "happening" nil 0)
    ("hapens" "happens" nil 0)
    ("happend" "happened" nil 0)
    ("hasbeen" "has been" nil 0)
    ("hasnt" "hasn't" nil 0)
    ("havebeen" "have been" nil 0)
    ("haveing" "having" nil 0)
    ("haven;t" "haven't" nil 0)
    ("hda" "had" nil 0)
    ("hearign" "hearing" nil 0)
    ("heire" "he-ire" nil 0)
    ("heigth" "heigth" nil 0)
    ("heitgh" "heigth" nil 0)
    ("helpdesk" "help-desk" nil 0)
    ("helpfull" "helpful" nil 0)
    ("herat" "heart" nil 0)
    ("hesaid" "he said" nil 0)
    ("hewas" "he was" nil 0)
    ("hge" "he" nil 0)
    ("hier" "heir" nil 0)
    ("hismelf" "himself" nil 0)
    ("hiten" "hitting" nil 0)
    ("hitten" "hitting" nil 0)
    ("hlep" "help" nil 0)
    ("howerver" "however" nil 0)
    ("hsa" "has" nil 0)
    ("hsi" "his" nil 0)
    ("hte" "the" nil 0)
    ("htere" "there" nil 0)
    ("htese" "these" nil 0)
    ("htey" "they" nil 0)
    ("hting" "thing" nil 0)
    ("htink" "think" nil 0)
    ("htis" "this" nil 0)
    ("htp:" "http:" nil 0)
    ("http:\\\\" "http://" nil 0)
    ("httpL" "http:" nil 0)
    ("hvae" "have" nil 0)
    ("hvaing" "having" nil 0)
    ("hwich" "which" nil 0)
    ("idae" "idea" nil 0)
    ("idaes" "ideas" nil 0)
    ("identifiy" "identify" nil 0)
    ("identofy" "identify" nil 0)
    ("ihs" "his" nil 0)
    ("imediate" "immediate" nil 0)
    ("imediatly" "immediately" nil 0)
    ("immediatly" "immediately" nil 0)
    ("impilies" "implies" nil 0)
    ("implemenation" "implementation" nil 0)
    ("importent" "important" nil 0)
    ("importnat" "important" nil 0)
    ("impossable" "impossible" nil 0)
    ("improvemnt" "improvement" nil 0)
    ("improvment" "improvement" nil 0)
    ("includ" "include" nil 0)
    ("indecate" "indicate" nil 0)
    ("indenpendence" "independence" nil 0)
    ("indenpendent" "independent" nil 0)
    ("indepedent" "independent" nil 0)
    ("independance" "independence" nil 0)
    ("independant" "independent" nil 0)
    ("influance" "influence" nil 0)
    ("infomation" "information" nil 0)
    ("informatoin" "information" nil 0)
    ("inital" "initial" nil 0)
    ("initalization" "initialization" nil 0)
    ("instaleld" "installed" nil 0)
    ("insted" "instead" nil 0)
    ("insurence" "insurance" nil 0)
    ("inteh" "in the" nil 0)
    ("internet" "Internet" nil 0)
    ("interum" "interim" nil 0)
    ("inthe" "in the" nil 0)
    ("inturn" "in turn" nil 0)
    ("invitaion" "invitation" nil 0)
    ("invstigated" "investigated" nil 0)
    ("inwhich" "in which" nil 0)
    ("isnt" "isn't" nil 0)
    ("isthe" "is the" nil 0)
    ("itis" "it is" nil 0)
    ("ititial" "initial" nil 0)
    ("itll" "it'll" nil 0)
    ("itnerest" "interest" nil 0)
    ("itnerested" "interested" nil 0)
    ("itneresting" "interesting" nil 0)
    ("itnerests" "interests" nil 0)
    ("itwas" "it was" nil 0)
    ("ivestigative" "investigative" nil 0)
    ("iwll" "will" nil 0)
    ("iwth" "with" nil 0)
    ("jsut" "just" nil 0)
    ("jugment" "judgment" nil 0)
    ("knowldge" "knowledge" nil 0)
    ("knowlege" "knowledge" nil 0)
    ("knwo" "know" nil 0)
    ("knwon" "known" nil 0)
    ("knwos" "knows" nil 0)
    ("konw" "know" nil 0)
    ("konwn" "known" nil 0)
    ("konws" "knows" nil 0)
    ("labratory" "laboratory" nil 0)
    ("languange" "language" nil 0)
    ("lastyear" "last year" nil 0)
    ("learnign" "learning" nil 0)
    ("lenght" "length" nil 0)
    ("levle" "level" nil 0)
    ("libary" "library" nil 0)
    ("librarry" "library" nil 0)
    ("librery" "library" nil 0)
    ("liek" "like" nil 0)
    ("liekd" "liked" nil 0)
    ("lieutenent" "lieutenant" nil 0)
    ("liev" "live" nil 0)
    ("likly" "likely" nil 0)
    ("lisense" "license" nil 0)
    ("littel" "little" nil 0)
    ("litttle" "little" nil 0)
    ("liuke" "like" nil 0)
    ("liveing" "living" nil 0)
    ("loev" "love" nil 0)
    ("lonly" "lonely" nil 0)
    ("lookign" "looking" nil 0)
    ("lookup" "look up" nil 0)
    ("maintenence" "maintenance" nil 0)
    ("makeing" "making" nil 0)
    ("managment" "management" nil 0)
    ("mantain" "maintain" nil 0)
    ("marraige" "marriage" nil 0)
    ("memeber" "member" nil 0)
    ("merchent" "merchant" nil 0)
    ("mesage" "message" nil 0)
    ("mesages" "messages" nil 0)
    ("mispell" "misspell" nil 0)
    ("mispelling" "misspelling" nil 0)
    ("mispellings" "misspellings" nil 0)
    ("mkae" "make" nil 0)
    ("mkaes" "makes" nil 0)
    ("mkaing" "making" nil 0)
    ("moeny" "money" nil 0)
    ("morgage" "mortgage" nil 0)
    ("mroe" "more" nil 0)
    ("mysefl" "myself" nil 0)
    ("myu" "my" nil 0)
    ("myname" "Sylvain Bougerel" nil 0)
    ("mymail" "sylvain.bougerel@asia.thalesgroup.com" nil 0)
    ("naive" "naive" nil 0)
    ("necassarily" "necessarily" nil 0)
    ("necassary" "necessary" nil 0)
    ("neccessarily" "necessarily" nil 0)
    ("neccessary" "necessary" nil 0)
    ("necesarily" "necessarily" nil 0)
    ("necesary" "necessary" nil 0)
    ("negotiaing" "negotiating" nil 0)
    ("nkow" "know" nil 0)
    ("nothign" "nothing" nil 0)
    ("nver" "never" nil 0)
    ("nwe" "new" nil 0)
    ("nwo" "now" nil 0)
    ("obediant" "obedient" nil 0)
    ("ocasion" "occasion" nil 0)
    ("occassion" "occasion" nil 0)
    ("occured" "occurred" nil 0)
    ("occurence" "occurrence" nil 0)
    ("occurences" "occurrences" nil 0)
    ("occurrance" "occurrence" nil 0)
    ("ocur" "occur" nil 0)
    ("odbc" "ODBC" nil 0)
    ("oeprator" "operator" nil 0)
    ("ofits" "of its" nil 0)
    ("ofthe" "of the" nil 0)
    ("oging" "going" nil 0)
    ("ohter" "other" nil 0)
    ("omre" "more" nil 0)
    ("oneof" "one of" nil 0)
    ("onepoint" "one point" nil 0)
    ("online" "on-line" nil 0)
    ("ont he" "on the" nil 0)
    ("onthe" "on the" nil 0)
    ("onyl" "only" nil 0)
    ("opcode" "op-code" nil 0)
    ("operaror" "operator" nil 0)
    ("oppasite" "opposite" nil 0)
    ("opperation" "operation" nil 0)
    ("oppertunity" "opportunity" nil 0)
    ("opposate" "opposite" nil 0)
    ("opposible" "opposable" nil 0)
    ("opposit" "opposite" nil 0)
    ("oppotunities" "opportunities" nil 0)
    ("oppotunity" "opportunity" nil 0)
    ("orginization" "organization" nil 0)
    ("orginized" "organized" nil 0)
    ("originial" "original" nil 0)
    ("orignal" "original" nil 0)
    ("otehr" "other" nil 0)
    ("otu" "out" nil 0)
    ("outof" "out of" nil 0)
    ("overthe" "over the" nil 0)
    ("ovverides" "overrides" nil 0)
    ("owrk" "work" nil 0)
    ("owuld" "would" nil 0)
    ("oxident" "oxidant" nil 0)
    ("papaer" "paper" nil 0)
    ("parliment" "parliament" nil 0)
    ("partof" "part of" nil 0)
    ("paticular" "particular" nil 0)
    ("paymetn" "payment" nil 0)
    ("paymetns" "payments" nil 0)
    ("pciture" "picture" nil 0)
    ("peice" "piece" nil 0)
    ("peices" "pieces" nil 0)
    ("peolpe" "people" nil 0)
    ("peopel" "people" nil 0)
    ("percentof" "percent of" nil 0)
    ("percentto" "percent to" nil 0)
    ("performence" "performance" nil 0)
    ("perhasp" "perhaps" nil 0)
    ("perhpas" "perhaps" nil 0)
    ("permanant" "permanent" nil 0)
    ("perminent" "permanent" nil 0)
    ("perscriptions" "prescriptions" nil 0)
    ("personalyl" "personally" nil 0)
    ("pleasent" "pleasant" nil 0)
    ("plugin" "plug-in" nil 0)
    ("poeple" "people" nil 0)
    ("porblem" "problem" nil 0)
    ("porblems" "problems" nil 0)
    ("porvide" "provide" nil 0)
    ("possable" "possible" nil 0)
    ("postition" "position" nil 0)
    ("potentialy" "potentially" nil 0)
    ("prefure" "prefer" nil 0)
    ("pregnent" "pregnant" nil 0)
    ("prelease" "release" nil 0)
    ("prerelease" "pre-release" nil 0)
    ("presance" "presence" nil 0)
    ("privleged" "privileged" nil 0)
    ("probelm" "problem" nil 0)
    ("probelms" "problems" nil 0)
    ("problesm" "problems" nil 0)
    ("proceding" "proceeding" nil 0)
    ("proctetion" "protection" nil 0)
    ("prominant" "prominent" nil 0)
    ("protction" "protection" nil 0)
    ("protoge" "protege" nil 0)
    ("psoition" "position" nil 0)
    ("ptogress" "progress" nil 0)
    ("puting" "putting" nil 0)
    ("pwoer" "power" nil 0)
    ("quater" "quarter" nil 0)
    ("quaters" "quarters" nil 0)
    ("quesion" "question" nil 0)
    ("quesions" "questions" nil 0)
    ("questioms" "questions" nil 0)
    ("questiosn" "questions" nil 0)
    ("questoin" "question" nil 0)
    ("quetion" "question" nil 0)
    ("quetions" "questions" nil 0)
    ("raidus" "RADIUS" nil 0)
    ("realyl" "really" nil 0)
    ("reccomend" "recommend" nil 0)
    ("reccommend" "recommend" nil 0)
    ("receieve" "receive" nil 0)
    ("recieve" "receive" nil 0)
    ("recieved" "received" nil 0)
    ("recieving" "receiving" nil 0)
    ("recomend" "recommend" nil 0)
    ("recomendation" "recommendation" nil 0)
    ("recomendations" "recommendations" nil 0)
    ("recomended" "recommended" nil 0)
    ("recomending" "recommending" nil 0)
    ("reconize" "recognize" nil 0)
    ("recrod" "record" nil 0)
    ("redirector" "re-director" nil 0)
    ("regardsless" "regardless" nil 0)
    ("regession" "regression" nil 0)
    ("regresion" "regression" nil 0)
    ("releated" "related" nil 0)
    ("religous" "religious" nil 0)
    ("relize" "realize" nil 0)
    ("reloacted" "relocated" nil 0)
    ("reltaed" "related" nil 0)
    ("reluctent" "reluctant" nil 0)
    ("remeber" "remember" nil 0)
    ("reommend" "recommend" nil 0)
    ("representativs" "representatives" nil 0)
    ("representives" "representatives" nil 0)
    ("represetned" "represented" nil 0)
    ("represnt" "represent" nil 0)
    ("requirment" "requirement" nil 0)
    ("requirments" "requirements" nil 0)
    ("reserach" "research" nil 0)
    ("resollution" "resolution" nil 0)
    ("resorces" "resources" nil 0)
    ("respomd" "respond" nil 0)
    ("respomse" "response" nil 0)
    ("responce" "response" nil 0)
    ("responsability" "responsibility" nil 0)
    ("responsable" "responsible" nil 0)
    ("responsibile" "responsible" nil 0)
    ("responsiblity" "responsibility" nil 0)
    ("restaraunt" "restaurant" nil 0)
    ("restuarant" "restaurant" nil 0)
    ("retreive" "retrieve" nil 0)
    ("reult" "result" nil 0)
    ("reveiw" "review" nil 0)
    ("reveiwing" "reviewing" nil 0)
    ("rumers" "rumors" nil 0)
    ("runnning" "running" nil 0)
    ("rwite" "write" nil 0)
    ("rythm" "rhythm" nil 0)
    ("saidhe" "said he" nil 0)
    ("saidit" "said it" nil 0)
    ("saidthat" "said that" nil 0)
    ("saidthe" "said the" nil 0)
    ("scedule" "schedule" nil 0)
    ("sceduled" "scheduled" nil 0)
    ("scen" "scene" nil 0)
    ("scol" "scowl" nil 0)
    ("scoli" "scowl" nil 0)
    ("seance" "seance" nil 0)
    ("secratary" "secretary" nil 0)
    ("sectino" "section" nil 0)
    ("securtiy" "security" nil 0)
    ("seh" "she" nil 0)
    ("selectoin" "selection" nil 0)
    ("sentance" "sentence" nil 0)
    ("separeate" "separate" nil 0)
    ("seperate" "separate" nil 0)
    ("seperated" "separated" nil 0)
    ("sercumstances" "circumstances" nil 0)
    ("serveral" "several" nil 0)
    ("sez" "says" nil 0)
    ("shcool" "school" nil 0)
    ("shesaid" "she said" nil 0)
    ("shineing" "shining" nil 0)
    ("shiped" "shipped" nil 0)
    ("shoudl" "should" nil 0)
    ("shouldent" "shouldn't" nil 0)
    ("shouldnt" "shouldn't" nil 0)
    ("showinf" "showing" nil 0)
    ("signifacnt" "significant" nil 0)
    ("simalar" "similar" nil 0)
    ("similiar" "similar" nil 0)
    ("simpilified" "simplified" nil 0)
    ("simpyl" "simply" nil 0)
    ("sincerly" "sincerely" nil 0)
    ("sitll" "still" nil 0)
    ("smae" "same" nil 0)
    ("smoe" "some" nil 0)
    ("soem" "some" nil 0)
    ("sohw" "show" nil 0)
    ("soical" "social" nil 0)
    ("somethign" "something" nil 0)
    ("someting" "something" nil 0)
    ("somewaht" "somewhat" nil 0)
    ("somthing" "something" nil 0)
    ("somtimes" "sometimes" nil 0)
    ("soudn" "sound" nil 0)
    ("soudns" "sounds" nil 0)
    ("speach" "speech" nil 0)
    ("specificaly" "specifically" nil 0)
    ("specificalyl" "specifically" nil 0)
    ("statment" "statement" nil 0)
    ("statments" "statements" nil 0)
    ("stnad" "stand" nil 0)
    ("stopry" "story" nil 0)
    ("stoyr" "story" nil 0)
    ("stpo" "stop" nil 0)
    ("strentgh" "strength" nil 0)
    ("stroy" "story" nil 0)
    ("struggel" "struggle" nil 0)
    ("strugle" "struggle" nil 0)
    ("studnet" "student" nil 0)
    ("sublanguange" "sublanguage" nil 0)
    ("substitued" "substituted" nil 0)
    ("successfull" "successful" nil 0)
    ("successfuly" "successfully" nil 0)
    ("successfulyl" "successfully" nil 0)
    ("sucess" "success" nil 0)
    ("sucessfull" "successful" nil 0)
    ("sufficiant" "sufficient" nil 0)
    ("suposed" "supposed" nil 0)
    ("suppossed" "supposed" nil 0)
    ("suprise" "surprise" nil 0)
    ("suprised" "surprised" nil 0)
    ("suprisingly" "surprisingly" nil 0)
    ("swiming" "swimming" nil 0)
    ("tahn" "than" nil 0)
    ("taht" "that" nil 0)
    ("talekd" "talked" nil 0)
    ("talior" "tailor" nil 0)
    ("talkign" "talking" nil 0)
    ("tath" "that" nil 0)
    ("tecnical" "technical" nil 0)
    ("teh" "the" nil 0)
    ("tehy" "they" nil 0)
    ("terminiated" "terminated" nil 0)
    ("termoil" "turmoil" nil 0)
    ("tghe" "the" nil 0)
    ("tghis" "this" nil 0)
    ("thansk" "thanks" nil 0)
    ("thatthe" "that the" nil 0)
    ("thecompany" "the company" nil 0)
    ("thefirst" "the first" nil 0)
    ("thegovernment" "the government" nil 0)
    ("themself" "themselves" nil 0)
    ("themselfs" "themselves" nil 0)
    ("thenew" "the new" nil 0)
    ("theri" "their" nil 0)
    ("thesame" "the same" nil 0)
    ("thetwo" "the two" nil 0)
    ("theyll" "they'll" nil 0)
    ("theyve" "they've" nil 0)
    ("thgat" "that" nil 0)
    ("thge" "the" nil 0)
    ("thier" "their" nil 0)
    ("thier" "their" nil 0)
    ("thigsn" "things" nil 0)
    ("thisyear" "this year" nil 0)
    ("thna" "than" nil 0)
    ("thne" "then" nil 0)
    ("thnig" "thing" nil 0)
    ("thnigs" "things" nil 0)
    ("threatend" "threatened" nil 0)
    ("thsi" "this" nil 0)
    ("thsoe" "those" nil 0)
    ("thta" "that" nil 0)
    ("tihs" "this" nil 0)
    ("timne" "time" nil 0)
    ("tiogether" "together" nil 0)
    ("tje" "the" nil 0)
    ("tjhe" "the" nil 0)
    ("tkae" "take" nil 0)
    ("tkaes" "takes" nil 0)
    ("tkaing" "taking" nil 0)
    ("tlaking" "talking" nil 0)
    ("todya" "today" nil 0)
    ("togehter" "together" nil 0)
    ("tomorow" "tomorrow" nil 0)
    ("tongiht" "tonight" nil 0)
    ("tonihgt" "tonight" nil 0)
    ("totaly" "totally" nil 0)
    ("totalyl" "totally" nil 0)
    ("tothe" "to the" nil 0)
    ("towrad" "toward" nil 0)
    ("traditionalyl" "traditionally" nil 0)
    ("transfered" "transferred" nil 0)
    ("truely" "truly" nil 0)
    ("truley" "truly" nil 0)
    ("tryed" "tried" nil 0)
    ("tthe" "the" nil 0)
    ("tyhat" "that" nil 0)
    ("tyhe" "the" nil 0)
    ("udnerstand" "understand" nil 0)
    ("understnad" "understand" nil 0)
    ("undert he" "under the" nil 0)
    ("unicode" "Unicode" nil 0)
    ("unicode" "Unicode" nil 0)
    ("unitedstates" "United States" nil 0)
    ("unliek" "unlike" nil 0)
    ("unpleasently" "unpleasantly" nil 0)
    ("unregistared" "unregistered" nil 0)
    ("untill" "until" nil 0)
    ("untilll" "until" nil 0)
    ("useing" "using" nil 0)
    ("usualyl" "usually" nil 0)
    ("veyr" "very" nil 0)
    ("virtualyl" "virtually" nil 0)
    ("vrey" "very" nil 0)
    ("vulnerible" "vulnerable" nil 0)
    ("waht" "what" nil 0)
    ("warrent" "warrant" nil 0)
    ("wasnt" "wasn't" nil 0)
    ("watn" "want" nil 0)
    ("wehn" "when" nil 0)
    ("wernt" "weren't" nil 0)
    ("werre" "were" nil 0)
    ("wethee" "whether" nil 0)
    ("whcih" "which" nil 0)
    ("wherre" "where" nil 0)
    ("whic" "which" nil 0)
    ("whihc" "which" nil 0)
    ("whos" "who's" nil 0)
    ("whove" "who've" nil 0)
    ("whta" "what" nil 0)
    ("widht" "width" nil 0)
    ("witdh" "width" nil 0)
    ("wief" "wife" nil 0)
    ("wierd" "weird" nil 0)
    ("wihch" "which" nil 0)
    ("wiht" "with" nil 0)
    ("willbe" "will be" nil 0)
    ("windoes" "windows" nil 0)
    ("witha" "with a" nil 0)
    ("withe" "with" nil 0)
    ("withthe" "with the" nil 0)
    ("wiull" "will" nil 0)
    ("wnat" "want" nil 0)
    ("wnated" "wanted" nil 0)
    ("wnats" "wants" nil 0)
    ("woh" "who" nil 0)
    ("wohle" "whole" nil 0)
    ("wokr" "work" nil 0)
    ("woudl" "would" nil 0)
    ("woudln" "wouldn" nil 0)
    ("wouldbe" "would be" nil 0)
    ("wouldnt" "wouldn't" nil 0)
    ("wriet" "write" nil 0)
    ("writting" "writing" nil 0)
    ("wrod" "word" nil 0)
    ("wroet" "wrote" nil 0)
    ("wroking" "working" nil 0)
    ("wtih" "with" nil 0)
    ("wuould" "would" nil 0)
    ("wya" "way" nil 0)
    ("yera" "year" nil 0)
    ("yeras" "years" nil 0)
    ("yersa" "years" nil 0)
    ("yoiu" "you" nil 0)
    ("youare" "you are" nil 0)
    ("youd" "you'd" nil 0)
    ("youre" "you're" nil 0)
    ("youve" "you've" nil 0)
    ("ytou" "you" nil 0)
    ("yuo" "you" nil 0)
    ("yuor" "your" nil 0)
    ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; CUSTOMIZED COMMANDS BY EMACS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-save-list-file-prefix "~/.emacs.files/auto-save-list/.saves-")
 '(backup-directory-alist (quote (("." . "~/.emacs.files/backup"))))
 '(column-number-mode t)
 '(save-abbrevs nil)
 '(tool-bar-mode nil nil (tool-bar)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(put 'scroll-left 'disabled nil)
