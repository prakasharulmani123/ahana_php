app.controller('OrganizationController', ['$rootScope', '$scope', '$timeout', '$http', '$state', function ($rootScope, $scope, $timeout, $http, $state) {

        //Index Page
        //  pagination
        $scope.rowCollection = [];  // base collection
        $scope.itemsByPage = 10;
        $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection
        // Display Data
//        $http.get($rootScope.IRISAdminServiceUrl + '/organizations?expand=coMasterCity,coMasterState,coMasterCountry')
        $http.get($rootScope.IRISAdminServiceUrl + '/organizations')
                .success(function (usr) {
                    $scope.rowCollection = usr;
                    $scope.displayedCollection = [].concat($scope.rowCollection);
//                console.log($scope.rowCollection);
                })
                .error(function () {
                    $scope.error = "An Error has occured while loading posts!";

                });


        // Form Page
        $scope.country = [];

        $http.get($rootScope.IRISAdminServiceUrl + "/default/get-country-list").then(
                function (response) {
                    $scope.countries = response.data.countryList;
                }
        );
        $http.get($rootScope.IRISAdminServiceUrl + "/default/get-state-list").then(
                function (response) {
                    $scope.states = response.data.stateList;
                }
        );
        $http.get($rootScope.IRISAdminServiceUrl + "/default/get-city-list").then(
                function (response) {
                    $scope.cities = response.data.cityList;
                }
        );

        $http.get($rootScope.IRISAdminServiceUrl + "/default/get-module-tree").then(
                function (response) {
                    $scope.modules = response.data.moduleList;
                }
        );

        $scope.title_codes = [{value: 'Mr.', label: 'Mr.'}, {value: 'Mrs.', label: 'Mrs.'}, {value: 'Miss.', label: 'Miss.'}, {value: 'Dr.', label: 'Dr.'}];

        $scope.updateState = function () {
            $scope.availableStates = [];
            $scope.availableCities = [];

            angular.forEach($scope.states, function (value) {
                if (value.countryId == $scope.data.Tenant.tenant_country_id) {
                    var obj = {
                        value: value.value,
                        label: value.label
                    };
                    $scope.availableStates.push(obj);
                }
            });
        }

        $scope.updateCity = function () {
            $scope.availableCities = [];

            angular.forEach($scope.cities, function (value) {
                if (value.stateId == $scope.data.Tenant.tenant_state_id) {
                    var obj = {
                        value: value.value,
                        label: value.label
                    };
                    $scope.availableCities.push(obj);
                }
            });
        }

        $scope.updateState2 = function () {
            $scope.availableStates2 = [];
            $scope.availableCities2 = [];

            angular.forEach($scope.states, function (value) {
                if (value.countryId == $scope.data.User.country_id) {
                    var obj = {
                        value: value.value,
                        label: value.label
                    };
                    $scope.availableStates2.push(obj);
                }
            });
        }

        $scope.updateCity2 = function () {
            $scope.availableCities2 = [];

            angular.forEach($scope.cities, function (value) {
                if (value.stateId == $scope.data.User.state_id) {
                    var obj = {
                        value: value.value,
                        label: value.label
                    };
                    $scope.availableCities2.push(obj);
                }
            });
        }


        $scope.saveForm = function (mode) {
            $scope.errorData = "";
            $scope.successMessage = "";

            $scope.moduleList = [];
            angular.forEach($scope.modules, function (parent) {
                if (parent.isSelected == true || parent.__ivhTreeviewIndeterminate == true) {
                    $scope.moduleList.push(parent.value);
                    angular.forEach(parent.items, function (child) {
                        if (child.isSelected == true)
                            $scope.moduleList.push(child.value);
                    });
                }
            });
            if (typeof $scope.data != "undefined") {
                $scope.data.Module = [];
                $scope.data.Module = {'resource_ids': $scope.moduleList};
            }

//            if ($scope.form.$valid) {
            $http({
                url: $rootScope.IRISAdminServiceUrl + '/organizations/saveorg',
                method: "POST",
                data: $scope.data
            }).then(
                    function (response) {
                        if (response.data.success === true) {
                            if (mode === 'edit') {
                                $scope.successMessage = "Organization updated successfully";
                                $timeout(function () {
                                    $state.go('app.org_list');
                                }, 1000)
                            }
                            else {
                                $scope.successMessage = "Organization saved successfully";
                                $scope.data = {};
                                $timeout(function () {
                                    $state.go('app.org_list');
                                }, 1000)
                            }
                        }
                        else {
                            $scope.errorData = response.data.message;
                        }
                    }
            )
//            }
        };

        $scope.loadForm = function () {
            alert('yes');
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISAdminServiceUrl + "/organization/get-org?id=" + $state.params.id,
                method: "GET"
            }).then(
                    function (response) {
                        if (response.data.success === true) {
                            console.log(response.data);
//                            $scope.data = response.data.floor;
                        }
                        else {
                            $scope.errorData = response.data;
                        }
                    }
            )
        };


//  $scope.rowCollectionBasic = [
//      {firstName: 'Laurent', lastName: 'Renard', birthDate: new Date('1987-05-21'), balance: 102, email: 'whatever@gmail.com'},
//      {firstName: 'Blandine', lastName: 'Faivre', birthDate: new Date('1987-04-25'), balance: -2323.22, email: 'oufblandou@gmail.com'},
//      {firstName: 'Francoise', lastName: 'Frere', birthDate: new Date('1955-08-27'), balance: 42343, email: 'raymondef@gmail.com'}
//  ];

//  $scope.removeRow = function(row) {
//      var index = $scope.rowCollectionBasic.indexOf(row);
//      if (index !== -1) {
//          $scope.rowCollectionBasic.splice(index, 1);
//      }
//  };

//  $scope.predicates = ['firstName', 'lastName', 'birthDate', 'balance', 'email'];
//  $scope.selectedPredicate = $scope.predicates[0];

//  var firstnames = ['Laurent', 'Blandine', 'Olivier', 'Max'];
//  var lastnames = ['Renard', 'Faivre', 'Frere', 'Eponge'];
//  var dates = ['1987-05-21', '1987-04-25', '1955-08-27', '1966-06-06'];
//  var id = 1;

//  function generateRandomItem(id) {
//
//      var firstname = firstnames[Math.floor(Math.random() * 3)];
//      var lastname = lastnames[Math.floor(Math.random() * 3)];
//      var birthdate = dates[Math.floor(Math.random() * 3)];
//      var balance = Math.floor(Math.random() * 2000);
//
//      return {
//          id: id,
//          firstName: firstname,
//          lastName: lastname,
//          birthDate: new Date(birthdate),
//          balance: balance
//      }
//  }

//  $scope.rowCollection = [];
//
//  for (id; id < 5; id++) {
//      $scope.rowCollection.push(generateRandomItem(id));
//  }

        //copy the references (you could clone ie angular.copy but then have to go through a dirty checking for the matches)
//  $scope.displayedCollection = [].concat($scope.rowCollection);

        //add to the real data holder
//  $scope.addRandomItem = function addRandomItem() {
//      $scope.rowCollection.push(generateRandomItem(id));
//      id++;
//  };

        //remove to the real data holder
//  $scope.removeItem = function(row) {
//      var index = $scope.rowCollection.indexOf(row);
//      if (index !== -1) {
//          $scope.rowCollection.splice(index, 1);
//      }
//  }

        // pip
//  var promise = null;
//  $scope.isLoading = false;
//  $scope.rowCollectionPip = [];
//  $scope.getPage = function() {
//      $http.get('api/groups').success(function(data) {
//        $scope.rowCollectionPip = data;
//      });
////    $scope.rowCollectionPip=[];
////    for (var j = 0; j < 20; j++) {
////      $scope.rowCollectionPip.push(generateRandomItem(j));
////    }
//  }
//
//  $scope.callServer = function getData(tableState) {
//      //here you could create a query string from tableState
//      //fake ajax call
//      $scope.isLoading = true;
//
//      $timeout(function () {
//          $scope.getPage();
//          $scope.isLoading = false;
//      }, 2000);
//  };
//
// $scope.getPage();

    }]);