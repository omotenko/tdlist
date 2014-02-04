tdlist
	.controller('CreateCtrl', function($scope, $rootScope, $http, $location) {
	
		$scope.save = function() {
			var params = {title: $scope.todoTitle, description: $scope.todoDescr};

			$http.
				post('/messages', params).
				success(function(data, status) {
					successfully('/');
				}).
				error(function(data, status) {
					$scope.errors = '<p><i>Failed.Try again!)</i></p>';
				});
		}

		$scope.update = function() {
			
			var params = {id: $scope.id, title: $scope.todoTitle, description: $scope.todoDescr};

			$http.
				put('/messages/' + params.id, params).
				success(function(data, status) {
					successfully('/');
				}).
				error(function(data, status) {
					$scope.errors = '<p><i>Failed.Try again!)</i></p>';
				});
		}

	});