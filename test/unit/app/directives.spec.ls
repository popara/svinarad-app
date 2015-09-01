{sum, reverse} = require 'prelude-ls'
#describe-directive = (name, restriction, element, scoper, tests) ->
#	describe name !->
#		@element = ''
#		@outer-scope = ''
#		@inner-scope = ''
#
#		before-each module "App"
#		okMe test-user
#		before-each inject ($root-scope, $compile, Activity) !->
#			@element = angular.element element
#			outer-scope = _.merge($root-scope.$new!, scoper)
#			($compile @element)(outer-scope)
#			inner-scope = @element.isolate-scope!
#			outer-scope.$digest!
#
#describe 'athlete-activity' !->
#	@element = 'bas'
#	outer-scope = ''
#	inner-scope = ' '
#
#
#	before-each module "App"
#	before-each inject ($root-scope, $compile, Activity) !->
#		@element = angular.element '<athlete-activity activitity="act"></athlete-activity>'
#
#		outer-scope = $root-scope.$new!
#		outer-scope.act = new Activity!
#		($compile @element)(outer-scope)
#		inner-scope = @element.isolate-scope!
#		outer-scope.$digest!
#
#
#	describe 'label' (,) !->
#		it 'be rendered' !->
#			expect @element .to.equal @element
