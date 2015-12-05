angular.module 'app.base'
.factory 'JobReviews' <[fo]> ++ (fo) ->
  (job_id) -> fo "jobs/#{job_id}/reviews"
.factory 'UserWrittenReviews' <[fo]> ++ (fo) ->
  (user_id) -> fo "users/#{user_id}/job_reviews/written"
.factory 'UserReceivedReviews' <[fo]> ++ (fo) ->
  (user_id) -> fo "users/#{user_id}/job_reviews/of_user"
.factory 'userReview' <[timestamp UserById JobReviews UserWrittenReviews UserReceivedReviews]> ++ (now, user, reviews, uwr, urr) ->
  (author_id, subject_id, job_id, review) ->
    review.when = now!
    utowrite = uwr author_id
    utoreceive = urr subject_id
    jrws = reviews job_id

    <- utowrite.$loaded
    <- utoreceive.$loaded
    <- jrws.$loaded

    jrws[author_id] = review
    utowrite[job_id] = review.rating
    utoreceive[job_id] = review.rating
    
    <- jrws.$save!then
    <- utowrite.$save!then
    <- utoreceive.$save!then
