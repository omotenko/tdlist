var tdlist = angular.module("tdlist",['ngSanitize']);

tdlist
    .config(function($routeProvider, $httpProvider) {      
        $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
        $httpProvider.defaults.headers.patch = {
            'Content-Type': 'application/json;charset=utf-8'
        }
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