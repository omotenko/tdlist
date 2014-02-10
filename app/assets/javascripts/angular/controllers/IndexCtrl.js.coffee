@tdlist
	.controller 'IndexCtrl', ($scope, $rootScope, $http, $location, middleware) ->

		source = new EventSource '/messages'
		source.onmessage = ->
			$scope.$apply ->
				$scope.data = JSON.parse event.data

		$scope.destroy = (id)->
			redirect = '/ok'
			$http.
				delete('/messages/' + id).
				success(middleware.success($location, redirect)).
				error(middleware.error)

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
						error(middleware.error)
			

toJSON = (messages) ->
	data = messages.substring(messages.indexOf('['), messages.indexOf(']')+1)
	JSON.parse(data)
