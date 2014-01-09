$(document).ready(function(){
    $("#ss-submit").addClass("btn btn-info");
    $(".ss-required-asterisk").text("");
    $(".required-message").text("");
    $("#ss-submit").parent("td").children("div").text("");
    $("#ss-form").children("table").addClass("table-striped");
})