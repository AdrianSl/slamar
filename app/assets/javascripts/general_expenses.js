var autocomplete_data_static = {};

function autocomplete_query(obj){
    obj.typeahead({
        source: function (q, process) {
            obj = this.$element;
            rows = [];

            var name = obj.attr('name');
            //autocomplete_data_static[name] = {"map":[], "values": []};

            // load data from remote server
            $.getJSON( obj.attr('data-source-query'), {q: q},
                function( data ) {
                    autocomplete_data_static[name] = {"map":[], "values": []};

                    $.each(data, function (i, row) {
                        autocomplete_data_static[name]["values"].push(row[1]);
                        autocomplete_data_static[name]["map"][row[1]]=row[0];
                    });
                    process(autocomplete_data_static[name]["values"]);
                }
            );// get json
        }//source
        , updater: function (item) {


            return item;
        }
        , items: obj.attr('data-items')
        , minLength: obj.attr('data-min-length')
        , afterSelect: function(item){
            var name = obj.attr('data-afterSelect') || '';
            if (name!='') {
                var fn = window[name];
                if (typeof(fn) == "function")
                    fn(item);
            }

        }
    }).on('change', function (e) {
        var obj = $(this);

        var current = obj.typeahead("getActive");

        // hidden field for id

    });// typeahead
}

$(document).ready(function() {

    // query data from server
    $('input[data-provide="typeahead"][data-source-query]').each(function() {
        autocomplete_query($(this));

    });// each

});
