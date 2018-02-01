// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require underscore
//= require gmaps/google
//= require_tree .


$(document).ready(function() {
    console.log("Jquery Ready!");

  // Checking and crossing out completed shopping items
  $(".check-form").submit('turbolinks:load',function(e){
    e.preventDefault();
    console.log("prevented default")

    $check_btn = $('#check-button');
    $check_text = $('#unchecked-shopping-item');
    $check = $(event.target);

    $.ajax({
      url: $check.attr('action'),
      method: $check.attr('method'),
      data: $check.serialize(),
      dataType: "JSON",
      success: function(response) {
        console.log("success");
        $check_btn.removeClass("glyphicon-unchecked");
        $check_btn.addClass("glyphicon-check");
        $check_text.addClass("strike-text");
        }
      });
    });

  // unchecking misakenly crossed out shopping items
  $(".uncheck-form").submit('turbolinks:load',function(e){
    e.preventDefault();
    console.log("prevented default")

    $uncheck_btn = $('#uncheck-button');
    $uncheck_text = $('#checked-shopping-item');
    $check = $(event.target);

    $.ajax({
      url: $check.attr('action'),
      method: $check.attr('method'),
      data: $check.serialize(),
      dataType: "JSON",
      success: function(response) {
        console.log("success");
        $uncheck_btn.removeClass("glyphicon-check");
        $uncheck_btn.addClass("glyphicon-unchecked");
        $uncheck_text.removeClass("strike-text");
        }
      });
    });

  // $(".upvote-form").submit(function(e){
  //   e.preventDefault();
  //
  //   console.log("prevented default action");
  //
  //   $form = $(event.target);
  //     $.ajax({
  //       url: $form.attr('action'),
  //       method: $form.attr('method'),
  //       data: $form.serialize(),
  //       dataType: "JSON",
  //       success: function() {
  //         $("#upvote-button").addClass("green-color");
  //         // $("#sum_of_count").html(response.vote);
  //
  //         // console.log(response);
  //         // console.log(response.vote_counts);
  //       }
  //     });
  //   });

  // $(".downvote-form").submit(function(e){
  //   e.preventDefault();
  //
  //   console.log("prevented default action");
  //
  //   $form = $(event.target);
  //     $.ajax({
  //       url: $form.attr('action'),
  //       method: $form.attr('method'),
  //       data: $form.serialize(),
  //       dataType: "JSON",
  //       success: function() {
  //
  //         $("#downvote-button").addClass("red-color");
  //         // $("#sum_of_count").html(response.vote);
  //
  //         // console.log(response);
  //         // console.log(response.vote_counts);
  //       }
  //     });
  // });
  // $(".upvote-form2").submit(function(e){
  //   e.preventDefault();
  //
  //   console.log("prevented default action");
  //
  //   $form = $(event.target);
  //     $.ajax({
  //       url: $form.attr('action'),
  //       method: $form.attr('method'),
  //       data: $form.serialize(),
  //       dataType: "JSON",
  //       success: function() {
  //
  //         $("#upvote-button2").removeClass("green-color");
  //         // $("#sum_of_count").html(response.vote);
  //
  //         // console.log(response);
  //         // console.log(response.vote_counts);
  //       }
  //     });
  // });
  //
  // $(".downvote-form2").submit(function(e){
  //   e.preventDefault();
  //
  //   console.log("prevented default action");
  //
  //   $form = $(event.target);
  //     $.ajax({
  //       url: $form.attr('action'),
  //       method: $form.attr('method'),
  //       data: $form.serialize(),
  //       dataType: "JSON",
  //       success: function() {
  //
  //         $("#downvote-button2").removeClass("red-color");
  //         // $("#sum_of_count").html(response.vote);
  //
  //         // console.log(response);
  //         // console.log(response.vote_counts);
  //       }
  //     });
  // });
});
