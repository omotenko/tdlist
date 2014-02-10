@tdlist
	.controller 'CreateCtrl', ($scope, $rootScope, $http, $location) ->
		HOME_PATH = '/'

		$scope.save = ->
			params = 
				title: $scope.todoTitle
				description: $scope.todoDescr
			$http.
				post('/messages', params).
				success(success($location, HOME_PATH)).
				error(error)
				
		$scope.update = ->
			params = 
				id: $rootScope.id
				title: $scope.todoTitle 
				description: $scope.todoDescr

			$http.
				put('/messages/' + params.id, params).
				success(success($location, HOME_PATH)).
				error(error)

			$rootScope.todoTitle = $rootScope.todoDescr = null

success = ($location, path) ->
	(data, status) ->
		$location.path(path)

error = (data, status) ->
	$scope.errors = '<p><i>' + status + ':' + data + '</i></p>'
