(function(window, angular) {
  'use strict';

  // Application module
  angular.module('app', [
      'ui.router',
      'app.common',
  ])
  

  // Application config
  .config([
      '$stateProvider',
      '$urlRouterProvider',
      function($stateProvider, $urlRouterProvider) {

          $stateProvider
              .state('root', {
                  views: {
                      '': { 
                          templateUrl: './html/root.html'
                      },
                      'header@root': {
                          templateUrl: './html/header.html',
                          controller: 'headerController'
                      },
                      'footer@root': {
                          templateUrl: './html/footer.html'
                      }
                  }
              })
              .state('home', {
                  url: '/',
                  parent: 'root',
                  templateUrl: './html/home.html'
              })
              .state('services', {
                  url: '/services',
                  parent: 'root',
                  templateUrl: './html/services.html',
                  controller: 'serviceController'
              })
              .state('schedule', {
                url: '/schedule',
                parent: 'root',
                templateUrl: './html/schedule.html',
                controller: 'scheduleController',
                
              })
              
              .state('prices', {
                  url: '/prices',
                  parent: 'root',
                  templateUrl: './html/prices.html',
                  controller: 'pricesController'
              })
              .state('gallery', {
                  url: '/gallery',
                  parent: 'root',
                  templateUrl: './html/gallery.html',
                  controller: 'galleryController'
              })
              .state('contact', {
                  url: '/contact',
                  parent: 'root',
                  templateUrl: './html/contact.html',
                  controller: 'contactController'
              })
              .state('policies', {
                  url: '/policies',
                  parent: 'root',
                  templateUrl: './html/policies.html'
              })
              .state('login', {
                  url: '/login',
                  parent:'root',
                  templateUrl: './html/login.html',
                  controller: 'loginController'
              })
              .state('register', {
                  url: '/register',
                  parent: 'root',
                  templateUrl: './html/register.html',
                  controller: 'registerController'
              })
              .state('users', {
                url: '/users',
                parent: 'root',
                templateUrl: './html/users.html',
                controller: 'usersController',
                resolve: {
                    loggedIn: ['authService', '$state', '$http', function(authService, $state, $http) {
                      
                        if (!authService.isLoggedIn()) {
                            $state.go('login');
                            return; // Fontos a return, hogy ne fusson tovább a kód
                        }
                    }]
                }
            })

        $urlRouterProvider.otherwise('/');
    }])
  
    .run([function() { console.log("Run..."); }])
  
    .factory('authService', ['$http', '$state', function($http, $state) {
        var isLoggedIn = false;
        var userId = null; // Felhasználó azonosítója
    
        return {
            isLoggedIn: function() {
                return isLoggedIn;
            },
            login: function(userId) {
                isLoggedIn = true;
                this.userId = userId; // Felhasználó azonosítójának tárolása
            },
            logout: function() {
                isLoggedIn = false;
                this.userId = null; // Felhasználó azonosítójának törlése
                $state.go('home');
            },
            getUserId: function() {
                return this.userId; // Felhasználó azonosítójának visszaadása
            }
        };
    }])
    .controller('headerController', ['authService', function(authService) {
      var vm = this;
      vm.authService = authService;
  }])

  .controller('serviceController', [
      '$scope',
      'http',
      function($scope, http) {
          http.request('./php/getServices.php')
              .then(response => {
                  $scope.services = response;
                  $scope.$applyAsync();
              })
              .catch(e => console.log(e));
      }
  ])

  .controller('galleryController', [
      '$scope',
      'http',
      function($scope, http) {
          http.request('./php/getGallery.php')
              .then(response => {
                  $scope.gallery = response;
                  $scope.$applyAsync();
              })
              .catch(e => console.log(e));
      }
  ])

  .controller('pricesController', [
      '$scope',
      'http',
      function($scope, http) {
          http.request('./php/getprices.php')
              .then(response => {
                  $scope.prices = response;
                  $scope.$applyAsync();
              })
              .catch(e => alert(e));
      }
  ])

  .controller('registerController',
      function($scope, $http, $state) {
          $scope.user = {
              username: '',
              phone: '',
              email: '',
              confirmEmail: '',
              password: '',
              confirmPassword: ''
          };

          $scope.submitForm = function() {
              if ($scope.registerForm.$valid) {
                  $http.post('./php/register.php', $scope.user)
                      .then(function(response) {
                          if (response.data.success) {
                              $state.go('login')
                          } else {
                              alert('Hiba történt a regisztráció során: ' + response.data.error);
                          }
                      })
                      .catch(function(error) {
                          alert('Hiba történt a regisztráció során.');
                      });
              } else {
                  alert('Kérjük, töltsd ki az összes mezőt helyesen!');
              }
          }
      }
  )
  .controller('loginController', ['$scope', '$http', '$state', 'authService', function($scope, $http, $state, authService) {
    $scope.user = {
        username: '',
        password: ''
    };

    $scope.submitForm = function() {
        if ($scope.loginForm.$valid) {
            $http.post('./php/login.php', $scope.user)
                .then(function(response) {
                    if (response.data.success) {
                        $scope.successMessage = 'Sikeres bejelentkezés!';
                        authService.login(); // authService login meghívása
                        setTimeout(function() {
                            $state.go('users'); // átirányítás
                        }, 500);
                    } else {
                        $scope.errorMessage = response.data.error;
                    }
                })
                .catch(function(error) {
                    $scope.errorMessage = 'Hiba történt a bejelentkezés során.';
                });
        } else {
            $scope.errorMessage = 'Kérjük, töltsd ki az összes mezőt helyesen!';
        }
    }
}])

.controller('usersController', ['$scope', '$http', '$state', 'authService', function($scope, $http, $state, authService) {
    // Felhasználói adatok lekérése
    $scope.loadUserData = function() {
        $http.get('./php/getUserData.php', {
            params: {
                user_id: authService.getUserId() // Felhasználó azonosítója
            }
        })
        .then(function(response) {
            if (response.data.success) {
                $scope.user = response.data.user;
            } else {
                alert('Hiba történt az adatok lekérése során: ' + response.data.error);
            }
        })
        .catch(function(error) {
            alert('Hiba történt az adatok lekérése során.');
        });
    };

    // Felhasználói adatok frissítése
    $scope.updateUser = function() {
        if ($scope.userForm.$valid) {
            $http.post('./php/updateUser.php', $scope.user)
                .then(function(response) {
                    if (response.data.success) {
                        alert('Felhasználói adatok sikeresen frissítve!');
                    } else {
                        alert('Hiba történt a frissítés során: ' + response.data.error);
                    }
                })
                .catch(function(error) {
                    alert('Hiba történt a frissítés során.');
                });
        } else {
            alert('Kérjük, töltsd ki az összes mezőt helyesen!');
        }
    };

    // Felhasználó törlése
    $scope.deleteUser = function() {
        if (confirm('Biztosan törölni szeretnéd a felhasználói fiókod?')) {
            $http.post('./php/deleteUser.php', {
                user_id: authService.getUserId() // Felhasználó azonosítója
            })
            .then(function(response) {
                if (response.data.success) {
                    authService.logout(); // Kijelentkeztetés
                    $state.go('home'); // Átirányítás a kezdőlapra
                } else {
                    alert('Hiba történt a törlés során: ' + response.data.error);
                }
            })
            .catch(function(error) {
                alert('Hiba történt a törlés során.');
            });
        }
    };

    // Felhasználói adatok betöltése
    $scope.loadUserData();
}])



})(window, angular);