var tdlist = angular.module("tdlist",['ngSanitize']);

tdlist
    .config(function($routeProvider, $httpProvider) {      
        $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
    	$routeProvider
    		.when('/', {
    			templateUrl: '../templates/list.html',
                controller:  'IndexCtrl'
    		})
    		.when('/new', {
    			templateUrl: '../templates/new.html',
                controller: 'CreateCtrl'
    		})
            .when('/edit', {
                templateUrl: '../templates/edit.html',
                controller: 'CreateCtrl'
            })
            .otherwise({
                redirectTo: '/'
            });
    });