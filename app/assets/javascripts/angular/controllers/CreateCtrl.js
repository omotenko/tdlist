tdlist
	.controller('CreateCtrl', function($scope, $http) {
		$scope.save = function() {
			$http.
				post('/messages', {name: "oleg"}).
				success(function(data, status) {
					$http.get('/messages')
					$scope.status = status;
					$scope.data = data;
				}).
				error(function(data, status) {
					$scope.data = data || "Request failed";
					$scope.status = status;
				});
		}

	})