@tdlist
	.factory "middleware", () ->
		success: ($location, path) ->
            (data, status) ->
                 $location.path(path)

        error: (data, status) ->
            $scope.errors = '<p><i>' + status + ':' + data + '</i></p>'