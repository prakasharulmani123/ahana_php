app.controller('DocumentsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'transformRequestAsFormPost', '$anchorScroll', '$filter', '$interval', function ($rootScope, $scope, $timeout, $http, $state, transformRequestAsFormPost, $anchorScroll, $filter, $interval) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';
        $scope.xml = '';
        $scope.xslt = '';
        $scope.data = {};
        $scope.encounter = {};
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

// Initialize Create Form
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
                            $scope.initSaveDocument(function (auto_save_document) {
                                $scope.xml = auto_save_document.data.xml;
                                $scope.isLoading = false;

                                $timeout(function () {
                                    //Diagnosis
                                    $rootScope.commonService.GetDiagnosisList(function (response) {
                                        var availableTags = [];
                                        angular.forEach(response.diagnosisList, function (diagnosis) {
                                            availableTags.push(diagnosis.label);
                                        });
                                        $("#txtDiagnosis").autocomplete({
                                            source: availableTags,
//                                            minLength: 2,
                                        });
                                    });

                                    //Axis1
                                    $rootScope.commonService.GetDsmivList("1", function (response) {
                                        var axis1 = [];
                                        angular.forEach(response.dsmivList, function (dsmiv) {
                                            axis1.push(dsmiv.label);
                                        });
                                        $("#txtAxis1").autocomplete({
                                            source: axis1,
                                        });
                                    });

                                    //Axis2
                                    $rootScope.commonService.GetDsmivList("2", function (response) {
                                        var axis2 = [];
                                        angular.forEach(response.dsmivList, function (dsmiv) {
                                            axis2.push(dsmiv.label);
                                        });
                                        $("#txtAxis2").autocomplete({
                                            source: axis2,
                                        });
                                    });
                                }, 2000);

                                $scope.startAutoSave();
                            });
                        }
                    });
                }
            });
        }

        $scope.initSaveDocument = function (callback) {
            _data = $.param({
                'name': $scope.patientObj.fullname,
                'age': $scope.patientObj.patient_age,
                'gender': $scope.app.patientDetail.patientSex,
                'martial_status': $scope.app.patientDetail.patientMaritalStatus,
                'encounter_id': $scope.encounter.encounter_id,
                'patient_id': $state.params.id,
                'novalidate': true,
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
                            callback(response);
                        }
                    }
            );
        };
        var stop;
        $scope.startAutoSave = function () {
            // Don't start a new fight if we are already fighting
            if (angular.isDefined(stop))
                return;
            stop = $interval(function () {
                _data = $('#xmlform').serialize() + '&' + $.param({
                    'encounter_id': $scope.encounter.encounter_id,
                    'patient_id': $state.params.id,
                    'novalidate': true
                });
                $http({
                    url: $rootScope.IRISOrgServiceUrl + "/patientdocuments/savedocument",
                    method: "POST",
                    transformRequest: transformRequestAsFormPost,
                    data: _data
                });
            }, 60000);
        };
        $scope.stopAutoSave = function () {
            if (angular.isDefined(stop)) {
                $interval.cancel(stop);
                stop = undefined;
            }
        };
        $scope.$on('$destroy', function () {
            // Make sure that the interval is destroyed too
            $scope.stopAutoSave();
        });
        // Initialize Update Form
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
                        $scope.encounter = {encounter_id: pat_doc_response.result.encounter_id};
                        $scope.isLoading = false;
                        $scope.startAutoSave();
                    });
                }
            });
        }

        $scope.printDocument = function () {
            $timeout(function () {
                var innerContents = document.getElementById("printThisElement").innerHTML;
                var popupWinindow = window.open('', '_blank', 'width=600,height=700,scrollbars=yes,menubar=no,toolbar=no,location=no,status=no,titlebar=no');
                popupWinindow.document.open();
                popupWinindow.document.write('<html><head><link href="css/print.css" rel="stylesheet" type="text/css" /></head><body onload="window.print()">' + innerContents + '</html>');
                popupWinindow.document.close();
            }, 1000)
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
                    $scope.printxslt = doc_type_response.result.document_out_print_xslt;
                    var doc_id = $state.params.doc_id;
                    $scope.getDocument(doc_id, function (pat_doc_response) {
                        $scope.created_at = pat_doc_response.result.created_at;
                        $scope.xml = pat_doc_response.result.document_xml;
                        $scope.isLoading = false;
                        $timeout(function () {
                            $("#printThisElement table").each(function () {
                                //RadGrid
                                var RadGrid_tr = $(this).find("tr.RadGrid");
                                $.each(RadGrid_tr, function (n, e)
                                {
                                    $this = $(this);
                                    var RadGrid_tr_attr = $this.data("radgrid");
                                    $('table#' + RadGrid_tr_attr + ' tbody tr').each(function () {
                                        if ($('td:not(:empty)', this).length == 0)
                                            $(this).remove();
                                    });
                                    $('table#' + RadGrid_tr_attr).each(function () {
                                        if ($(this).find("tbody").html().trim().length === 0) {
                                            $this.remove();
                                        }
                                    });
                                });
                                //Header2
                                var header2_tr = $(this).find("tr.header2");
                                $.each(header2_tr, function (n, e)
                                {
                                    var header2_tr_attr = $(this).data("header2");
                                    var header2_has_tr = $("tr").hasClass(header2_tr_attr);
                                    if (!header2_has_tr) {
                                        $(this).remove();
                                    }
                                });
                                var tr = $(this).find("tr");
                                $.each(tr, function () {
                                    $this = $(this);
                                    if ($(this).find("td").length > 0) {
                                        if ($(this).find("td").text().trim().length === 0) {
                                            $this.remove();
                                        }
                                    }

                                });
                                var rowCount = $(this).find("tr").length;
                                if (rowCount < 2) {
                                    $(this).remove();
                                }

                            });
                            $("#printThisElement table").each(function () {
                                var PanelBar_tr = $(this).find("table tr.PanelBar");
                                if (PanelBar_tr.length > 0) {
                                    $.each(PanelBar_tr, function () {
                                        $this = $(this);
                                        if ($(this).find("td").length > 0) {
                                            if ($(this).find("td").text().trim().length === 0) {
                                                $this.remove();
                                            }
                                        }
                                    });
                                }

                                var rowCount = $(this).find("tr").length;
                                if (rowCount < 2) {
                                    $(this).remove();
                                }
                            });
                            $(".document-content .panel-default").each(function () {
                                //RadGrid
                                var RadGrid_div = $(this).find(".panel-body .RadGrid");
                                $.each(RadGrid_div, function (n, e)
                                {
                                    $this = $(this);
                                    var RadGrid_div_attr = $this.data("radgrid");
                                    $('table#' + RadGrid_div_attr + ' tbody tr').each(function () {
                                        if ($('td:not(:empty)', this).length == 0)
                                            $(this).remove();
                                    });
                                    $('table#' + RadGrid_div_attr).each(function () {
                                        if ($(this).find("tbody").html().trim().length === 0) {
                                            $this.remove();
                                        }
                                    });
                                });
                                //Header2
                                var header2_div = $(this).find(".panel-body .header2");
                                $.each(header2_div, function (n, e)
                                {
                                    var header2_div_attr = $(this).data("header2");
                                    var header2_has_div = $("div").hasClass(header2_div_attr);
                                    if (!header2_has_div) {
                                        $(this).remove();
                                    }
                                });
                                //Panel Body
                                var form_group = $(this).find(".panel-body .form-group");
                                if (form_group.length == 0) {
                                    $(this).remove();
                                }
                            });
                        }, 100);
                    });
                }
            });
        }

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
                                $scope.msg.successMessage = 'Document Deleted Successfully';
                            }
                            else {
                                $scope.errorData = response.data.message;
                            }
                        }
                )
            }
        };
        $scope.submitXsl = function () {
            _data = $('#xmlform').serialize() + '&' + $.param({
                'encounter_id': $scope.encounter.encounter_id,
                'patient_id': $state.params.id,
                'novalidate': false,
                'status': '1',
            });
            if ($scope.panel_bars.length > 0) {
                var more_datas = {};
                angular.forEach($scope.panel_bars, function (panel_bars) {
                    more_datas[panel_bars.div] = panel_bars.opened;
                });
                _data = _data + '&' + $.param(more_datas);
            }

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
                            $scope.msg.successMessage = 'Document Saved Successfully';
                            $state.go('patient.document', {id: $state.params.id});
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

            var is_opened = !next_div.is(":visible");
            $scope.panel_bars.push({div: next_div.attr('id'), opened: is_opened});

            var checkbox_tag = $(this).find('input[type=checkbox]');
            var i_tag = $(this).find('i');

            if (is_opened) {
                checkbox_tag.prop("checked", true);
                $(i_tag).removeClass("fa-angle-right").addClass("fa-angle-down");
            } else {
                checkbox_tag.prop("checked", false);
                $(i_tag).removeClass("fa-angle-down").addClass("fa-angle-right");
            }
        });

        $("body").on("click", ".panelbar_clear", function () {
            var clear_div_id = $(this).data("divid");
            $("#" + clear_div_id).find(':input').each(function () {
                switch (this.type) {
                    case 'text':
                        this.value = "";
                    case 'textarea':
                        this.value = "";
                    case 'checkbox':
                        this.checked = false;
                    case 'radio':
                        this.checked = false;
                    case 'select-one':
                        $(this).val($(this).find("option:first").val());
                }
            });
        });

        $("body").on("click", ".addMore", function () {
            $scope.spinnerbar('show');
            var button_id = $(this).attr('id');
            var table_id = $(this).data('table-id');
            var rowCount = $('#' + table_id + ' tbody  tr').length;
            var firstMsg = $('#' + table_id).find("tr:last");
            var curOffset = firstMsg.offset().top - $(document).scrollTop();
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
                                        $('#' + bar.div)
                                                .siblings('.panel-heading')
                                                .find('i')
                                                .removeClass("fa-angle-right")
                                                .addClass("fa-angle-down");
                                        $('#' + bar.div)
                                                .toggleClass('collapse in')
                                                .attr('aria-expanded', true)
                                                .removeAttr("style");
                                    } else {
                                        $('#' + bar.div)
                                                .toggleClass('collapse')
                                                .attr('aria-expanded', false);
                                    }
                                });
                                var firstMsg = $('#' + table_id).find("tr:last");
                                $(document).scrollTop(firstMsg.offset().top - curOffset);
                                $scope.spinnerbar('hide');
                            }, 500);
                        } else {
                            $scope.spinnerbar('hide');
                            $scope.errorData = response.data.message;
                            $anchorScroll();
                        }
                    }
            );
        });
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