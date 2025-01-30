;(function(window, angular) {

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
            templateUrl: './html/header.html'
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
				templateUrl: './html/schedule.html'
			})
      .state('prices', {
				url: '/prices',
        parent: 'root',
				templateUrl: './html/prices.html'
			})
      .state('gallery', {
				url: '/gallery',
        parent: 'root',
				templateUrl: './html/gallery.html'
			})
      .state('contact', {
				url: '/contact',
        parent: 'root',
				templateUrl: './html/contact.html'
			})
      .state('policies', {
				url: '/policies',
        parent: 'root',
				templateUrl: './html/policies.html'
			})
      .state('login', {
        url: '/login',
        templateUrl: 'login.html', // A login.html fájl
        controller: 'LoginController'
      })
      .state('register', {
        url: '/register',
        templateUrl: 'register.html', // A register.html fájl
        controller: 'RegisterController'
      });
      
		
      $urlRouterProvider.otherwise('/');
    }
  ])

	// Application run
  .run([
    function() {
      console.log("Run...");
    }
  ])

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
  
  .controller('loginController', [
    '$scope',
    function($scope) {
      
      const container = document.getElementById('container');
      const registerbtn = document.getElementById('register');
      const loginbtn = document.getElementById('login');

      registerbtn.addEventListener('click', ()=> {
          container.classList.add("active"); 
      })

      loginbtn.addEventListener('click', ()=> {
          container.classList.remove("active"); 
      })
  }]);


})

 
      
	
(window, angular);