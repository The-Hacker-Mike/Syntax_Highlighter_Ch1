#| 
Diana Karen Melo Reyes A01023785
Miguel Medina
Emilio Sánchez
|#

#lang racket

(require racket/trace)

(define htmlFile (open-output-file "htmlFile.html"))
(display "<!DOCTYPE html>
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
        height: 100vh;
        margin: 0;
        padding: 20px;
        font-size: 20px;
    }
    #intro {color: white; font-family: 'Italiana', serif;}
    .key {color: #FF7597;}
    .value {color: #BB86FC;}
    .operator {color: #03DAC6;}
    .parenthesis {color: #3700B3;}
    .digit{color: #767D92}
</style>
<body>
    <div id=\"allContent\">
        <div id=\"intro\">
            <h1>JSON Syntax Highlighter with Racket.</h1>
            <h3>Developed by Diana Melo, Miguel Medina and Emilio Sanchez &#128512;</h3>
        </div>" htmlFile)
(define ourStr (file->string "mySpotify.json"))
(define(loop ourStr)
  ;if (eq? (string-length ourStr) 0
  (if (not (non-empty-string? ourStr))
      (close-output-port htmlFile)
      ;(display "termino")
  (cond
    ;Operations
     [(regexp-match-positions #px"^(?:\\(|\\)|\\[|\\]|\\{|\\}|\\,)" ourStr)(display "entro a operadores ")(display "<span class=\"operator\">" htmlFile)(display (car(regexp-match #px"^(?:\\(|\\)|\\[|\\]|\\{|\\}|\\,)" ourStr)) htmlFile)(display "</span>" htmlFile)(display ". Se regreso: ")(display (substring ourStr (cdar(regexp-match-positions #px"(?:\\(|\\)|\\[|\\]|\\{|\\}|\\,)" ourStr))))(loop(substring ourStr (cdar(regexp-match-positions #px"(?:\\(|\\)|\\[|\\]|\\{|\\}|\\,)" ourStr))))]
     ;New line
     [(regexp-match #px"^\n|\r" ourStr)(display "<br>" htmlFile)(display "entro al enter")(loop(substring ourStr (cdar(regexp-match-positions #px"\n|\r" ourStr))))]
     ;Whitespace
     [(regexp-match #px"^ " ourStr)(display "Entro al espacio")(display "<span>&nbsp;</span>" htmlFile)(display ourStr)(loop(substring ourStr 1))]
     ;Tab
     [(regexp-match #px"^\t" ourStr)(display "<span>&ensp;</span>" htmlFile)(loop(substring ourStr 1))]
     ;Ints or decimal numbers
     [(regexp-match #px"^[\\d]+(\\.\\d+)?" ourStr)(display "Entro al digito")(display "<span class=\"digit\">" htmlFile)(display (car(regexp-match #px"^[\\d]+(\\.\\d+)?" ourStr)) htmlFile)(display "</span>" htmlFile)(loop (substring ourStr (cdar(regexp-match-positions #px"^[\\d]+(\\.\\d+)?" ourStr))))]
     ;Key #px"^\".*\":"
     [(regexp-match #px"^\"[\\w|\\s]+\":" ourStr)(display " entro a la llave: ")(display "<span class=\"key\">" htmlFile)(display (substring ourStr 0 (- (string-length(car(regexp-match #px"^\"[\\w|\\s]+\":" ourStr))) 1))htmlFile)(display "</span>" htmlFile)(display "<span class=\"operator\">:</span>" htmlFile)(loop (substring ourStr (cdar(regexp-match-positions #px"^\"[\\w|\\s]+\":" ourStr))))]
     ;Value
     [(regexp-match #px"^\"[\\w|\\s]+\"" ourStr)(display "entro al valor: ")(display (regexp-match #px"^\"[\\w|\\s]+\"" ourStr))(display "<span class=\"value\">" htmlFile)(display (car(regexp-match #px"^\"[\\w|\\s]+\"" ourStr))htmlFile)(display "</span>" htmlFile)(loop (substring ourStr (cdar(regexp-match-positions #px"^\"[\\w|\\s]+\"" ourStr))))]
     ;bool
     [(regexp-match #px"^true$|^false$" ourStr)(display "<span class=\"bool\">" htmlFile)(display (car(regexp-match #px"^true$|^false$" ourStr))htmlFile)(display "</span>" htmlFile)(loop (substring ourStr (cdar(regexp-match-positions #px"^true$|^false$" ourStr))))]
     ;When none works
     [else (display "no agarro nada, se estaba buscando! ")(display (substring ourStr 0 1))(close-output-port htmlFile)])))
(loop ourStr)
  