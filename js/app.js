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
      .state('login', {
				url: '/login',
        parent: 'root',
				templateUrl: './html/login.html',
        controller: 'loginController'
			})
      .state('szolgaltatasaink', {
				url: '/szolgaltatasaink',
        parent: 'root',
				templateUrl: './html/szolgaltatasaink.html'
			})
      .state('araink', {
				url: '/araink',
        parent: 'root',
				templateUrl: './html/araink.html'
			})
      .state('idopontFoglalo', {
				url: '/idopontFoglalo',
        parent: 'root',
				templateUrl: './html/idopontFoglalo.html'
			})
      
      $urlRouterProvider.otherwise('/');
    }
  ])

	// Application run
  .run([
    function() {
      console.log("Run...");
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
	
})(window, angular);