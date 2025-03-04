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
        templateUrl: './html/schedule.html',
        controller: 'scheduleController'
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
        templateUrl: './html/gallery.html'
      })
      .state('contact', {
        url: '/contact',
        parent: 'root',
        templateUrl: './html/contact.html',
        controller: 'ContactController'
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

      registerbtn.addEventListener('click', () => {
          container.classList.add("active"); 
      });

      loginbtn.addEventListener('click', () => {
          container.classList.remove("active"); 
      });
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
  
  .controller('ContactController', [
    '$scope',
    'http',
    function($scope, http) {
    }
    // function sendMessage(event) {
    //   event.preventDefault(); // Megakadályozza az űrlap alapértelmezett elküldését
    //   // Itt lehetne a backend hívás, de most csak a felugró ablakot mutatjuk
    //   alert("Sikeres üzenetküldés!");
    //   document.getElementById("contactForm").reset(); // Űrlap törlése
    // }
  ])

  .controller('scheduleController', [
    '$scope',
    function($scope) {
      // Kezdeti változók beállítása
      $scope.selectedService = 'daycare'; // Alapértelmezett szolgáltatás
      $scope.numberOfPets = 0; // Alapértelmezett állatszám
      $scope.bookingDate = ''; // Dátum változó
      $scope.arrivalTime = ''; // Érkezés időpontja
      $scope.departureTime = ''; // Távozás időpontja
      $scope.successMessage = ''; // Sikeres üzenet
      $scope.errorMessage = ''; // Hibaüzenet

      // Elérhető érkezési időpontok
      $scope.availableArrivalTimes = ['08:00','09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00'];
      
      // Elérhető távozási időpontok
      $scope.availableDepartureTimes = ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00'];

      // Éjszakai szállás esetén elérhető érkezési időpontok
      $scope.availableArrivalTimesOvernight = ['18:00', '19:00', '20:00'];
      $scope.availableDepartureTimesOvernight = [ '06:00', '07:00', '08:00'];

      // Időpontok frissítése a szolgáltatás kiválasztásakor
      $scope.updateTimes = function() {
          // Időpontok resetelése, ha a szolgáltatás változik
          $scope.arrivalTime = '';
          $scope.departureTime = '';

          // Ha éjszakai szállás van kiválasztva, frissítjük az érkezési időpontokat
          if ($scope.selectedService === 'overnight') {
              $scope.availableArrivalTimes = $scope.availableArrivalTimesOvernight;
          } else {
              $scope.availableArrivalTimes = ['18:00', '19:00', '20:00'];
          }
      };

      // Foglalás beküldése
      $scope.submitBooking = function() {
          // Itt normál esetben a data-t a szerverre küldenénk
          // Példaként csak sikeres üzenetet jelenítünk meg
          $scope.successMessage = 'Sikeres foglalás!';
          $scope.errorMessage = '';
      };
      
    }
  ])


})(window, angular);
