@tdlist
	.controller 'IndexCtrl', ($scope, $rootScope, $http, $location, middleware, storage) ->
		
		source = new EventSource '/messages'

		source.onmessage = (event) ->

			$scope.$apply ->
				storage.set('pendingItems',JSON.parse event.data)
				$scope.data = storage.get('pendingItems')
		
		$scope.data = storage.get('pendingItems')

		$scope.destroy = (id) ->
			redirect = '/ok'
			$http.
				delete('/messages/' + id).
				success(middleware.success($location, redirect)).
				error (data, status) ->
					if status is 0
						pendingItems = storage.get('pendingItems')
						find = false
						angular.forEach pendingItems, (key, value) ->
							if !find
								if key.id is id
									$scope.data.splice value,1
									storage.set('pendingItems', $scope.data)
									find = true
		
		$scope.update = (message)->
			$rootScope.id        = message.id
			$rootScope.todoTitle = message.title;
			$rootScope.todoDescr = message.description;

			$location.path('/edit');

		$scope.done = (message) ->
 			 bootbox.prompt "How much did you (0..100%) ?", (res) ->
 			 	if parseInt(res) and res <= 100 and res >=0
 			 		params = 
 			 			id: message.id, 
 			 			done: res
	 				$http.
						put('/messages/' + message.id, params).
						success(middleware.success($location, '/')).
						error (data, status) ->
							if status is 0
								pendingItems = storage.get('pendingItems')
								find = false
								angular.forEach pendingItems, (key, value) ->
									if !find
										if key.id is params.id
											pendingItems[value].done = params.done
											$scope.data = pendingItems
											storage.set('pendingItems', $scope.data)
											find = true
											$location.path '/ok'

toJSON = (messages) ->
	data = messages.substring(messages.indexOf('['), messages.indexOf(']')+1)
	JSON.parse(data)
