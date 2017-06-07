app.controller('PatientLabelController', ['scope', '$scope', function (scope, $scope) {
        $scope.data = scope;

        /*PRINT*/
        $scope.printHeader = function () {
//            return true;
        }

        $scope.printFooter = function () {
//            return true; 
        }

        $scope.printStyle = function () {
            return true;
        }

        $scope.printContent = function () {
            var encoded_image = $('#patient-barcode img').attr('src');
            var content = [];
            content.push({
                columns: [
                    {
                        fontSize: 5,
                        text: [
                            'Name:' + $scope.data.view_data.fullname,
                            '\nUHID:' + $scope.data.view_data.patient_global_int_code,
                            '\nGender:' + $scope.data.app.patientDetail.patientSex,
                            '\nAge:' + $scope.data.view_data.patient_age,
                        ],
                    },
                    {
                        image: encoded_image,
                        width: 80,
                        height: 35
                    }
                ]
            });
            return content;
        }

        $scope.print = function () {
            var print_content = $scope.printContent();
            if (print_content.length > 0) {
                var docDefinition = {
                    header: $scope.printHeader(),
                    footer: $scope.printFooter(),
                    styles: $scope.printStyle(),
                    content: print_content,
                    pageSize: {width: 3 * 72, height: 3 * 72}, //8cm
                    pageOrientation: 'A4',
                };
                var pdf_document = pdfMake.createPdf(docDefinition);
                var doc_content_length = Object.keys(pdf_document).length;
                if (doc_content_length > 0) {
                    pdf_document.print();
                }
            }
        }
    }]);
