app.controller('DocumentsController', ['$rootScope', '$scope', '$timeout', '$http', '$state', 'transformRequestAsFormPost', '$anchorScroll', '$filter', '$interval', function ($rootScope, $scope, $timeout, $http, $state, transformRequestAsFormPost, $anchorScroll, $filter, $interval) {

        $scope.app.settings.patientTopBar = true;
        $scope.app.settings.patientSideMenu = true;
        $scope.app.settings.patientContentClass = 'app-content patient_content ';
        $scope.app.settings.patientFooterClass = 'app-footer';
        $scope.xml = '';
        $scope.xslt = '';
        $scope.data = {};
        $scope.encounter = {};

        $scope.open = function ($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };



        //Documents Index Page
        $scope.loadPatDocumentsList = function (date) {

//            Disable Back button
//            $scope.$on('$locationChangeStart', function (event, next, current) {
//                // Here you can take the control and call your own functions:
//                //alert('Sorry ! Back Button is disabled');
//                // Prevent the browser default action (Going back):
//                event.preventDefault();
//            });
            var filterDate = '';
            if (date)
                filterDate = moment(date).format('YYYY-MM-DD');
            $scope.documents = [];
            $scope.documents.push({label: 'Case History', value: 'CH'}, {label: 'Scanned Documents', value: 'SD'}, {label: 'Other Documents', value: 'OD'});

            $scope.isLoading = true;
            $scope.rowCollection = [];
            $scope.encounters_list = [];

            $scope.$watch('patientObj.patient_id', function (newValue, oldValue) {
                if (newValue != '') {
                    $rootScope.commonService.GetEncounterListByPatient('', '0,1', false, $scope.patientObj.patient_id, function (response) {
                        angular.forEach(response, function (resp) {
                            resp.encounter_id = resp.encounter_id.toString();
                        });
                        $scope.encounters_list = response;
                    }, 'sale_encounter_id');
                }
            }, true);

            $http.get($rootScope.IRISOrgServiceUrl + '/patientdocuments/getpatientdocuments?patient_id=' + $state.params.id + '&date=' + filterDate)
                    .success(function (documents) {
                        $scope.isLoading = false;
                        $scope.rowCollection = documents.result;
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patient documents!";
                    });
        };

        //Create Document
        $scope.switchAddDocument = function () {
            if ($scope.add_document) {
                if ($scope.add_document == 'CH') {
                    localStorage.setItem("add_case_document", "1");
                    $state.go('patient.addDocument', {id: $state.params.id, enc_id: $scope.add_doc_encounter_id});
                } else if ($scope.add_document == 'SD') {
                    $state.go('patient.addScannedDocument', {id: $state.params.id, enc_id: $scope.add_doc_encounter_id});
                } else if ($scope.add_document == 'OD') {
                    $state.go('patient.addOtherDocument', {id: $state.params.id, enc_id: $scope.add_doc_encounter_id});
                }
            }
        }

        //Delete
        $scope.deleteDocument = function (doc_id, doc_type) {
            if (doc_type == 'CH') {
                URL = $rootScope.IRISOrgServiceUrl + "/patientdocuments/remove";
            } else if (doc_type == 'OD') {
                URL = $rootScope.IRISOrgServiceUrl + "/patientotherdocuments/remove";
            } else if (doc_type == 'SD') {
                URL = $rootScope.IRISOrgServiceUrl + "/patientscanneddocuments/remove";
            }
            var conf = confirm('Are you sure to delete ?');
            if (conf) {
                $scope.loadbar('show');
                $http({
                    url: URL,
                    method: "POST",
                    data: {doc_id: doc_id}
                }).then(
                        function (response) {
                            $scope.loadbar('hide');
                            if (response.data.success === true) {
                                $scope.msg.successMessage = 'Document Deleted Successfully';
                                $scope.loadPatDocumentsList();
                            } else {
                                $scope.errorData = response.data.message;
                            }
                        }
                )
            }
        };

        //Download
        $scope.displayspin = '';
        $scope.downloadDocument = function (scanned_doc_id) {
            $scope.displayspin = scanned_doc_id;
            $http.get($rootScope.IRISOrgServiceUrl + "/patientscanneddocuments/getscanneddocument?id=" + scanned_doc_id)
                    .success(function (response) {
                        $scope.displayspin = '';
                        if (response.success === true) {
                            var link = document.createElement('a');
                            link.href = 'data:' + response.result.file_type + ';base64,' + response.file;
                            link.download = response.result.file_org_name;
                            document.body.appendChild(link);
                            link.click();
                            $timeout(function () {
                                document.body.removeChild(link);
                            }, 1000);
                        } else {
                            $scope.errorData = response.message;
                        }
                    }).
                    error(function (data, status) {
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

        $scope.diagnosisDsmiv = function () {
            //Diagnosis
            $rootScope.commonService.GetDiagnosisList(function (response) {
                var availableTags = [];
                angular.forEach(response.diagnosisList, function (diagnosis) {
                    availableTags.push(diagnosis.label);
                });
                $("#txtDiagnosis").autocomplete({
                    source: availableTags,
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

            $("#date_of_last_ect").datepicker({
                changeMonth: true,
                changeYear: true,
                showButtonPanel: true,
                dateFormat: 'MM yy',
                onClose: function (dateText, inst) {
                    var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                    var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                    $(this).datepicker('setDate', new Date(year, month, 1));
                }
            });
        }

// Initialize Create Form
        $scope.initForm = function () {
            $scope.isLoading = true;

            var checking = localStorage.getItem("add_case_document");
//            $scope.isPatientHaveActiveEncounter(function (response) {
//                if (response.success == false) {
//                    $scope.isLoading = false;
//                    alert("Sorry, you can't create a document");
//                    $state.go("patient.document", {id: $state.params.id});
//                } else {
//                    $scope.encounter = response.model;
            $scope.encounter = {encounter_id: $state.params.enc_id};
            if (checking == 1) {
                $scope.getDocumentType(function (doc_type_response) {
                    if (doc_type_response.success == false) {
                        alert("Sorry, you can't create a document");
                        $state.go("patient.document", {id: $state.params.id});
                    } else {
                        $scope.xslt = doc_type_response.result.document_xslt;
                        $scope.$watch('patientObj', function (newValue, oldValue) {
                            if (Object.keys(newValue).length > 0) {
                                $scope.initSaveDocument(function (auto_save_document) {
                                    $scope.xml = auto_save_document.data.xml;
                                    $scope.isLoading = false;
                                    $scope.doc_id = auto_save_document.data.doc_id; // Set Document id

                                    $timeout(function () {
                                        $scope.diagnosisDsmiv();
                                    }, 2000);

                                    $timeout(function () {
                                        $scope.ckeditorReplace();
                                    }, 500);
                                    $scope.startAutoSave(auto_save_document.data.doc_id);
                                });
                            }
                        }, true);
                    }
                    localStorage.setItem("add_case_document", "0");
                });
            } else {
                $state.go("patient.document", {id: $state.params.id});
            }
//                }
//            });
        }

        $scope.initSaveDocument = function (callback) {
            var _data = [];
            _data.push({
                name: 'name',
                value: $scope.patientObj.fullname,
            },
                    {
                        name: 'uhid',
                        value: $scope.patientObj.patient_global_int_code,
                    },
                    {
                        name: 'age',
                        value: $scope.patientObj.patient_age,
                    }, {
                name: 'gender',
                value: $scope.app.patientDetail.patientSex,
            }, {
                name: 'martial_status',
                value: $scope.app.patientDetail.patientMaritalStatus,
            }, {
                name: 'encounter_id',
                value: $scope.encounter.encounter_id,
            }, {
                name: 'patient_id',
                value: $state.params.id,
            }, {
                name: 'novalidate',
                value: true,
            }, {
                name: 'status',
                value: '0',
            });

            $scope.loadbar('show');
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/patientdocuments/savedocument",
                method: "POST",
//                transformRequest: transformRequestAsFormPost,
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
        $scope.startAutoSave = function (doc_id) {
            // Don't start a new fight if we are already fighting
            if (angular.isDefined(stop))
                return;
            stop = $interval(function () {
                $scope.ckeditorupdate();
                _data = $('#xmlform').serializeArray();
                _data.push({
                    name: 'encounter_id',
                    value: $scope.encounter.encounter_id,
                }, {
                    name: 'patient_id',
                    value: $state.params.id,
                }, {
                    name: 'novalidate',
                    value: true,
                },
                        {
                            name: 'doc_id',
                            value: doc_id,
                        });

                $http({
                    url: $rootScope.IRISOrgServiceUrl + "/patientdocuments/savedocument",
                    method: "POST",
//                    transformRequest: transformRequestAsFormPost,
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
                        $scope.doc_id = doc_id; // Set Document id
                        $scope.isLoading = false;
                        $timeout(function () {
                            $scope.diagnosisDsmiv();
                        }, 2000);

                        $timeout(function () {
                            $scope.ckeditorReplace();
                        }, 500);
                        $scope.startAutoSave(doc_id);
                    });
                }
            });
        }

        $scope.printDocument = function () {
            $scope.printElement();

//            $timeout(function () {
//                var innerContents = document.getElementById("printThisElement").innerHTML;
//                var popupWinindow = window.open('', '_blank', 'width=600,height=700,scrollbars=yes,menubar=no,toolbar=no,location=no,status=no,titlebar=no');
//                popupWinindow.document.open();
//                popupWinindow.document.write('<html><head><link href="css/print.css" rel="stylesheet" type="text/css" /></head><body onload="window.print()">' + innerContents + '</html>');
//                popupWinindow.document.close();
//            }, 1000)
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
                        $scope.created_by = pat_doc_response.result.created_user;
                        $scope.created_at = pat_doc_response.result.created_at;
                        $scope.modified_at = pat_doc_response.result.modified_at;
                        $scope.xml = pat_doc_response.result.document_xml;
                        $scope.isLoading = false;
                        $timeout(function () {
                            $scope.checkTablerow();
                        }, 100);
                    });
                }
            });
        }

        $scope.printCasedocument = function (list) {
            $scope.printxslt = '';
            $scope.getDocumentType(function (doc_type_response) {
                if (doc_type_response.success == false) {
                    $scope.isLoading = false;
                    alert("Sorry, you can't view a document");
                    $state.go("patient.document", {id: $state.params.id});
                } else {
                    $scope.printxslt = doc_type_response.result.document_out_print_xslt;
                    var doc_id = list;
                    $scope.getDocument(doc_id, function (pat_doc_response) {
                        $scope.created_by = pat_doc_response.result.created_user;
                        $scope.created_at = pat_doc_response.result.created_at;
                        $scope.modified_at = pat_doc_response.result.modified_at;
                        $scope.xml = pat_doc_response.result.document_xml;
                        $timeout(function () {
                            $scope.checkTablerow();
                        }, 100);
                        $scope.printElement();
                    });

                }
            });
        }

        $scope.checkTablerow = function () {
            $("#printThisElement table tr").each(function () {

                var ratingTdText = $(this).find('td.ribbon');
                var nextTr = ratingTdText.closest('tr').next('tr');

                var nextTr = ratingTdText.closest('tr').next('tr');
                if ((nextTr.text().trim() == "Possession of thought") || (nextTr.text().trim() == "Hiding text")) {
                    nextTr.remove();
                    ratingTdText.remove();
                }

                var RadgridText = $(this).find('tr.pastmedical');
                var radhtml = RadgridText.find('td > table > tbody');
                if (radhtml.text().trim().length === 0) {
                    var prevTr = RadgridText.closest('tr').prev('tr');
                    prevTr.remove();
                }
                var therapyText = $(this).find('tr.phamacotherapy');
                var therapyhtml = therapyText.find('td > table > tbody');
                if (therapyhtml.text().trim().length === 0) {
                    var prevTr = therapyText.closest('tr').prev('tr');
                    prevTr.remove();
                }
                var altText = $(this).find('tr.alternative');
                var althtml = altText.find('td > table > tbody');
                if (althtml.text().trim().length === 0) {
                    var altTr = altText.closest('tr').prev('tr');
                    altTr.remove();
                }
                var subText = $(this).find('tr.sub');
                var subhtml = subText.find('td > table > tbody');
                if (subhtml.text().trim().length === 0) {
                    var subTr = subText.closest('tr').prev('tr');
                    subTr.remove();
                }
                var personalText = $(this).find('tr.personal_history');
                if (personalText.text().trim().length === 0) {
                    //console.log(personalText);
                    var personalTr = personalText.closest('tr').prev('tr');
                    personalTr.remove();
                }
                var statusText = $(this).find('tr.mental_status');
                if (statusText.text().trim().length === 0) {
                    var statusTr = statusText.closest('tr').prev('tr');
                    statusTr.remove();
                }

            });

            $(".classy-edit").each(function () {
                $(this).removeClass("form-control");
                $(this).html($(this).text());
            });

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

                //Remove empty sub box
                var textbox_span = $(this).find("tr td");
                $.each(textbox_span, function () {
                    $this = $(this).find("span#sub_textbox")
                    if ($this.text().trim().length === 0) {
                        $this.parents("span").remove();
                        //$this.parents("div").remove();
                    }
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

                var complaints = $("td#complaints");
                if (complaints.text().length === 0)
                {
                    complaints.remove();
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
                $("#printThisElement table tbody tr td table tbody").each(function () {
                    var head = $(this).find("tr");
                    var heading = head.text();
                    var success = heading.replace('Hiding text', '');
                    if (success.trim().length === 0) {
                        head.remove();
                    }
                });

                var ratingTdText = $(this).find('td.ribbon');
                var nextTr = ratingTdText.closest('tr').next('tr');
                nextTr.find('td').each(function () {
                    if (nextTr.text().trim() == "") {
                        nextTr.remove();
                        ratingTdText.remove();
                    }
                });

                var headingText = $(this).find('td.ribbonhead');
                var headingnextTr = headingText.closest('tr').next('tr');
                headingnextTr.find('td').each(function () {
                    if (headingnextTr.text().trim() == "") {
                        headingnextTr.remove();
                        headingText.remove();
                    }
                });

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

                //Remove empty sub box

                $this = $(this).find("span#sub_textbox")
                if ($this.text().trim().length === 0) {
                    $this.parents("span").remove();
                }

            });

            $('table#heading').each(function () {
                //console.log($(this).find("tbody").text());
                if ($(this).find("tbody").text().trim().length === 0) {
                    $(this).remove();
                }
            });
        }

        $scope.printElement = function () {
            var created_by = $scope.created_by;
            var date = new Date($scope.modified_at);
            var month = date.getMonth() + 1;
            var day = date.getDate();
            var output = (('' + day).length < 2 ? '0' : '') + day + '/' +
                    (('' + month).length < 2 ? '0' : '') + month + '/' +
                    date.getFullYear();

            var create_date = new Date($scope.created_at);
            var create_month = create_date.getMonth() + 1;
            var create_day = create_date.getDate();
            var create_output = (('' + create_day).length < 2 ? '0' : '') + create_day + '/' +
                    (('' + create_month).length < 2 ? '0' : '') + create_month + '/' +
                    create_date.getFullYear();

            var hours = date.getHours() > 12 ? date.getHours() - 12 : date.getHours();
            var am_pm = date.getHours() >= 12 ? "PM" : "AM";
            hours = hours < 10 ? "0" + hours : hours;
            var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
            //var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
            time = hours + ":" + minutes + am_pm;

            $timeout(function () {
                $('#created_name').html(created_by);
                $('#created_date').html(create_output);
                $('#date_name').html(output);
                $('#time').html(time);
            }, 100);


            $('#printThisElement').printThis({
                pageTitle: "",
                debug: false,
                importCSS: false,
                importStyle: false,
                loadCSS: [$rootScope.IRISOrgUrl + "/css/print.css"],
            });
        }

        $scope.submitXsl = function (doc_id) {
            $scope.ckeditorupdate();

            _data = $('#xmlform').serializeArray();
            _data.push({
                name: 'encounter_id',
                value: $scope.encounter.encounter_id,
            }, {
                name: 'patient_id',
                value: $state.params.id,
            }, {
                name: 'novalidate',
                value: false,
            }, {
                name: 'status',
                value: '1',
            }, {
                name: 'doc_id',
                value: doc_id,
            });

            if ($scope.panel_bars.length > 0) {
                angular.forEach($scope.panel_bars, function (panel_bars) {
                    _data.push({
                        name: panel_bars.div,
                        value: panel_bars.opened,
                    });
                });
            }

            $scope.loadbar('show');
            $http({
                url: $rootScope.IRISOrgServiceUrl + "/patientdocuments/savedocument",
                method: "POST",
//                transformRequest: transformRequestAsFormPost,
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
        };

        $scope.ckeditorupdate = function () {
            for (instance in CKEDITOR.instances)
                CKEDITOR.instances[instance].updateElement();
        };

        $scope.ckeditorReplace = function () {
            CKEDITOR.replaceAll('classy-edit');
            CKEDITOR.config.disableNativeSpellChecker = true,
                    CKEDITOR.config.scayt_autoStartup = true
            CKEDITOR.config.toolbar = [
                ['Styles', 'Format', 'Font', 'FontSize', 'spellchecker'],

                ['Bold', 'Italic', 'Underline', 'StrikeThrough', '-', 'Undo', 'Redo', '-', 'Cut', 'Copy', 'Paste', 'Find', 'Replace', '-', 'Outdent', 'Indent', '-', 'Print'],

                ['NumberedList', 'BulletedList', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
                ['-', 'Link', 'Flash', 'Smiley', 'TextColor', 'BGColor', 'Source', '-', 'SpellChecker', 'Scayt']
            ];
            CKEDITOR.config.toolbarGroups = [

                {name: 'editing', groups: ['find', 'selection', 'spellchecker']},
            ];
        };

        $scope.printOtherdocument = function (list) {
            $http.get($rootScope.IRISOrgServiceUrl + '/patientotherdocuments/' + list)
                    .success(function (other_document) {
                        $scope.other_document = other_document;
                        //$timeout(function () {
                        $('#printThis').printThis({
                            pageTitle: "Ahana",
                            debug: false,
                            importCSS: false,
                            importStyle: false,
                            loadCSS: [$rootScope.IRISOrgUrl + "/css/print.css"],
                        });
                        //}, 100);
                    })
                    .error(function () {
                        $scope.errorData = "An Error has occured while loading patient other documents!";
                    });
        };

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
            $("div#" + clear_div_id).find(':input').each(function () {
                switch (this.type) {
                    case 'text':
                        this.value = "";
                        break;
                    case 'textarea':
                        this.value = "";
                        break;
                    case 'checkbox':
                        this.checked = false;
                        break;
                    case 'radio':
                        this.checked = false;
                        break;
                    case 'select-one':
                        $(this).val($(this).find("option:first").val());
                        break;
                }
            });
        });

        $("body").on("click", ".addMore", function () {
            if (!jQuery.isEmptyObject($scope.encounter)) {
                $scope.spinnerbar('show');
                var button_id = $(this).attr('id');
                var table_id = $(this).data('table-id');
                var rowCount = $('#' + table_id + ' tbody  tr').length;
                var firstMsg = $('#' + table_id).find("tr:last");
                var curOffset = firstMsg.offset().top - $(document).scrollTop();

                $scope.ckeditorupdate();
                _data = $('#xmlform').serializeArray();
                _data.push({
                    name: 'encounter_id',
                    value: $scope.encounter.encounter_id,
                }, {
                    name: 'patient_id',
                    value: $state.params.id,
                }, {
                    name: 'button_id',
                    value: button_id,
                }, {
                    name: 'table_id',
                    value: table_id,
                }, {
                    name: 'rowCount',
                    value: rowCount,
                }, {
                    name: 'novalidate',
                    value: true,
                }, {
                    name: 'doc_id',
                    value: $scope.doc_id,
                });

                $http({
                    url: $rootScope.IRISOrgServiceUrl + "/patientdocuments/savedocument",
                    method: "POST",
//                transformRequest: transformRequestAsFormPost,
                    data: _data,
                }).then(
                        function (response) {
                            $scope.loadbar('hide');
                            if (response.data.success == true) {
                                $scope.xml = response.data.xml;
                                $timeout(function () {
                                    $scope.diagnosisDsmiv();
                                }, 2000);
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
                                    $scope.ckeditorReplace();
                                }, 500);
                            } else {
                                $scope.spinnerbar('hide');
                                $scope.errorData = response.data.message;
                                $anchorScroll();
                            }
                        }
                );
            }

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