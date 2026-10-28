var generateReportingViewer = function ($scope, $http, app, url_api, groupbyColumn = -1, retryCount = 0) {
    $scope.loading = true;
    app.canSubmit(false);

    const maxRetries = 5; // Maximum number of retry attempts

    // Define a function for making the request with retry logic
    const makeRequest = function () {
        try {
            $http({
                method: 'GET',
                url: url_api,
                headers: { 'Content-Type': 'application/json; charset=utf-8' }
            }).then(function (response) {
                $scope.loading = false;
                app.canSubmit(true);
                var json = response.data;
                var columns = [];

                if (json == null || json.length <= 0) {
                    $scope.ready = false;
                    toastr.warning(JSR.empty_data);
                    return;
                }

                $scope.ready = true;
                $scope.collapse_footer = true;
                columnNames = Object.keys(json[0]);
                for (var i in columnNames) {
                    var cl = translateText(columnNames[i]);
                    columns.push({
                        data: columnNames[i],
                        title: cl
                    });
                }

                window.createReportDataTable('#table-reporting-global', json, columns, groupbyColumn);

            }, function (response) {
                // Error handling and retry logic
                if (retryCount < maxRetries) {
                    retryCount++;
                    console.log(`Retry attempt ${retryCount}`);
                    // Retry the request
                    setTimeout(makeRequest(), 2000);
                } else {
                    $scope.loading = false;
                    app.canSubmit(true);
                    console.log('Max retries reached');
                    app.responseStatus(response);
                }
            });

        } catch (e) {
            $scope.loading = false;
            console.log('Error', e);
            $scope.$applyAsync();
        }
    };

    // Initial request call
    makeRequest();
}
