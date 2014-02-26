function affiche($scope, $http){
	$http.get("https://api.github.com/users/miton18/repos")
	  .success(function (data) {
	    $scope.repos = data;
	    $scope.reposFound = data.length;
	});
}