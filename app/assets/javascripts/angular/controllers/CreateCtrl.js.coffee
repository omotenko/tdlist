@tdlist
	.controller 'CreateCtrl', ($scope, $rootScope, $http, $location, middleware, storage) ->
		HOME_PATH = '/'

		$scope.save = ->
			params = 
				title: $scope.todoTitle
				description: $scope.todoDescr
			$http.
				post('/messages', params).
				success(middleware.success($location, HOME_PATH)).
				error (data, status) ->
					if status is 0
						pendingItems = storage.get('pendingItems')

						params.id = pendingItems[0].id + 1
						params.done = '0'
						params.updated_at = new Date 

						pendingItems.unshift params
						$scope.data = pendingItems
						storage.set('pendingItems', $scope.data)
						$location.path '/'
				
		$scope.update = ->
			params = 
				id: $rootScope.id
				title: $scope.todoTitle 
				description: $scope.todoDescr

			$http.
				put('/messages/' + params.id, params).
				success(middleware.success($location, HOME_PATH)).
				error (data, status) ->
					if status is 0
						pendingItems = storage.get('pendingItems')
						find = false
						angular.forEach pendingItems, (key, value) ->
							if !find
								if key.id is params.id
									pendingItems[value].title = params.title
									pendingItems[value].description = params.description

									$scope.data = pendingItems
									storage.set('pendingItems', $scope.data)

									find = true
									$location.path '/'

			$rootScope.todoTitle = $rootScope.todoDescr = null

