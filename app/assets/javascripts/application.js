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

  // $("#signup-btn").on("click", function(){
  //   $suForm = $("#signup-form")
  //   if ($suForm.hasClass("hidden")) {
  //     $suForm.removeClass("hidden")
  //   } else {
  //     $suForm.addClass("hidden")
  //   }
  // });
  //
  // $("#login-btn").on("click", function(){
  //   $loForm = $("#login-form")
  //   if ($loForm.hasClass("hidden")) {
  //     $loForm.removeClass("hidden")
  //   } else {
  //     $loForm.addClass("hidden")
  //   }
  // });

  // Checking and crossing out completed shopping items
  $(".check-form").submit('turbolinks:load',function(e){
    e.preventDefault();
    console.log("prevented default")


    $check = $(event.target);

    $.ajax({
      url: $check.attr('action'),
      method: $check.attr('method'),
      data: $check.serialize(),
      dataType: "JSON",
      success: function(response) {
          if ($check.find("i").hasClass("glyphicon-unchecked")) {
            $check.find("i").removeClass("glyphicon-unchecked");
            $check.find("i").addClass("glyphicon-check");
            $check.parent().siblings(".shopping-item").addClass("strike-text");
            $check.attr("action", "/users/" + response.user_id + "/shopping_items/" + response.id + "/uncheck");
          } else {
            $check.find("i").removeClass("glyphicon-check");
            $check.find("i").addClass("glyphicon-unchecked");
            $check.parent().siblings(".shopping-item").removeClass("strike-text");
            $check.attr("action", "/users/" + response.user_id + "/shopping_items/" + response.id + "/check");
          }
        }
      });
    });

  // unchecking misakenly crossed out shopping items
  $(".uncheck-form").submit('turbolinks:load',function(e){
    e.preventDefault();
    console.log("prevented default")

    $uncheck = $(event.target);

    $.ajax({
      url: $uncheck.attr('action'),
      method: $uncheck.attr('method'),
      data: $uncheck.serialize(),
      dataType: "JSON",
      success: function(response) {
        if ($uncheck.find("i").hasClass("glyphicon-check")) {
          $uncheck.find("i").removeClass("glyphicon-check");
          $uncheck.find("i").addClass("glyphicon-unchecked");
          $uncheck.parent().siblings(".shopping-item").removeClass("strike-text");
          $uncheck.attr("action", "/users/" + response.user_id + "/shopping_items/" + response.id + "/check");
        } else {
          $uncheck.find("i").removeClass("glyphicon-unchecked");
          $uncheck.find("i").addClass("glyphicon-check");
          $uncheck.parent().siblings(".shopping-item").addClass("strike-text");
          $uncheck.attr("action", "/users/" + response.user_id + "/shopping_items/" + response.id + "/uncheck");
        }
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
