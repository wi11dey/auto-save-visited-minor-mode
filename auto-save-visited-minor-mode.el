;;; auto-save-visited-minor-mode.el --- Auto-save select buffers in their visited file -*- lexical-binding: t -*-

;; Author: Will Dey
;; Maintainer: Will Dey
;; Version: 1.0.0
;; Package-Requires: ()
;; Homepage: https://github.com/wi11dey/auto-save-visited-minor-mode
;; Keywords: keywords
;; Created: 10 April 2019

;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;; Generate README:
;;; Commentary:

;; commentary

;;; Code:

(defgroup auto-save-visited-minor-mode nil
  ""
  :group 'auto-save)

(defcustom auto-save-visited-minor-mode-interval 5
  ""
  :type 'number)

(defvar-local auto-save-visited-minor-mode--timer nil
  "Timer ")

(defun auto-save-visited-minor-mode--save (buffer)
  (with-current-buffer buffer
    (save-buffer)))

;;;###autoload
(define-minor-mode auto-save-visited-minor-mode
  "."
  :lighter " ASV"
  ;; Teardown:
  (when auto-save-visited-minor-mode--timer
    (setq auto-save-visited-minor-mode--timer (cancel-timer auto-save-visited-minor-mode--timer)))
  (remove-hook 'kill-buffer-hook #'auto-save-visited-minor-mode-off 'local)
  (when auto-save-visited-minor-mode
    (add-hook 'kill-buffer-hook #'auto-save-visited-minor-mode-off nil 'local)
    (setq auto-save-visited-minor-mode--timer (run-with-idle-timer auto-save-visited-minor-mode-interval
								   'repeat
								   #'auto-save-visited-minor-mode--save (current-buffer)))))

(defun auto-save-visited-minor-mode-off ()
  (auto-save-visited-minor-mode -1))

(provide 'auto-save-visited-minor-mode)
