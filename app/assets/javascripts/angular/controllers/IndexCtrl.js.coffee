@tdlist
	.controller 'IndexCtrl', ($scope, $rootScope, $http, $location, middleware, storage) ->

		pendingItems = storage.get 'pendingItems'

		if (pendingItems is undefined) or (pendingItems.length is 0)
			source = startEventSource $scope, storage

		$scope.data = storage.get 'allItems'
		send = null
		sendPending = () ->
			if navigator.onLine and ((source is undefined) or (source.readyState is 2)) 
					pendingItems = storage.get('pendingItems')
					if (pendingItems isnt undefined) and (pendingItems.length isnt 0)
						$.ajax 
							url: '/messages/:cache', 
							method: 'PUT',
							data: 
								items: angular.toJson pendingItems, 
							success: () ->
								storage.set 'pendingItems', []
								source = startEventSource $scope, storage
								middleware.online()
							error: () ->
								middleware.offline()
			else
				if !navigator.onLine
					middleware.offline()
				else
					middleware.online()

			send = setTimeout sendPending, 500

		sendPending()

		$scope.new = () ->
			closeEventSource source
			clearTimeout(send)

		$scope.destroy = (id) ->
			redirect = '/ok'
			$http.
				delete('/messages/' + id).
				success(middleware.success($location, redirect, storage)).
				error (data, status) ->
					if status is 0
						middleware.offline()
						find = false
						angular.forEach $scope.data, (key, value) ->
							if !find
								if key.id is id
									item = 
										data: $scope.data[value]
										method: 'destroy'
									$scope.data.splice value,1
									pendingItems = storage.get 'pendingItems'
									angular.forEach pendingItems, (key, value) ->
										if key["data"].id is id
											pendingItems.splice value,1
											find = true
									if !find
										pendingItems.push item
									storage.set 'pendingItems', pendingItems
									closeEventSource source
									storage.set('allItems', $scope.data)
									find = true
		
		$scope.update = (message)->
			$rootScope.id        = message.id
			$rootScope.todoTitle = message.title;
			$rootScope.todoDescr = message.description;
			closeEventSource source
			clearTimeout(send)
			$location.path('/edit');

		$scope.done = (message) ->
 			 bootbox.prompt "How much did you (0..100%) ?", (res) ->
 			 	if parseInt(res) and (res <= 100 and res >=0)
 			 		params = 
 			 			id: message.id, 
 			 			done: res
	 				$http.
						put('/messages/' + message.id, params).
						success(middleware.success($location, '/', storage)).
						error (data, status) ->
							#do nothing
startEventSource = ($scope, storage) ->
	source = new EventSource '/messages'
	source.onmessage = (event) ->
		$scope.$apply ->
			storage.set('allItems',JSON.parse event.data)
			$scope.data = JSON.parse event.data 
	return source 

closeEventSource = (source) ->
	if source isnt undefined
		source.close()