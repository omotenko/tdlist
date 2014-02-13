@tdlist
	.factory "middleware", () ->
		success: ($location, path, storage) ->
            (data, status) ->
            	storage.set 'pendingItems', []
            	$location.path(path)

        error: (data, status) ->
			#$scope.errors = '<p><i>' + status + ':' + data + '</i></p>'