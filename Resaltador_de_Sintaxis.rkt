#| 
Diana Karen Melo Reyes A01023785
Miguel Medina
Emilio Sánchez
|#

#lang racket

(require racket/trace)

;Function to create the html file and to call loop with the JSON file converted to string.
(define (JsonFile theFile)
  (define htmlFile (open-output-file (string-append (substring theFile 0 (- (string-length  theFile) 5)) ".html") #:exists 'truncate))
  (display  "<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>Document</title>
</head>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Yeseva+One&display=swap');
    @import url('https://fonts.googleapis.com/css2?family=Italiana&display=swap');
    #allContent{ 
        font-family:'Yeseva One', cursive;
        background-color: #121212;
        height: auto;
        margin: 0;
        padding: 20px;
        font-size: 20px;
    }
    #intro {color: white; font-family: 'Italiana', serif;}
    .key {color: #FF7597;}
    .value {color: #BB86FC;}
    .operator {color: #03DAC6;}
    .parenthesis {color: #3700B3;}
    .digit{color: #767D92;}
    .bool{color: blue;}

</style>
<body>
    <div id=\"allContent\">
        <div id=\"intro\">
            <h1>JSON Syntax Highlighter with Racket.</h1>
            <h3>Developed by Diana Melo, Miguel Medina and Emilio Sanchez &#128512;</h3>
        </div>" htmlFile)
  (check (file->string theFile) htmlFile))

;Function to write string into html
(define (writeStrFunction strToWrite htmlFile)
  (display strToWrite htmlFile)
  (close-output-port htmlFile))
  

;Function to identify tokens with regular expresions
(define(check ourStr htmlFile)
  (define operation #px"^(?:\\(|\\)|\\[|\\]|\\{|\\}|\\,)")
  (define enter #px"^\n|\r")
  (define spc #px"^ ")
  (define tab #px"^\t")
  (define num #px"^[\\d]+(\\.\\d+)?")
  (define key #px"^\"[^\"]+\":")
  (define value #px"^\"([^\"]+|[ ]?)\"")
  (define bool #px"^true|^false")
  (let loop([ourStr ourStr] [htmlFile htmlFile] [creatingStr " "])
    (if (not (non-empty-string? ourStr))
        (writeStrFunction creatingStr htmlFile)
        ;(display "termino")
        (cond
          ;Operations
          [(regexp-match operation ourStr)(define result (car(regexp-match operation ourStr)))(loop (substring ourStr (string-length result)) htmlFile (string-append creatingStr "<span class=\"operator\">" result "</span>"))]
          ;New line
          [(regexp-match enter ourStr)(loop(substring ourStr 1) htmlFile (string-append creatingStr "<br>"))]
          ;Whitespace
          [(regexp-match spc ourStr)(loop(substring ourStr 1) htmlFile (string-append creatingStr "<span>&nbsp;</span>"))]
          ;Tab
          [(regexp-match tab ourStr)(loop(substring ourStr 1) htmlFile (string-append creatingStr "<span>&ensp;</span>"))]
          ;Ints or decimal numbers
          [(regexp-match num ourStr)(define result (car(regexp-match num ourStr)))(loop (substring ourStr (string-length result)) htmlFile (string-append creatingStr "<span class=\"digit\">" result "</span>"))]
          ;Key 
          [(regexp-match key ourStr)(define result (car(regexp-match key ourStr)))(loop (substring ourStr (string-length result)) htmlFile (string-append creatingStr "<span class=\"key\">" (substring result 0 (- (string-length result) 1)) "</span>" "<span class=\"operator\">:</span>"))]
          ;Value
          [(regexp-match value ourStr)(define result (car(regexp-match value ourStr)))(loop (substring ourStr (string-length result)) htmlFile (string-append creatingStr "<span class=\"value\">" result "</span>"))]
          ;bool
          [(regexp-match bool ourStr)(define result (car(regexp-match bool ourStr)))(loop (substring ourStr (string-length result)) htmlFile (string-append creatingStr "<span class=\"bool\">" result "</span>"))]
          ;When none works
          [else (display "no agarro nada, se estaba buscando! ")(display (substring ourStr 0 5))(close-output-port htmlFile)]))))
;(time(loop ourStr))
  
 