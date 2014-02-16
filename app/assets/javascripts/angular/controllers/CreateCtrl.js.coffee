@tdlist
	.controller 'CreateCtrl', ($scope, $rootScope, $http, $location, middleware, storage) ->
		HOME_PATH = '/'

		$scope.save = ->
			params = 
				title: $scope.todoTitle
				description: $scope.todoDescr
			$http.
				post('/messages', params).
				success(middleware.success($location, HOME_PATH, storage)).
				error (data, status) ->

					if status is 0
						middleware.online()
						pendingItems = (storage.get('pendingItems') or [])

						if pendingItems.length is 0
							params.id = 1 
						else
							params.id = pendingItems[0]["data"].id + 1							
						params.done = '0'
						params.updated_at = new Date 
						item = 
							data: params
							method: "save"
						pendingItems.unshift item
						storage.set('pendingItems', pendingItems)
						data = storage.get 'allItems'
						data.unshift item.data
						$rootScope.data = data
						storage.set('allItems', data)
						$location.path '/'
				
		$scope.update = ->
			params = 
				id: $rootScope.id
				title: $scope.todoTitle 
				description: $scope.todoDescr
			$http.
				put('/messages/' + params.id, params).
				success(middleware.success($location, HOME_PATH, storage)).
				error (data, status) ->
					if status is 0
						middleware.offline()
						allItems = storage.get('allItems')
						pendingItems = storage.get('pendingItems')
						find = false
						angular.forEach allItems, (key, value) ->
							if !find
								if key.id is params.id
									allItems[value].title = params.title
									allItems[value].description = params.description
									$rootScope.data = allItems
									storage.set('allItems', allItems)
									item = 
										data: allItems[value]
										method: "update"
									angular.forEach pendingItems, (key, value) ->
											if key["data"].id is params.id
												pendingItems[value]["data"] = item.data
												find = true
									if !find
										pendingItems.push item
									storage.set 'pendingItems', pendingItems
									find = true
									$location.path '/'

			$rootScope.todoTitle = $rootScope.todoDescr = null

