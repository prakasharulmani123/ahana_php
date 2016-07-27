app.controller('OrganizationController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'editableOptions', 'editableThemes', 'transformRequestAsFormPost', function ($rootScope, $scope, $timeout, $http, $state, editableOptions, editableThemes, transformRequestAsFormPost) {

        editableThemes.bs3.inputClass = 'input-sm';
        editableThemes.bs3.buttonsClass = 'btn-sm';
        editableOptions.theme = 'bs3';

        //Organization Index
        $scope.loadData = function () {
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/organization/getorg",
                method: "GET"
            }).then(
                    function (response) {
                        if (response.data.success === true) {
                            _that.data = response.data.return;
                        }
                        else {
                            $scope.errorData = response.data;
                        }
                    }
            )
        };

        //ChangePassword
        $scope.initChangePassword = function () {
            $('.sb-toggle-right').trigger('click');
        }

        $scope.changePassword = function () {
            _that = this;

            $scope.errorData = "";
            $scope.msg.successMessage = "";

            post_url = $rootScope.IRISOrgServiceUrl + '/user/changepassword';
            method = 'POST';
            succ_msg = 'Password changed successfully';

            $scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        if (response.success == true) {
                            $scope.msg.successMessage = succ_msg;
                            $scope.data = {};
                        } else {
                            $scope.errorData = response.message;
                        }
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        }

        $scope.checkValue = function (data) {
            if (!data) {
                return "Not empty";
            }
        };

        $scope.initSettings = function () {
//            $('.sb-toggle-right').trigger('click');
            $scope.isLoading = true;
            // pagination set up
            $scope.rowCollection = [];  // base collection
            $scope.itemsByPage = 10; // No.of records per page
            $scope.displayedCollection = [].concat($scope.rowCollection);  // displayed collection

            // Get data's from service
            $http.get($rootScope.IRISOrgServiceUrl + '/appconfigurations')
                    .success(function (configurations) {
                        $scope.config_data = [];
                        $scope.config_share_data = [];

                        angular.forEach(configurations, function (conf) {
                            var string = conf.key;
                            substring = "SHARE";

                            if (string.indexOf(substring) > -1 == false) {
                                $scope.config_data.push(conf);
                            } else {
                                $scope.config_share_data.push(conf);
                            }
                        });

                        $scope.isLoading = false;
                        $scope.rowCollection = $scope.config_data;
                        $scope.displayedCollection = [].concat($scope.rowCollection);
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading settings!";
                    });
        }

        $scope.updateSetting = function ($data, config_id) {
            $scope.errorData = "";
            $scope.msg.successMessage = "";

            $scope.loadbar('show');
            $http({
                method: 'PUT',
                url: $rootScope.IRISOrgServiceUrl + '/appconfigurations/' + config_id,
                data: $data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.msg.successMessage = 'Updated successfully';
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        }

        $scope.updateShareSetting = function () {
            $scope.errorData = "";
            $scope.msg.successMessage = "";

            _data = $('#shareform').serialize();
//            _data = $('#shareform').serialize() + '&' + $.param({
//                'encounter_id': $scope.encounter.encounter_id,
//                'patient_id': $state.params.id,
//            });

            $scope.loadbar('show');
            $http({
                method: 'POST',
                url: $rootScope.IRISOrgServiceUrl + '/organization/updatesharing',
                transformRequest: transformRequestAsFormPost,
                data: _data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.msg.successMessage = 'Share Settings Updated successfully';
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        }
    }]);

// I provide a request-transformation method that is used to prepare the outgoing
// request as a FORM post instead of a JSON packet.
app.factory(
        "transformRequestAsFormPost",
        function () {
            // I prepare the request data for the form post.
            function transformRequest(data, getHeaders) {
                var headers = getHeaders();
                headers[ "Content-type" ] = "application/x-www-form-urlencoded; charset=utf-8";
                return(serializeData(data));
            }
            // Return the factory value.
            return(transformRequest);
            // ---
            // PRVIATE METHODS.
            // ---
            // I serialize the given Object into a key-value pair string. This
            // method expects an object and will default to the toString() method.
            // --
            // NOTE: This is an atered version of the jQuery.param() method which
            // will serialize a data collection for Form posting.
            // --
            // https://github.com/jquery/jquery/blob/master/src/serialize.js#L45
            function serializeData(data) {
                // If this is not an object, defer to native stringification.
                if (!angular.isObject(data)) {
                    return((data == null) ? "" : data.toString());
                }
                var buffer = [];
                // Serialize each key in the object.
                for (var name in data) {
                    if (!data.hasOwnProperty(name)) {
                        continue;
                    }
                    var value = data[ name ];
                    buffer.push(
                            encodeURIComponent(name) +
                            "=" +
                            encodeURIComponent((value == null) ? "" : value)
                            );
                }
                // Serialize the buffer and clean it up for transportation.
                var source = buffer
                        .join("&")
                        .replace(/%20/g, "+")
                        ;
                return(source);
            }
        }
);