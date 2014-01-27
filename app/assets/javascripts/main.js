var tdlist = angular.module("tdlist",[]);

tdlist
    .config(function($routeProvider, $httpProvider) {      
        $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content') 
    	$routeProvider
    		.when('/', {
    			templateUrl: '../templates/list.html',
                controller:  'IndexCtrl'
    		})
    		.when('/new', {
    			templateUrl: '../templates/new.html',
                controller: 'CreateCtrl'
    		})
            .otherwise({
                redirectTo: '/'
            })
    });