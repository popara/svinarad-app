app = Elm.Radnik.fullscreen!

firebase.initialize-app do
  apiKey: "AIzaSyD7a1HWg-mhrdcLvnkDGA5T8dGm4Egsn5o"
  authDomain: "svinarad.firebaseapp.com"
  databaseURL: "https://svinarad.firebaseio.com"
  storageBucket: "project-3059661871212874899.appspot.com"

db = firebase.database!

do
  snap <-! db.ref \jobs .order-by-child \status .equal-to 'open' .on 'value'

  console.log \ops
  # app.ports.jobs.send <| R.map (.title) <| R.values snap.val!
