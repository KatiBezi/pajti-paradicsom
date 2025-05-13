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
      "http",
      function ($scope, http) {
        $scope.contact = {};
        $scope.submitContactForm = function () {
          http.request({
            url: "./php/contact.php",
            data: $scope.contact
          })
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

        $scope.showPassword = false;
        $scope.showConfirmPassword = false;

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
      "$state",
      "authService",
      "http",
      function ($scope, $state, authService, http) {
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
          console.log("Elküldendő adatok:", $scope.editPetData); // van-e pet_id
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
              $scope.loadRegisteredPets(); 
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
      "$state",
      "authService",
      "http",
      "$filter",
      function ($scope, $state, authService, http, $filter) {
        // Inicializálás
        $scope.scheduleData = {
          serviceType: "",
          subServiceId: "",
          petId: "",
          appointmentDate: "",
          appointmentTime: "",
          comments: "",
          user_id: authService.getUserId()
        };

        $scope.pets = [];
        $scope.allPrices = [];
        $scope.filteredPrices = [];
        $scope.successMessage = "";
        $scope.errorMessage = "";

        // Szolgáltatás típusokhoz tartozó ID-k
        $scope.serviceIds = {
          panzio: 1,
          kozmetika: 2,
          fotozas: 3
        };

        // Betölti a kisállatokat
        $scope.loadRegisteredPets = function () {
          http.request({
            url: "./php/getPetsSchedule.php",
            data: { user_id: authService.getUserId() }
          }).then(function (response) {
            $scope.pets = response;
          }).catch(function (e) {
            console.error("Hiba történt a kisállatok betöltése során:", e);
            alert("Hiba történt a kisállatok betöltése során.");
          });
        };

        // Betölti az összes árat
        $scope.loadAllPrices = function () {
          http
            .request("./php/getprices.php")
            .then(function (response) {
              $scope.allPrices = response;
            })
            .catch(function (e) {
              console.error("Hiba az árak betöltése során:", e);
              alert("Hiba történt a szolgáltatások betöltése során.");
            });
        };

        // Szűri az árakat a kiválasztott szolgáltatás típus alapján
        $scope.loadSubServices = function () {
          if (!$scope.scheduleData.serviceType) {
            $scope.filteredPrices = [];
            return;
          }

          var serviceId = $scope.serviceIds[$scope.scheduleData.serviceType];
          $scope.filteredPrices = $scope.allPrices.filter(function (price) {
            return price.service_id == serviceId;
          });

          $scope.scheduleData.subServiceId = "";
        };

        // Holnapi nap beállítása 
        $scope.today = new Date();
        $scope.tomorrow = new Date($scope.today);
        $scope.tomorrow.setDate($scope.today.getDate() + 1);  // Holnapi nap beállítása

        // Holnapi dátum formázása
        $scope.tomorrow = $filter('date')($scope.tomorrow, 'yyyy-MM-dd');

        // Elküldi az időpontfoglalást
        $scope.submitAppointment = function () {
          $scope.successMessage = "";
          $scope.errorMessage = "";

          // Ellenőrzés, hogy van-e érvényes dátum és időpont
          if (!$scope.scheduleData.appointmentDate || !$scope.scheduleData.appointmentTime) {
            alert("Kérjük, válassz érvényes dátumot és időpontot!");
            return;
          }

          // Dátum formázása
          $scope.formattedDate = $filter("date")(new Date($scope.scheduleData.appointmentDate), "yyyy-MM-dd");

          // A POST kéréshez szükséges adat előkészítése
          $scope.requestData = {
            services_id: $scope.scheduleData.subServiceId,
            animal_id: $scope.scheduleData.petId,
            date: $scope.formattedDate,
            time: $scope.scheduleData.appointmentTime,
            comments: $scope.scheduleData.comments || ""
          };

          // HTTP kérés elküldése a backendhez
          http.request({
            url: "./php/schedule.php",
            method: "POST",
            data: $scope.requestData
          })
            .then(function (response) {
              alert("Sikeres időpontfoglalás! Időpont: " + $scope.formattedDate + " " + $scope.scheduleData.appointmentTime);

              // Űrlap alaphelyzetbe állítása
              $scope.scheduleData = {
                serviceType: "",
                subServiceId: "",
                petId: "",
                appointmentDate: "",
                appointmentTime: "",
                comments: "",
                user_id: authService.getUserId()
              };

              $scope.$applyAsync();
            })
            .catch((e) => {
              console.log(e);
              alert("A foglalás sikertelen. Válassz másik időpontot.");
            });
        };

        // Inicializálás
        $scope.loadRegisteredPets();
        $scope.loadAllPrices();
      }
    ])


})(window, angular);