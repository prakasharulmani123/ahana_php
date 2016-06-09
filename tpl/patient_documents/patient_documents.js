app.controller('DocumentsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'transformRequestAsFormPost', '$anchorScroll', function ($rootScope, $scope, $timeout, $http, $state, transformRequestAsFormPost, $anchorScroll) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';

        //Notifications
        $scope.isPatientHaveActiveEncounter = function (callback) {
            $http.post($rootScope.IRISOrgServiceUrl + '/encounter/patienthaveactiveencounter', {patient_id: $state.params.id})
                    .success(function (response) {
                        callback(response);
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                        callback(response);
                    });
        }

        $scope.xml = '';
        $scope.xslt = '';
        $scope.data = {};

        $scope.initForm = function () {
            $scope.isPatientHaveActiveEncounter(function (response) {
                if (response.success == false) {
                    alert("Sorry, you can't create a document");
                    $state.go("patient.view", {id: $state.params.id});
                } else {
                    $scope.encounter = response.model;

                    $scope.getDocumentType(function (response) {
                        if (response.success == false) {
                            alert("Sorry, you can't create a document");
                            $state.go("patient.view", {id: $state.params.id});
                        } else {
                            if ($scope.data.form_type == 'create') {
                                $scope.xml = response.result.document_xml;

                            } else {
                                var doc_id = $state.params.doc_id;
                                $scope.getDocument(doc_id, function (response) {
                                    $scope.xml = response.result.document_xml;
                                });
                            }
                            $scope.xslt = response.result.document_xslt;
                        }
                    });
                }
            });
        }

        $scope.getDocumentType = function (callback) {
            $http.get($rootScope.IRISOrgServiceUrl + '/patientdocuments/getdocumenttype?doc_type=CH')
                    .success(function (response) {
                        callback(response);
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                        callback(response);
                    });
        }

        $scope.getDocument = function (doc_id, callback) {
            $http.get($rootScope.IRISOrgServiceUrl + '/patientdocuments/getdocument?doc_id=' + doc_id)
                    .success(function (response) {
                        callback(response);
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                        callback(response);
                    });
        }

        $scope.updateDocumentType = function () {
            _data = {xml: $scope.xml, xslt: $scope.xslt};
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/patientdocuments/updatedocumenttype",
                method: "POST",
                data: _data,
            }).then(
                    function (response) {
                        $scope.loadbar('hide');
//                        $scope.xml = response.data.xml;
                    }
            );
        }

        $scope.submitXsl = function () {
            _data = $('#xmlform').serialize() + '&' + $.param({
                'encounter_id': $scope.encounter.encounter_id,
                'patient_id': $state.params.id,
            });

            $scope.loadbar('show');
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/patientdocuments/savedocument",
                method: "POST",
                transformRequest: transformRequestAsFormPost,
                data: _data,
            }).then(
                    function (response) {
                        $scope.loadbar('hide');
                        if(response.success == true){
                            $scope.xml = response.data.xml;
                        }else{
                            $scope.errorData = response.data.message;
                            $anchorScroll();
                        }
                    }
            );
        }

        $("body").on("click", ".addMore", function () {
            var button_id = $(this).attr('id');
            var table_id = $(this).data('table-id');
            var rowCount = $('#' + table_id + ' tbody  tr').length;

            _data = $('#xmlform').serialize() + '&' + $.param({
                'encounter_id': $scope.encounter.encounter_id,
                'patient_id': $state.params.id,
                'button_id': button_id,
                'table_id': table_id,
                'rowCount': rowCount,
            });

            $http({
                url: $rootScope.IRISOrgServiceUrl + "/patientdocuments/savedocument",
                method: "POST",
                transformRequest: transformRequestAsFormPost,
                data: _data,
            }).then(
                    function (response) {
                        $scope.loadbar('hide');
                        if(response.success == true){
                            $scope.xml = response.data.xml;
                        }else{
                            $scope.errorData = response.data.message;
                            $anchorScroll();
                        }
                    }
            );
        });

        //Save Both Add & Update Data
        $scope.saveForm = function (mode) {
            _that = this;

            $scope.errorData = "";
            $scope.successMessage = "";

            if (mode == 'add') {
                post_url = $rootScope.IRISOrgServiceUrl + '/patientnotes';
                method = 'POST';
                succ_msg = 'Note saved successfully';

                angular.extend(_that.data, {
                    patient_id: $scope.patientObj.patient_id,
                    encounter_id: $scope.encounter.encounter_id
                });
            } else {
                post_url = $rootScope.IRISOrgServiceUrl + '/patientnotes/' + _that.data.pat_note_id;
                method = 'PUT';
                succ_msg = 'Note updated successfully';
            }

            $scope.loadbar('show');
            $http({
                method: method,
                url: post_url,
                data: _that.data,
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.successMessage = succ_msg;
                        $scope.data = {};
                        $timeout(function () {
                            $state.go('patient.notes', {id: $state.params.id});
                        }, 1000)

                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };

        //Get Data for update Form
        $scope.loadForm = function () {
            $scope.loadbar('show');
            _that = this;
            $scope.errorData = "";
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/patientnotes/" + $state.params.note_id,
                method: "GET"
            }).success(
                    function (response) {
                        $scope.loadbar('hide');
                        $scope.data = response;
                        $scope.encounter = {encounter_id: response.encounter_id};
                    }
            ).error(function (data, status) {
                $scope.loadbar('hide');
                if (status == 422)
                    $scope.errorData = $scope.errorSummary(data);
                else
                    $scope.errorData = data.message;
            });
        };


    }]);


app.filter("sanitize", ['$sce', function ($sce) {
        return function (htmlCode) {
            return $sce.trustAsHtml(htmlCode);
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