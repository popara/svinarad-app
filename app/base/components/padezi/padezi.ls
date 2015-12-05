{words, unwords, map, initial, id, last} = require \prelude-ls
angular.module 'app.base'
.factory 'padezi' ->
  p =
    acusative: (gender, w) -->
      (initial w) + switch (last w).to-lower-case!
      | 'a' => 'u'
      | 'c' => 'ca'
      | 'd' => 'da'
      | 'o' => 'a'
      | 'i' => 'ija'
      | 'e' => 'ea'
      | 'u' => 'a'
      | _ => that
      
    dativ: (gender, w) -->
      (initial w) + switch (last w).to-lower-case!
      | 'a' => 'i'
      | 'i' => 'i'
      | 'o' => 'u'
      | 'e' => 'u'
      | 'u' => 'u'
      | 'c' => that + 'u'
      | 'd' => that + 'u'
      | _ => that

  (word, padez, gender) -> if word
    unwords map (p[padez] gender), words word


.filter 'padez' <[padezi]> ++ (p) -> p
