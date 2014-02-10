@tdlist
	.controller 'IndexCtrl', ($scope, $rootScope, $http, $location) ->

		source = new EventSource '/messages'
		source.onmessage = ->
			$scope.$apply ->
				$scope.data = JSON.parse event.data

		$scope.destroy = (id)->
			redirect = '/ok'
			$http.
				delete('/messages/' + id).
				success(success($location, redirect)).
				error(error)

		$scope.update = (message)->
			$rootScope.id        = message.id
			$rootScope.todoTitle = message.title;
			$rootScope.todoDescr = message.description;

			$location.path('/edit');

toJSON = (messages) ->
	data = messages.substring(messages.indexOf('['), messages.indexOf(']')+1)
	JSON.parse(data)