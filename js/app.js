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
            resolve: {
              loggedIn: [
                "authService",
                "$state",
                function (authService, $state) {
                  if (!authService.isLoggedIn()) {
                    $state.go("login");
                  }
                },
              ],
            },
          });

        $urlRouterProvider.otherwise("/");
      },
    ])

    .run([
      function () {
        console.log("Run...");
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

    .controller("serviceController", [
      "$scope",
      "$http",
      function ($scope, $http) {
        $http
          .get("./php/getServices.php")
          .then(function (response) {
            $scope.services = response.data;
          })
          .catch(function (e) {
            console.log(e);
          });
      },
    ])

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
      .controller("contactController", [
        "$scope",
        "$http",
        function ($scope, $http) {
          $scope.contact = {};
  
          $scope.submitForm = function () {
            $http
              .post("./php/contact.php", $scope.contact)
              .then(function (response) {
                // If the message is saved (even if response format isn't perfect)
                alert("Üzenet sikeresen elküldve!");
                $scope.contact = {};
              })
              .catch(function (error) {
                if (error.status === 404) {
                  alert("A szerver nem található.");
                } else if (error.status === 500) {
                  alert("Szerver oldali hiba történt.");
                } else {
                  // Try to get error message from response if available
                  const errorMsg =
                    error.data && error.data.error
                      ? error.data.error
                      : "Hiba történt az üzenet küldése során.";
                  alert(errorMsg);
                }
              });
          };
        },
      ])
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
          if ($scope.registerForm.$valid) {
            $http
              .post("./php/register.php", $scope.user)
              .then(function (response) {
                if (response.data.success) {
                  $state.go("login");
                } else {
                  alert(
                    "Hiba történt a regisztráció során: " + response.data.error
                  );
                }
              })
              .catch(function (error) {
                alert("Hiba történt a regisztráció során.");
              });
          } else {
            alert("Kérjük, töltsd ki az összes mezőt helyesen!");
          }
        };
      },
    ])

    .controller("loginController", [
      "$scope",
      "$http",
      "$state",
      "authService",
      function ($scope, $http, $state, authService) {
        $scope.user = {
          username: "",
          password: "",
        };
        $scope.errorMessage = "";
        $scope.successMessage = "";

        // Bejelentkezési folyamat
        $scope.submitLoginForm = function () {
          if ($scope.loginForm.$valid) {
            $http
              .post("./php/login.php", $scope.user)
              .then(function (response) {
                console.log("Szerver válasz a bejelentkezéshez:", response);
                if (
                  response.data &&
                  response.data.data &&
                  response.data.data.user_id
                ) {
                  $scope.successMessage =
                    response.data.data.message || "Sikeres bejelentkezés!";
                  authService.login(response.data.data.user_id); // Bejelentkezés
                  setTimeout(function () {
                    $state.go("users"); // Irányítás a felhasználói oldalra
                  }, 500);
                } else {
                  $scope.errorMessage =
                    response.data.error || "Hibás felhasználónév vagy jelszó!";
                }
              })
              .catch(function (error) {
                $scope.errorMessage =
                  "Hiba történt a bejelentkezési kérés során.";
                console.error("Hiba a bejelentkezési kérés során:", error);
              });
          } else {
            $scope.errorMessage = "Kérjük, töltsd ki az összes mezőt helyesen!";
          }
        };
      },
    ])

    .controller("usersController", [
      "$scope",
      "$http",
      "$state",
      "authService",
      function ($scope, $http, $state, authService) {
        $scope.user = {};
        $scope.registeredPets = [];
        $scope.errorMessage = "";
        $scope.successMessage = "";
        $scope.editPetData = {};
        $scope.isEditing = false;

        $scope.loadUserData = function () {
          $http
            .get("./php/getUserData.php", {
              params: {
                user_id: authService.getUserId(),
              },
            })
            .then(function (response) {
              if (response.data.success) {
                $scope.user = response.data.user;
              } else {
                $scope.errorMessage =
                  "Hiba történt az adatok lekérése során: " +
                  response.data.error;
              }
            })
            .catch(function (error) {
              $scope.errorMessage = "Hiba történt az adatok lekérése során.";
            });
        };

        $scope.loadRegisteredPets = function () {
          $http
            .get("./php/getRegisteredPets.php", {
              params: {
                user_id: authService.getUserId(),
              },
            })
            .then(function (response) {
              if (response.data.success) {
                $scope.registeredPets = response.data.pets;
              } else {
                $scope.errorMessage =
                  "Hiba történt a kisállatok lekérése során: " +
                  response.data.error;
              }
            })
            .catch(function (error) {
              $scope.errorMessage = "Hiba történt a kisállatok lekérése során.";
            });
        };

        $scope.updateUser = function () {
          if ($scope.userForm.$valid) {
            $http
              .post("./php/updateUserData.php", {
                username: $scope.user.username,
                email: $scope.user.email,
                phone: $scope.user.phone,
              })
              .then(function (response) {
                if (response.data.success) {
                  $scope.successMessage =
                    "Felhasználói adatok sikeresen frissítve!";
                } else {
                  $scope.errorMessage =
                    "Hiba történt a frissítés során: " + response.data.error;
                }
              })
              .catch(function (error) {
                $scope.errorMessage = "Hiba történt a frissítés során.";
              });
          } else {
            $scope.errorMessage = "Kérjük, töltsd ki az összes mezőt helyesen!";
          }
        };

        $scope.deleteUser = function () {
          if (!authService.isLoggedIn()) {
            $scope.errorMessage =
              "Nem vagy bejelentkezve. Kérlek, jelentkezz be a fiók törléséhez.";
            return;
          }

          if (
            confirm(
              "Biztosan törölni szeretnéd a felhasználói fiókod? Ez a művelet a regisztrált kisállataidat is törölni fogja."
            )
          ) {
            $http
              .post("./php/deleteUser.php", {
                user_id: authService.getUserId(),
              })
              .then(function (response) {
                if (response.data.success) {
                  authService.logout();
                  $state.go("home");
                } else {
                  $scope.errorMessage =
                    "Hiba történt a törlés során: " + response.data.error;
                }
              })
              .catch(function (error) {
                $scope.errorMessage = "Hiba történt a törlés során.";
              });
          }
        };

        $scope.enableEditUser = function () {
          $scope.isEditingUser = true;
        };

        $scope.disableEdit = function () {
          $scope.isEditingUser = false;
          $scope.isEditingPet = false;
        };

        $scope.editPet = function (pet) {
          $scope.editPetData = angular.copy(pet);
          $scope.isEditingPet = true;
        };

        $scope.saveEditPet = function () {
          $http
            .post("./php/updatePetData.php", $scope.editPetData)
            .then(function (response) {
              if (response.data.success) {
                $scope.successMessage = "Kisállat adatai sikeresen frissítve!";
                $scope.loadRegisteredPets();
                $scope.isEditingPet = false;
              } else {
                $scope.errorMessage =
                  "Hiba történt a frissítés során: " + response.data.error;
              }
            })
            .catch(function (error) {
              $scope.errorMessage = "Hiba történt a frissítés során.";
            });
        };

        $scope.deletePet = function (petId) {
          $http
            .delete("./php/deletePet.php?id=" + petId)
            .then(function (response) {
              if (response.data.success) {
                $scope.successMessage = "Kisállat sikeresen törölve!";
                $scope.loadRegisteredPets();
              } else {
                $scope.errorMessage =
                  "Hiba történt a törlés során: " + response.data.error;
              }
            })
            .catch(function (error) {
              $scope.errorMessage = "Hiba történt a törlés során.";
            });
        };

        $scope.newPet = {};
        $scope.registrationSuccess = false;

        $scope.registerPet = function () {
          $http
            .post("./php/registerPet.php", $scope.newPet)
            .then(function (response) {
              if (response.data.success) {
                $scope.loadRegisteredPets();
                $scope.newPet = {};
                $scope.registrationSuccess = true;
                setTimeout(function () {
                  $scope.registrationSuccess = false;
                }, 3000);
              } else {
                $scope.errorMessage =
                  "Hiba történt a regisztráció során: " + response.data.error;
              }
            })
            .catch(function (error) {
              $scope.errorMessage = "Hiba történt a regisztráció során.";
            });
        };

        $scope.loadUserData();
        $scope.loadRegisteredPets();
      },
    ])

    .controller("scheduleController", [
      "$scope",
      "$http",
      function ($scope, $http) {
        // Inicializáljuk a scheduleData objektumot
        $scope.scheduleData = {
          serviceType: "",
          petId: "",
          appointmentDate: "",
          appointmentTime: "",
        };

        // Inicializáljuk a pets tömböt
        $scope.pets = [];

        // Regisztrált kisállatok betöltése
        $scope.getRegisteredPets = function () {
          $http.get("./php/getRegisteredPets.php").then(
            function (response) {
              // A válaszban kapott kisállatok listájának beállítása
              $scope.pets = response.data;
            },
            function (error) {
              // Hiba kezelése
              alert(
                "Hiba történt a kisállatok betöltése során: " +
                  error.data.message
              );
            }
          );
        };

        // Hívjuk meg a getRegisteredPets funkciót az oldal betöltésekor
        $scope.getRegisteredPets();

        // Űrlap beküldése
        $scope.submitScheduleForm = function () {
          if ($scope.scheduleForm.$valid) {
            // Itt küldjük el az űrlap adatokat a szerverre
            $http.post("./php/schedule.php", $scope.scheduleData).then(
              function (response) {
                // Sikeres válasz kezelése
                alert("Időpontfoglalás sikeres!");
                // Űrlap törlése
                $scope.scheduleData = {};
              },
              function (error) {
                // Hiba kezelése
                alert(
                  "Hiba történt az időpontfoglalás során: " + error.data.message
                );
              }
            );
          } else {
            alert("Kérjük, töltse ki az összes kötelező mezőt!");
          }
        };
      },
    ]);
})(window, angular);
