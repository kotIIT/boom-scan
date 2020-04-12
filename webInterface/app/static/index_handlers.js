//check if js working
console.log('pizza pasta put it in a box');

$(document).ready(function () {

    console.log('cheesie');

    var deviceTable = new Tabulator("#device-table", {
        height: "311px",
        width:'600px',
        columns: [
            {title: "IP", field: "IP"},
            {title: "MAC ADDRESS", field: "MAC ADDRESS"},
            {title: "Manufacturer", field: "MANUFACTURER"},
        ],
    });

    $('a#shodanOpen').on('click', function () {


        $.get('/api/get_public_ip', function (data) {

            window.open('https://shodan.io/search?query=' + data);
            console.log(data);
        });

    });

    $('a#test').on('click', function () {

        // disable button ('disabled attr')

        $.get('/api/script_scan_list',
            function (data) {
                window.alert(data);
                console.log(data);

            });

        //enable button ('enabled attr')

        return false;



    });

    $('a#devices').on('click', function () {
        $.get('/api/get_device_list',
            function (data) {
                console.log(data);

                for (var i in data.IP) {
                    console.log(i);
                    datum = {
                        'IP': data.IP[i],
                        'MANUFACTURER': data['MANUFACTURER'][i],
                        'MAC ADDRESS': data['MAC ADDRESS'][i]
                    };
                    console.log(datum);

                    deviceTable.addData([datum])
                }

            });
        return false;
    });

    $('a#fast').on('click', function () {

        // disable button ('disabled attr')

        $.get('/api/fast_scan_list',
            function (data) {
                window.alert(data);
                console.log(data);

            });

        //enable button ('enabled attr')


    });

    $('a#make').on('click', function () {
        $.get('/api/make_device_list',
            function (data) {
                window.alert(data);
                console.log(data);
            });
        return false;
    });


});