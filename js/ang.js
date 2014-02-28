var App = angular.module('App', []);

App.controller('ctrl', function($scope) {


});

App.filter('moinsZ', function() {
    return function( $scope) {
        return $scope;
    }
});

function affiche($scope, $http){
	$http.get("https://api.github.com/users/miton18/repos")
	  .success(function (data) {
	    $scope.repos = data;
	    $scope.reposFound = data.length;
	});
}