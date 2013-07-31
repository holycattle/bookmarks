
momentum = angular.module "Momentum.controllers", [
  'ui.select2'
]

momentum.controller "HomeController", ['$scope', '$rootScope', '$http', '$location', '$log', ($scope, $rootScope, $http, $location, $log) ->
  ### mock database ###
  if !$rootScope.linkDatabase?
    $rootScope.linkDatabase =
      'http://programmers.stackexchange.com/questions/46716/what-should-every-programmer-know-about-web-development':
        title: 'What Every Programmer Should Know About Web Development'
        topics: ['programming', 'educational', 'technology']
        notes: 'Might be useful when people ask where to start learning web dev.'
      'http://ultimatemegax.wordpress.com/2012/11/23/chuunibyou-demo-koi-ga-shitai-volume-1-translation/':
        topics: ['manga', 'anime', 'fiction', 'Japanese']
        notes: 'Translation of the Chuu2Koi light novel'
        title: "Chuunibyou Demo Koi ga Shitai vol. 1 Translation"
      'http://business.time.com/2013/03/06/how-to-write-clearly/':
        title: 'How to Write Clearly'
        topics: ['lifestyle', 'language', 'educational']
        notes: 'How to write clearly.'
      'https://www.coursera.org/course/bigdata':
        title: 'Web Intelligence and Big Data'
        topics: ['educational', 'science']
        notes: 'Coursera MOOC on Web Intelligence and Big Data'
      'http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/':
        title: 'Electrical Engineering and Computer Science Courses from MIT'
        topics: ['educational', 'technology']
        notes: 'MIT OCW EE and CS courses'

    $rootScope.topics = ['programming', 'educational', 'technology', 'manga', 'anime', 'fiction', 'Japanese', 'culture', 'lifestyle', 'language']

  if $scope.currentUser?
    $location.path '/manage'
    

  $rootScope.getTopics = ->
    list = []
    for l in $rootScope.linkDatabase
      for t in l.topics
        list.push t if t in l.topics and not (t in $rootScope.topics)
    $log.log list

  ###
  control stuff for the signup modal
  ###
  $scope.signupIsOpen = false
  $scope.openSignupModal = ->
    $log.log "open signup", $scope.signupIsOpen
    $scope.signupIsOpen = true

  $scope.closeSignupModal = ->
    $log.log "close signup", $scope.signupIsOpen
    $scope.signupIsOpen = false

  $scope.opt =
    backdropFade: true
    dialogFade: true
]

momentum.controller "ManageController", ['$scope', '$rootScope', '$http', '$location', '$log', ($scope, $rootScope, $http, $location, $log) ->
  $scope.linkDatabase = $rootScope.linkDatabase

  if !$scope.currentUser?
    $location.path '/home'

  ### control stuff for add modal ###
  $scope.isOpen = false

  $scope.openModal = ->
    $scope.isOpen = true

  $scope.closeModal = ->
    $scope.isOpen = false

  $scope.opt =
    backdropFade: true
    dialogFade: true

  $scope.selectOptions =
    'multiple': true
    'simple_tags': true
    'tags': $rootScope.topics

  $scope.data = {}
  ### Add button controller ###
  $scope.add = ->
    $rootScope.linkDatabase["#{$scope.data.link}"] =
      title: $scope.data.title
      topics: $scope.data.topics
      notes: $scope.data.notes

    $rootScope.$apply()
    $scope.data = {}
    $scope.closeModal()
]

momentum.controller "AuthController", ['$scope', '$rootScope', '$http', '$location', '$log', ($scope, $rootScope, $http, $location, $log) ->
  if !$rootScope.userDatabase?
    $rootScope.userDatabase = {}

  $scope.signup = ->
    $rootScope.userDatabase[$scope.signupData.username] =
      username: $scope.signupData.username
      password: $scope.signupData.password
    $log.log $scope.isOpen
    $scope.login($rootScope.userDatabase[$scope.signupData.username])

    $scope.signupData = {}
    $scope.closeSignupModal()
    $log.log $rootScope.userDatabase

  $scope.loginData = {}

  $scope.signUpNow = ->
    $scope.$parent.closeLoginModal()
    $scope.$parent.$$nextSibling.openSignupModal()

  $scope.login = (data=$scope.loginData) ->
    if $rootScope.userDatabase[data.username]?
      if $rootScope.userDatabase[data.username].password == data.password
        $rootScope.currentUser = $rootScope.userDatabase[data.username]
        $location.path '/manage'
        $scope.loginIsOpen = false
        $scope.loginData = {}
      else
        $scope.loginError = {message: 'Invalid login credentials.'}
    else
      $log.log 'sucker'
      $scope.loginError = {message: 'Invalid login credentials.'}

  $scope.logout = ->
    $rootScope.currentUser = null
    $location.path '/'
    $rootScope.$apply()
]

momentum.controller "NavController", ['$scope', '$http', '$location', '$log', ($scope, $http, $location, $log) ->
  ###
  control stuff for the login modal
  ###
  $scope.loginIsOpen = false
  $scope.openLoginModal = ->
    $log.log 'open login modal', $scope.loginIsOpen
    $scope.loginIsOpen = true

  $scope.closeLoginModal = ->
    $log.log 'close login modal', $scope.loginIsOpen
    $scope.loginIsOpen = false

  $scope.opt =
    backdropFade: true
    dialogFade: true


  ### controls smooth scrolling ###
  $scope.scrollToHash = (hash='') ->  
    if $location.url() != '/home'
      $location.path('/home').hash(hash)

    $.scrollTo("#" + hash, {
      duration: 500
    })
]