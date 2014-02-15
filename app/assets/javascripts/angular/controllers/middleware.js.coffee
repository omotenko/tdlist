@tdlist
	.factory "middleware", () ->
		success: ($location, path, storage) ->
            (data, status) ->
            	online()
            	storage.set 'pendingItems', []
            	$location.path(path)

        online : () ->
        	document.getElementById("network").innerHTML = "online"

        offline: () ->
        	document.getElementById("network").innerHTML = "offline"