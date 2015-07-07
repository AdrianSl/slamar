function edit(id) {
  $('#' + id + '_driver_disabled').prop('disabled', false);
  $('#' + id + '_value_disabled').prop('disabled', false);
  $('#' + id + '_midday_value_disabled').prop('disabled', false);
  $('#' + id + '_link_disabled').hide();
}

$(':input[id=income_income_source_type_truckroute]').change(function() {
   $("#brand_shops_option").removeClass("none");
   $("#external_shops_option").removeClass("none");
   $("#truck_routes_option").addClass("none");
});
$(':input[id=income_income_source_type_brandshop]').change(function() {
   $("#brand_shops_option").addClass("none");
   $("#external_shops_option").removeClass("none");
   $("#truck_routes_option").removeClass("none");
});
$(':input[id=income_income_source_type_externalshop]').change(function() {
   $("#brand_shops_option").removeClass("none");
   $("#external_shops_option").addClass("none");
   $("#truck_routes_option").removeClass("none");
});
