{obj-to-pairs, is-type, head, find, filter, empty, reject, values, map, join, unwords, compact} = require \prelude-ls

angular.module "jonny.admin"
.factory "AnswerOnQuestion" <[GameQuestions]> ++ (GameQuestions) ->
  questions = []
  GameQuestions.then (q) -> questions := q

  (answers) -> (question) -> let q = find (.name == question), questions
    switch
    | q =>
      x = find (.$id == q.$id), answers
      switch
      | x => x.value

.factory "AnswerExtract"  <[$filter]> ++ (F)->
  human-time = F 'humanTime'
  format = "Do MM"
  safe = ->
    | it => it
    | _ => ''

  obj-vals = ->
    | is-type "Object" it =>
      obj-to-pairs it |>
      map join ': '
    | _ => it



  (a, type) ->
    switch type
      | \about =>
        m = []
        if a.age then m.push "#{a.age} -"
        if a.gender then m.push a.gender
        if a.preference then m.push ", #{a.preference}"
        unwords m
      | \company-details =>
        x = []
        if a.partner then x.push 'Partner'
        if a.malefriends then x.push "Male friends: #{a.malefriends.count}"
        if a.femalefriends then x.push "Female friends: #{a.femalefriends.count}"
        if a.kids then
          if a.kids.girls then x.push "Girls: #{a.kids.girls}"
          if a.kids.boys then x.push "Boys: #{a.kids.boys}"
        if a.yourparents then x.push "Parents: #{a.yourparents.count}"
        if a.pets then x.push "Pets: #{a.pets.count}"
        if a.details then x.push "Notes: #{a.details}"
        unwords x

      | \dates =>
        d = []
        if a.start then d.push human-time a.start, format
        if a.end then d.push human-time a.end, format
        if a.flexible then "Dates are flexible"
        unwords d

      | \rolling =>
        switch a
          | 1 => "Backpacker"
          | 2 => "Cosmopolitan"
          | 3 => "Jetsetter"
          | 4 => "Rick Astley"
          | 5 => "MOTHERFUCKING SULTAN!"

      | 'check-list' =>
        join ', ' a

      | \bingo  =>
        join ', ' a

      | _ => a


.factory "QandA" <[GameQuestions AnswerExtract]> ++ ((GameQuestions, AnswerExtract) ->
  questions = []
  empty-filter = reject (-> let i = it.value
    (is-type "Array" i) and (
      (empty i) or
      (i.length == 1 and ((head i) == ""))
    )
  )

  GameQuestions.then (q) -> questions := q

  (answers) ->
    empty-filter answers
    |> map ((a)-> let q = find (.$id == a.$id), questions
      (do
        question: q.text
        answer: AnswerExtract a.value, q.type
        type: q.type
      )
    )
)
