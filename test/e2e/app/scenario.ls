require! protractor

const URL = 'http://localhost:3000/'
loc = -> URL + it

describe 'about page' (,) !->
  it 'Should have a link to application ' !->
    browser.get URL + 'app/intro'
    (element by.button-text "Let's do it!")
      .click!then ->
        set-timeout (-> expect (browser.get-location-abs-url!) .to-be loc 'app/game/0'), 4
