tdlist
	.controller('CreateCtrl', function($scope, $http) {
		$scope.save = function() {
			$http.
				post('/messages', {name: "oleg"}).
				success(function(data, status) {
					$scope.status = status;
					$scope.data = data;
				}).
				error(function(data, status) {
					$scope.data = "Failed";
					$scope.status = status;
				});
		}

	})