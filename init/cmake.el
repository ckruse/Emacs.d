(autoload 'cmake-mode
          "cmake-mode"
          "Mode for cmake files" t
          )

(add-to-list 'auto-mode-alist '(".cmake" . cmake-mode))
(add-to-list 'auto-mode-alist '("CMakeLists.txt" . cmake-mode))


;; eof
