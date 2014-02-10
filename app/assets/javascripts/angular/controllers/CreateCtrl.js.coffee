@tdlist
	.controller 'CreateCtrl', ($scope, $rootScope, $http, $location, middleware) ->
		HOME_PATH = '/'

		$scope.save = ->
			params = 
				title: $scope.todoTitle
				description: $scope.todoDescr
			$http.
				post('/messages', params).
				success(middleware.success($location, HOME_PATH)).
				error(middleware.error)
				
		$scope.update = ->
			params = 
				id: $rootScope.id
				title: $scope.todoTitle 
				description: $scope.todoDescr

			$http.
				put('/messages/' + params.id, params).
				success(middleware.success($location, HOME_PATH)).
				error(middleware.error)

			$rootScope.todoTitle = $rootScope.todoDescr = null

