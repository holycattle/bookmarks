
momentum = angular.module "Momentum", [
  "Momentum.controllers"
  "Momentum.directives"
  "ui.bootstrap"
]

momentum.config ["$routeProvider", ($routeProvider) ->

  $routeProvider.when "/home",
    templateUrl: "html/home.html"
    controller: "HomeController"
  
  $routeProvider.when "/recipes",
    templateUrl: "html/recipes.html"

  $routeProvider.when "/lessons",
    templateUrl: "html/lesson.html"

  $routeProvider.when "/404",
    templateUrl: "html/404.html"

  $routeProvider.when "/",
    redirectTo: "/home"
  
  $routeProvider.otherwise redirectTo: "/404"
]
