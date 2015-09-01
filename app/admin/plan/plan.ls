
/**
 * User: popara
 * Date: 4/9/15
 * Time: 4:46 PM
 */
{concat, values, map, head, pairs-to-obj, keys} = require 'prelude-ls'

angular.module "jonny.admin"
.factory 'Plan' <[fo]> ++ (fo) -> (user-id) -> fo "plan/#{user-id}"
.factory 'Organizers' <[Profile Categories]> ++ (Profile, Categories) -> do
    user: Profile.get!
    categories: Categories
.factory 'PlanCategory' <[fo EntryBuilder dj2fbVenue]> ++ (fo, EB, convert) -> (id, category) -> fo "plan/#{id}/categories/#{category}" (do
  new-entry: EB
  convert: convert
)
.factory 'Categories' <[fa]> ++ (fa) -> fa 'categories'
.factory 'Category' <[fo]> ++ (fo) -> -> fo ['categories', it].join '/'
.factory 'CategoriesObject' <[fo]> ++ (fo) -> fo 'categories'
