
momentum = angular.module "Momentum.controllers", []

momentum.controller "HomeController", ['$scope', '$http', '$location', '$log', ($scope, $http, $location, $log) ->

  #controls the modal
  $scope.isOpen = false

  $scope.openContactModal = ->
    $scope.isOpen = true

  $scope.closeContactModal = ->
    $scope.isOpen = false
    $log.log $scope.isOpen

  $scope.opt =
    backdropFade: true
    dialogFade: true
]

momentum.controller "NavController", ['$scope', '$http', '$location', '$log', ($scope, $http, $location, $log) ->
  #controls smooth scrolling
  $scope.scrollToHash = (hash='') ->  
    if $location.url() != '/home'
      $location.path('/home').hash(hash)

    $.scrollTo("#" + hash, {
      duration: 500
    })
]