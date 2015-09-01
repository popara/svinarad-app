
http-all-good = !->
	it.$http-backend.verify-no-outstanding-expectation!
	it.$http-backend.verify-no-outstanding-request!


describe 'States' !->
	$state = null
	ctrl = null

	before-each module "jonny.client"
	before-each inject (_$state_, $root-scope, $controller) !->
		$state := _$state_
		$scope = $root-scope.$new!
		$state.current.data =
			inject: false
		ctrl := $controller 'ModelOptionsNext' {$scope, model: -> 4, options: -> {}, period: -> 6}


	describe 'Signup' (,) !->
		it 'Should have controller' !->
			s = $state.get 'signup'
			s.data.next.should.be.equal 'matching'

	describe 'ModelOptionsNext' (,) !->
		ctrl = null
		$state = null
		$root = null
		ctrlp = null
		$scope = null
		before-each inject (_$state_, $root-scope, $controller) !->
			$state := _$state_
			$root := $root-scope
			ctrlp := $controller
			$scope := $root.$new!
			ctrl := ctrlp 'ModelOptionsNext' {$scope, model: -> 4, options: -> {}, period: -> 6}

		it 'Should exitst' !->
			expect $scope.attempt .to.be.a \function


describe 'Services' !->
	@Login = 0
	@$http-backend = 0
	@Registration = 0



	# 	@Login = _Login_
	# 	@Registration = _Registration_


	# describe 'Authentication' (,) !->
	# 	okMe test-user
	# 	before-each !->
	# 		@$http-backend.expectPOST '/api/user/login/' do
	# 			username: 'dd'
	# 			password: 'aa'
	# 		.respond 200 {message:'ook', id: 0}

	# 		x = @Login.attempt 'dd' 'aa'
	# 		@$http-backend.flush!
	# 		expect x.then .to.be

	# 	it 'should send and HTTP POST request' http-all-good


	# describe "Registration" (,) !->
	# 	okMe test-user
	# 	describe "initial" (,) !->
	# 		test-profile = do
	# 			username: \pera

	# 		before-each !->
	# 			@$http-backend.expectPOST '/api/user/register/' test-profile
	# 			.respond 200 {}
	# 			@$http-backend.expectPOST '/api/user/login/' test-profile
	# 			.respond 200 {}

	# 			@Registration.initial test-profile.username, test-profile.password, test-profile.email

	# 			@$http-backend.flush!

	# 		it 'should contact api endpoint' http-all-good

	# 	describe "patch" (,) !->
	# 		user = 1
	# 		test-profile = do
	# 			first-name: \pera
	# 			last-name: \peric

	# 		before-each !->
	# 			@$http-backend.expectPATCH '/api/user/1/' test-profile
	# 			.respond 200 {}

	# 			@Registration.patch test-profile
	# 			@$http-backend.flush!

	# 		it 'should contact api endpoint' http-all-good
