tdlist
	.controller('UpdateCtrl', function($scope, $http, $location) {

		$scope.update = function(id, title, description) {
			var params = {title: $scope.todoTitle, description: $scope.todoDescr};

			$scope.todoTitle = title;
			$scope.todoDescr = description;

			$location.path('/new');

			/*$http.
				patch('/messages' + id, params).
				success(function(data, status) {
					if (status == 200) {
						$location.path('/');
					}
				}).
				error(function(data, status) {
					$scope.errors = '<p><i>Failed.Try again!)</i></p>';
				});*/
		}

	})