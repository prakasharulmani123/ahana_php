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
        $scope.imgExport = function (imgID) {
            var img = document.getElementById(imgID);
            var canvas = document.createElement("canvas");
            canvas.width = img.width;
            canvas.height = img.height;

            // Copy the image contents to the canvas
            var ctx = canvas.getContext("2d");
            ctx.drawImage(img, 0, 0);

            // Get the data-URL formatted image
            // Firefox supports PNG and JPEG. You could check img.src to
            // guess the original format, but be aware the using "image/jpg"
            // will re-encode the image.
            var dataURL = canvas.toDataURL("image/png");
            return dataURL;
        }
        
        $scope.printContent = function () {
            var encoded_image = $('#patient-barcode img').attr('src');
            var content = [];
            content.push(
                    {
                        image: $scope.imgExport('ahana_image'),
                        width:70,
                        height:15,
                        margin: [20, 0, 0, 0],
                    },
                    {
                        fontSize: 7,
                        text: [
                            'Name: ' + $scope.data.view_data.fullname,
                            '\nUHID: ' + $scope.data.view_data.patient_global_int_code,
                            '\nGender: ' + $scope.data.app.patientDetail.patientSex,
                            '\nAge: ' + $scope.data.view_data.patient_age,
                            '\nDr Name: ' + $scope.data.view_data.consultant_name + "\n",
                        ],
                        margin: [0, 0, 0, 5],

                    },
                    {
                        image: encoded_image,
                        width: 95,
                        height: 15,

                    }
            );
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
//                    pageSize: {width: 2.95 * 72, height: 1.96 * 72}, //8cm
                    pageSize: {width: 1.25 * 72, height: 1.98 * 72}, //8cm
                    pageOrientation: 'landscape',
                    pageMargins: [10, 10, 50, 0],

                };
                var pdf_document = pdfMake.createPdf(docDefinition);
                var doc_content_length = Object.keys(pdf_document).length;
                if (doc_content_length > 0) {
                    pdf_document.print();
                }
            }
        }
    }]);
