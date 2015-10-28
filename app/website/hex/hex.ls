#
# hex-as-pts = (width, height) ->
#   mp = (a) -> [(a.0 * width), (a.1 * height)]
#   [[ 0, 0 ],
#   [ 0.5, 0.25 ],
#   [ 0.5, 0.75 ],
#   [ 0, 1 ],
#   [ -0.5, 0.75 ],
#   [ -0.5, 0.25 ]].map mp
#
#
# c = SVG 'hex' .size \100% \400px
#
# min-stroke =
#   width: 1
#   color: '#e67e22'
# hx1 = hex-as-pts 50, 56
#
# h1 = c.polygon!
#   .plot hx1
#   .stroke min-stroke
#   .fill \transparent
#   .move 50 50
#
# p = c.circle 5
#  .fill \white
#  .center 50 50
#
# pts = h1.array!value
#
# c0 = pts.1
# c1 = pts.2
# c2 = pts.3
# c3 = pts.4
# c4 = pts.5
# c5 = pts.0
#
# f = ([x, y]) ->
#   !->
#     @animate!center x, y
#
# fs = pts.map (p) -> f p
#
# f = !->
#   p.animate!center c0.0, c0.1 .after !->
#     @animate!center c1.0, c1.1 .after !->
#       @animate!center c2.0, c2.1 .after !->
#         @animate!center c3.0, c3.1 .after !->
#           @animate!center c4.0, c4.1 .after !->
#             @animate!center c5.0, c5.1 .after !->
#
# do
#   set-interval f, 6000
#   f!
#
#
# # image = c.rect 300 300
# # image.filter (add) !->
# #   add.gaussianBlur(30, 0)
#
# p2 = c.circle 5
#   .fill 'rgba(243, 156, 18, 1.0)'
#   .center c0.0, c0.1
#   .filter (add) !-> add.gaussianBlur 1
#
# p2.animate 3000
#   .attr 'values' 0
#   .loop!
