#| 
Diana Karen Melo Reyes A01023785
Miguel Medina
Emilio Sánchez
|#

#lang racket
(define path_str "C:\Users\diana\Documents\VS/ code\Racket2\Syntax_Highlighter_Ch1\mySpotify.json")
(string->path path_str)
(file->list path [Proc #:mode mode-flag]) → (listof any/c)

  path : path-string?
  Proc : (input-port? . -> . any/c) = read
  mode-flag : (or/c 'binary 'text) = 'binary
;actividad

