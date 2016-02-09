app.controller 'gitCtrl', [ '$scope', '$http', ($scope, $http)->

    $http(
      method: 'GET'
      url: 'https://api.github.com/users/miton18/repos'
    )
    .then (rep)->
        $scope.repos = rep.data
        $scope.$apply

    , (err)->
        console.log err
]