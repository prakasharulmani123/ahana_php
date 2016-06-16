app.controller('DocumentsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'transformRequestAsFormPost', '$anchorScroll', '$filter', function ($rootScope, $scope, $timeout, $http, $state, transformRequestAsFormPost, $anchorScroll, $filter) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';

        $scope.xml = '';
        $scope.xslt = '';
        $scope.data = {};

        //Documents Index Page
        $scope.loadPatDocumentsList = function () {
            $scope.isLoading = true;
            $scope.rowCollection = [];

            $http.get($rootScope.IRISOrgServiceUrl + '/patientdocuments/getpatientdocuments?patient_id=' + $state.params.id)
                    .success(function (documents) {
                        $scope.isLoading = false;
                        $scope.rowCollection = documents.result;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patient document!";
                    });
        };

        // Check patient have active encounter
        $scope.isPatientHaveActiveEncounter = function (callback) {
            $http.post($rootScope.IRISOrgServiceUrl + '/encounter/patienthaveactiveencounter', {patient_id: $state.params.id})
                    .success(function (response) {
                        callback(response);
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                        callback(response);
                    });
        }

        // Get Case History Document Template - Create
        $scope.getDocumentType = function (callback) {
            $http.get($rootScope.IRISOrgServiceUrl + '/patientdocuments/getdocumenttype?doc_type=CH')
                    .success(function (response) {
                        callback(response);
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                        callback(response);
                    });
        }

        // Get Patient Document Template - Update
        $scope.getDocument = function (doc_id, callback) {
            $http.get($rootScope.IRISOrgServiceUrl + '/patientdocuments/getdocument?doc_id=' + doc_id)
                    .success(function (response) {
                        callback(response);
                    }, function (x) {
                        response = {success: false, message: 'Server Error'};
                        callback(response);
                    });
        }

        // Initialize Create and Update Form
        $scope.initForm = function () {
            $scope.isLoading = true;
            $scope.isPatientHaveActiveEncounter(function (response) {
                if (response.success == false) {
                    $scope.isLoading = false;
                    alert("Sorry, you can't create a document");
                    $state.go("patient.document", {id: $state.params.id});
                } else {
                    $scope.encounter = response.model;

                    $scope.getDocumentType(function (doc_type_response) {
                        if (doc_type_response.success == false) {
                            alert("Sorry, you can't create a document");
                            $state.go("patient.document", {id: $state.params.id});
                        } else {
                            $scope.xslt = doc_type_response.result.document_xslt;
                            $scope.xml = doc_type_response.result.document_xml;
                            $scope.isLoading = false;
                        }
                    });
                }
            });
        }

        // Initialize Create and Update Form
        $scope.initFormUpdate = function () {
            $scope.isLoading = true;
            $scope.getDocumentType(function (doc_type_response) {
                if (doc_type_response.success == false) {
                    $scope.isLoading = false;
                    alert("Sorry, you can't update a document");
                    $state.go("patient.document", {id: $state.params.id});
                } else {
                    $scope.xslt = doc_type_response.result.document_xslt;
                    var doc_id = $state.params.doc_id;
                    $scope.getDocument(doc_id, function (pat_doc_response) {
                        $scope.xml = pat_doc_response.result.document_xml;
                    });
                    $scope.isLoading = false;
                }
            });
        }

        //View Document
        $scope.viewDocument = function () {
            $scope.isLoading = true;
            $scope.getDocumentType(function (doc_type_response) {
                if (doc_type_response.success == false) {
                    $scope.isLoading = false;
                    alert("Sorry, you can't view a document");
                    $state.go("patient.document", {id: $state.params.id});
                } else {
                    $scope.xslt = doc_type_response.result.document_out_xslt;
                    var doc_id = $state.params.doc_id;
                    $scope.getDocument(doc_id, function (pat_doc_response) {
                        $scope.xml = pat_doc_response.result.document_xml;
                    });
                    $scope.isLoading = false;
                }
            });
        }

        $scope.submitXsl = function () {
            _data = $('#xmlform').serialize() + '&' + $.param({
                'encounter_id': $scope.encounter.encounter_id,
                'patient_id': $state.params.id,
                'novalidate': false,
                'status': '1',
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
                        if (response.data.success == true) {
                            $scope.xml = response.data.xml;
                        } else {
                            $scope.errorData = response.data.message;
                            $anchorScroll();
                        }
                    }
            );
        }

        $scope.panel_bars = [];
        $scope.page_offest = '';

        $("body").on("click", ".panel-heading", function () {
            next_div = $(this).next('div');

            result = $filter('filter')($scope.panel_bars, {div: next_div.attr('id')});
            if (result.length > 0) {
                var index = $scope.panel_bars.indexOf(result[0]);
                $scope.panel_bars.splice(index, 1);
            }

            $scope.panel_bars.push({div: next_div.attr('id'), opened: !next_div.is(":visible")});
        });

        $("body").on("click", ".addMore", function () {
            var button_id = $(this).attr('id');
            var table_id = $(this).data('table-id');
            var rowCount = $('#' + table_id + ' tbody  tr').length;

            $scope.page_offest = $(this).offset();

            _data = $('#xmlform').serialize() + '&' + $.param({
                'encounter_id': $scope.encounter.encounter_id,
                'patient_id': $state.params.id,
                'button_id': button_id,
                'table_id': table_id,
                'rowCount': rowCount,
                'novalidate': true,
            });

            $http({
                url: $rootScope.IRISOrgServiceUrl + "/patientdocuments/savedocument",
                method: "POST",
                transformRequest: transformRequestAsFormPost,
                data: _data,
            }).then(
                    function (response) {
                        $scope.loadbar('hide');
                        if (response.data.success == true) {
                            $scope.xml = response.data.xml;

                            $timeout(function () {
                                angular.forEach($scope.panel_bars, function (bar) {
                                    if (bar.opened) {
                                        $('#' + bar.div).toggleClass('collapse in').attr('aria-expanded', true).removeAttr("style");
                                    } else {
                                        $('#' + bar.div).toggleClass('collapse').attr('aria-expanded', false);
                                    }
                                });
                                $('html').scrollTop($scope.page_offest.top);
                            }, 500);
                        } else {
                            $scope.errorData = response.data.message;
                            $anchorScroll();
                        }
                    }
            );
        });

        //Delete
        $scope.deleteDocument = function (doc_id) {
            var conf = confirm('Are you sure to delete ?');
            if (conf) {
                $scope.loadbar('show');
                $http({
                    url: $rootScope.IRISOrgServiceUrl + "/patientdocuments/remove",
                    method: "POST",
                    data: {doc_id: doc_id}
                }).then(
                        function (response) {
                            $scope.loadbar('hide');
                            if (response.data.success === true) {
                                $scope.loadPatDocumentsList();
                                $scope.successMessage = 'Document Deleted Successfully';
                            }
                            else {
                                $scope.errorData = response.data.message;
                            }
                        }
                )
            }
        };


    }]);

// Filter HTML Code
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