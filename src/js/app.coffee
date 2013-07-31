
momentum = angular.module "Momentum", [
  "Momentum.controllers"
  "Momentum.directives"
  "ui.bootstrap"
  "ui.select2"
]

momentum.config ["$routeProvider", ($routeProvider) ->

  $routeProvider.when "/home",
    templateUrl: "html/home.html"
    controller: "HomeController"

  $routeProvider.when "/manage",
    templateUrl: "html/manage.html"
    controller: "ManageController"

  $routeProvider.when "/browse",
    templateUrl: "html/browse.html"

  $routeProvider.when "/404",
    templateUrl: "html/404.html"

  $routeProvider.when "/",
    redirectTo: "/home"
  
  $routeProvider.otherwise redirectTo: "/404"
]
