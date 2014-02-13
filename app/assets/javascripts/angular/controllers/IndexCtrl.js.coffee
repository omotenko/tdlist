@tdlist
	.controller 'IndexCtrl', ($scope, $rootScope, $http, $location, middleware, storage) ->

		pendingItems = angular.toJson storage.get 'pendingItems'

		if pendingItems is angular.toJson []
			source = new EventSource '/messages'
			source.onmessage = (event) ->
				$scope.$apply ->
					storage.set('pendingItems',JSON.parse event.data)
					$scope.data = storage.get('pendingItems')
		
		$scope.data = storage.get('pendingItems')

		sendPending = () ->
			if navigator.onLine and ((source is undefined) or (source.readyState is 2)) 
					pendingItems = angular.toJson storage.get('pendingItems')
					$.ajax 
						url: '/messages/:cache', 
						method: 'PUT',
						data: 
							items: pendingItems, 
						success: () ->
							storage.set 'pendingItems', []
							source = new EventSource '/messages'
							source.onmessage = (event) ->
								$scope.$apply ->
									storage.set('pendingItems',JSON.parse event.data)
									$scope.data = storage.get('pendingItems')

							$scope.data = storage.get('pendingItems')
			setTimeout sendPending, 500

		sendPending()

		$scope.new = () ->
			if source isnt undefined
				source.close()
		$scope.destroy = (id) ->
			redirect = '/ok'
			$http.
				delete('/messages/' + id).
				success(middleware.success($location, redirect, storage)).
				error (data, status) ->
					if status is 0
						pendingItems = storage.get('pendingItems')
						if source isnt undefined
							source.close() 
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

			if source isnt undefined
				source.close()
			$location.path('/edit');

		$scope.done = (message) ->
 			 bootbox.prompt "How much did you (0..100%) ?", (res) ->
 			 	if parseInt(res) and res <= 100 and res >=0
 			 		params = 
 			 			id: message.id, 
 			 			done: res
	 				$http.
						put('/messages/' + message.id, params).
						success(middleware.success($location, '/', storage)).
						error (data, status) ->
							if status is 0
								pendingItems = storage.get('pendingItems')
								if source isnt undefined
									source.close() 
								find = false
								angular.forEach pendingItems, (key, value) ->
									if !find
										if key.id is params.id
											pendingItems[value].done = params.done
											$scope.data = pendingItems
											storage.set('pendingItems', $scope.data)
											find = true

toJSON = (messages) ->
	data = messages.substring(messages.indexOf('['), messages.indexOf(']')+1)
	JSON.parse(data)
