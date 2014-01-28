tdlist
	.controller('IndexCtrl', function($scope, $http) {
		$http.
		get('/messages').
		success(function(data, status) {
			$scope.status = status;
			$scope.data = data;
		}).
		error(function(data, status) {
			$scope.data = data || "Failed";
			$scope.status = status;
		});
	})