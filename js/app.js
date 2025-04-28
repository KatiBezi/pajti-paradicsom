(function (window, angular) {
  "use strict";

  // Application module
  angular
    .module("app", ["ui.router", "app.common"])

    // Application config
    .config([
      "$stateProvider",
      "$urlRouterProvider",
      function ($stateProvider, $urlRouterProvider) {
        $stateProvider
          .state("root", {
            views: {
              "": {
                templateUrl: "./html/root.html",
              },
              "header@root": {
                templateUrl: "./html/header.html",
                controller: "headerController",
              },
              "footer@root": {
                templateUrl: "./html/footer.html",
              },
            },
          })
          .state("home", {
            url: "/",
            parent: "root",
            templateUrl: "./html/home.html",
          })
          .state("services", {
            url: "/services",
            parent: "root",
            templateUrl: "./html/services.html",
            controller: "serviceController",
          })
          .state("schedule", {
            url: "/schedule",
            parent: "root",
            templateUrl: "./html/schedule.html",
            controller: "scheduleController",
          })
          .state("prices", {
            url: "/prices",
            parent: "root",
            templateUrl: "./html/prices.html",
            controller: "pricesController",
          })
          .state("gallery", {
            url: "/gallery",
            parent: "root",
            templateUrl: "./html/gallery.html",
            controller: "galleryController",
          })
          .state("contact", {
            url: "/contact",
            parent: "root",
            templateUrl: "./html/contact.html",
            controller: "contactController",
          })
          .state("policies", {
            url: "/policies",
            parent: "root",
            templateUrl: "./html/policies.html",
          })
          .state("login", {
            url: "/login",
            parent: "root",
            templateUrl: "./html/login.html",
            controller: "loginController",
          })
          .state("register", {
            url: "/register",
            parent: "root",
            templateUrl: "./html/register.html",
            controller: "registerController",
          })
          .state("users", {
            url: "/users",
            parent: "root",
            templateUrl: "./html/users.html",
            controller: "usersController",
          });

        $urlRouterProvider.otherwise("/");
      },
    ])

    .run([
      "trans",
      function (trans) {
        trans.events(["users"]);
      },
    ])

    .factory("authService", [
      "$http",
      "$state",
      function ($http, $state) {
        var isLoggedIn = false;
        var userId = null;

        return {
          isLoggedIn: function () {
            return isLoggedIn;
          },
          login: function (id) {
            isLoggedIn = true;
            userId = id;
          },
          logout: function () {
            isLoggedIn = false;
            userId = null;
            $state.go("home");
          },
          getUserId: function () {
            return userId;
          },
        };
      },
    ])

    .controller("headerController", [
      "authService",
      "$scope",
      "$http",
      function (authService, $scope, $http) {
        var vm = this;
        vm.authService = authService;
        $scope.isLoggedIn = authService.isLoggedIn();
        $scope.successMessage = "";

        $scope.$watch(
          function () {
            return authService.isLoggedIn();
          },
          function (newValue, oldValue) {
            if (newValue !== oldValue) {
              $scope.isLoggedIn = newValue;
            }
          }
        );

        $scope.logout = function () {
          $http
            .get("./php/logout.php")
            .then(function (response) {
              authService.logout();
              $scope.successMessage = "Sikeres kijelentkezés!";
              setTimeout(function () {
                $scope.successMessage = "";
              }, 3000);
            })
            .catch(function (error) {
              console.error("Hiba a kijelentkezés során:", error);
            });
        };
      },
    ])
    //OK
    .controller("serviceController", [
      "$scope",
      "http",
      function ($scope, http) {
        http
          .request("./php/getServices.php")
          .then((response) => {
            $scope.services = response;
            $scope.$applyAsync();
          })
          .catch((e) => console.log(e));
      },
    ])
    //OK
    .controller("galleryController", [
      "$scope",
      "http",
      function ($scope, http) {
        http
          .request("./php/getGallery.php")
          .then((response) => {
            $scope.gallery = response;
            $scope.$applyAsync();
          })
          .catch((e) => console.log(e));
      },
    ])
    //OK
    .controller("pricesController", [
      "$scope",
      "http",
      function ($scope, http) {
        http
          .request("./php/getprices.php")
          .then((response) => {
            $scope.prices = response;
            $scope.$applyAsync();
          })
          .catch((e) => alert(e));
      },
    ])
    //OK
    .controller("contactController", [
      "$scope",
      "$http",
      function ($scope, $http) {
        $scope.contact = {};
        $scope.submitContactForm = function () {
          $http
            .post("./php/contact.php", $scope.contact)
            .then((response) => {
              alert("Üzenet sikeresen elküldve!");
              $scope.contact = {};
            })
            .catch((e) => console.log(e));
        };
      },
    ])
    //OK
    .controller("registerController", [
      "$scope",
      "$http",
      "$state",
      function ($scope, $http, $state) {
        $scope.user = {
          username: "",
          phone: "",
          email: "",
          confirmEmail: "",
          password: "",
          confirmPassword: "",
        };

        $scope.submitRegisterForm = function () {
          $http
            .post("./php/register.php", $scope.user)
            .then(function (response) {
              const res = response.data;

              if (res.error) {
                alert("Hiba: " + res.error);
                return;
              }

              alert("Felhasználó sikeresen regisztrálva!");
              $scope.user = {};
              $state.go("login");
            })
            .catch(function (e) {
              console.log("Hiba történt:", e);
            });
        };
      },
    ])

    //OK
    .controller("loginController", [
      "$scope",
      "$http",
      "$state",
      "authService",
      "http",
      function ($scope, $http, $state, authService, http) {
        $scope.user = {
          username: "",
          password: "",
        };
        $scope.errorMessage = "";
        $scope.successMessage = "";

        // Bejelentkezési folyamat
        $scope.submitLoginForm = function () {
          http
            .request({
              url: "./php/login.php",
              data: $scope.user,
            })
            .then((response) => {
              authService.login(response.user_id);
              setTimeout(function () {
                alert("Sikeres bejelenkezés!");
              }, 500);
              $state.go("users");
            })
            .catch((e) => alert(e));
        };
      },
    ])
    //OK
    .controller("usersController", [
      "$scope",
      "$http",
      "$state",
      "authService",
      "http",
      function ($scope, $http, $state, authService, http) {
        // Inicializálás
        $scope.user = {};
        $scope.registeredPets = [];
        $scope.editPetData = {};
        $scope.isEditingUser = false;
        $scope.isEditingPet = false;
        $scope.errorMessage = "";
        $scope.successMessage = "";
        $scope.registrationSuccess = false;

        // Felhasználói adatok betöltése
        $scope.loadUserData = function () {
          http
            .request({
              url: "./php/getUserData.php",
              data: { user_id: authService.getUserId() },
            })
            .then((response) => {
              console.log(response);
              $scope.user = response;
              $scope.$applyAsync();
            })
            .catch((error) => console.log(error));
        };

        // Regisztrált kisállatok betöltése
        $scope.loadRegisteredPets = function () {
          http
            .request({
              url: "./php/getRegisteredPets.php",
              data: { user_id: authService.getUserId() },
            })
            .then((response) => {
              console.log(response);
              $scope.registeredPets = response;
              $scope.$applyAsync();
            })
            .catch((error) => console.log(error));
        };
        // Felhasználói adat szerkesztése engedélyezése
        $scope.enableEditUser = function () {
          $scope.isEditingUser = true;
        };

        // Szerkesztés letiltása
        $scope.disableEdit = function () {
          $scope.isEditingUser = false;
          $scope.isEditingPet = false;
        };

        // Felhasználó adatainak frissítése
        $scope.updateUser = function () {
          
          console.log("Elküldendő adatok:", {
              username: $scope.user.username,
              email: $scope.user.email,
              phone: $scope.user.phone,
              id: $scope.user.id,
              user_id: authService.getUserId()
          })
          $http
            .post("./php/updateUserData.php", $scope.user)
            .then(() => {
              alert("Felhasználói adatok sikeresen frissítve!");
              $scope.loadUserData();
              $scope.isEditingUser = false;
            })
            .catch((e) => console.log(e));
        };

        // Felhasználói fiók törlése
        $scope.deleteUser = function () {
          if (confirm("Biztosan törölni szeretnéd a felhasználói fiókodat?")) {
            $http
              .post("./php/deleteUser.php", { user_id: authService.getUserId() })
              .then(function () {
                alert("A fiók törlésére vonatkozó kérés sikeres volt. A fiók törlésre kerül.");
                authService.logout(); // Kijelentkeztetés
                $state.go("home"); // Átirányítás a főoldalra
              })
              .catch((e) => {
                console.log(e); // Hiba konzolra
                alert("Hiba történt a fiók törlése során. Kérlek próbáld újra.");
              });
          }
        };
        // Kisállat szerkesztés
        $scope.editPet = function (pet) {
          console.log("Szerkesztendő kisállat:", pet)
          $scope.editPetData = angular.copy(pet); // Másolat készítése a módosításhoz
          $scope.isEditingPet = true;
        };

        // Kisállat adatainak mentése
        $scope.saveEditPet = function () {
          console.log("Elküldendő adatok:", $scope.editPetData); // Ellenőrizd, hogy van-e pet_id
          $http
            .post("./php/updatePetData.php", $scope.editPetData)
            .then((response) => {
              alert("Kisállat adatai sikeresen frissítve!");
              $scope.loadRegisteredPets();
              $scope.isEditingPet = false;
            })
            .catch((e) => console.log(e));
        };
        // Kisállat törlése
        $scope.deletePet = function (petId) {
          $http
            .delete("./php/deletePet.php", { data: { pet_id: petId } })
            .then(() => {
              alert("Kisállat sikeresen törölve!");
              $scope.loadRegisteredPets(); // Kisállatok újratöltése
            })
            .catch((e) => console.log(e));
        };

        // Új kisállat regisztrálása
        $scope.registerPet = function () {
          $http
            .post("./php/registerPet.php", {
              user_id: authService.getUserId(),
              pet_name: $scope.newPet.name,
              pet_type: $scope.newPet.type,
              pet_age: $scope.newPet.age,
              description: $scope.newPet.description,
            })
            .then(() => {
              alert("Kisállat sikeresen regisztrálva!");
              $scope.newPet = {}; // Regisztrálás után töröljük a formot
              $scope.loadRegisteredPets(); // Kisállatok újratöltése
            })
            .catch((e) => console.log(e));
        };

        // Adatok betöltése
        $scope.loadUserData();
        $scope.loadRegisteredPets();
      },
    ])
   .controller("scheduleController", [
  "$scope",
  "$http",
  "authService",
  "http",
  function ($scope, $http, authService, http) {
    $scope.scheduleData = {
      serviceType: "",
      subServiceId: "",
      petId: "",
      appointmentDate: "",
      appointmentTime: "",
      user_id: authService.getUserId(),
    };
// EZ OK
    $scope.pets = [];  // Kisállatok listája
    // Kisállatok betöltése
    $scope.loadRegisteredPets = function () {
      http.request({
        url: "./php/getPetsSchedule.php",
        data: { user_id: authService.getUserId() },
      }).then(function(response) {
        console.log("Kisállatok betöltve:", response);
        $scope.pets = response;
      }).catch((e) => console.log(e));
    };
    // Betöltéskor automatikusan kérjük le a kisállatokat
    $scope.loadRegisteredPets();
  }
]);

})(window, angular);