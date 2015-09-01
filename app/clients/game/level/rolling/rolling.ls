angular.module "jonny.client"
.directive 'gameRolling' <[gameRollers]> ++ (gameRollers) ->
  do
    restrict: 'E'
    template-url: 'app/clients/game/level/rolling/rolling.html'
    scope:
      question: '='
      delegate: '&'
      init: '='
    link: (scope) !->
      scope.i = 2
      scope.set-i = -> scope.i = it
      scope.roll = gameRollers
      scope.get-number = -> _.range 0 it

      scope.$watch \i !->
        scope.delegate {scope.question, answer: (scope.i+1)}
        
      scope.$on \answer !->
        scope.delegate {scope.question, answer: (scope.i+1)}
        scope.$emit 'answered'

      if scope.init
      then
        v = scope.init.value
        scope.i = v-1

.factory 'gameRollers' -> [
  * id: 'backpacker'
    title: 'Backpacker'
    desc: 'The best things in life are for free. I take risks with tap water.'
  * id: 'cosmopolitan'
    title: 'Cosmopolitan'
    desc: 'Carpe diem! I\'m going to eat and play like a champ in Ibiza. I\'ll get back to work when I\'m back home...'
  * id: 'jetsetter'
    title: 'Jetsetter'
    desc: 'Work hard. Play hard. Plenty coin in the bank, haters gonna hate.'
  * id: 'rick'
    title: 'Rock Star'
    desc: 'I roll big.'
  * id: 'sultan'
    title: 'Sultan'
    desc: 'I have a sovereign wealth fund.'
]
