$(document).ready(function(){
    $("#ss-submit").addClass("btn btn-info");
    $(".ss-required-asterisk").text("");
    $(".required-message").text("");
    $(".error-message").text("");
    $("#ss-submit").parent("td").children("div").text("");
    $("#ss-form").children("table").addClass("table-striped");
    $(".ss-section-title").closest("div").prepend("<hr />");
    $("textarea").addClass("input-block-level");
})