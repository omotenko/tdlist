tdlist
	.controller('IndexCtrl', function($scope,$rootScope, $http, $location) {
		$http.
		get('/messages').
		success(function(data, status) {
			$scope.status = status;
			$scope.data = data;
		}).
		error(function(data, status) {
			$scope.data = data || "Failed";
		});

		$scope.destroy = function(id) {
			$http.
			delete('/messages/' + id).
			success(function(data, status) {
				$location.path('/ok');
			}).
			error(function(data, status) {
				$scope.data = data || "Failed";
			});
		}

		$scope.update = function(message) {
			$rootScope.id        = message.id
			$rootScope.todoTitle = message.title;
			$rootScope.todoDescr = message.description;

			$location.path('/edit');

		}
	});

function toJSON(messages) {
	var data = messages.substring(messages.indexOf('['), messages.indexOf(']')+1);

	return JSON.parse(data);
}



