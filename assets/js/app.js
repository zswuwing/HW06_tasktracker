// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
import $ from "jquery";

// ...

function update_buttons() {
  $('.supervision-button').each( (_, bb) => {
    let user_id = $(bb).data('user-id');
    let supervision = $(bb).data('supervision');
    if (supervision != "") {
      $(bb).text("Unset to Supervised");
    }
    else {
      $(bb).text("Set to Supervised");
    }
  });
}

function set_button(user_id, value) {
  $('.supervision-button').each( (_, bb) => {
    if (user_id == $(bb).data('user-id')) {
      $(bb).data('supervision', value);
    }
  });
  update_buttons();
}

function supervision(user_id) {
  let text = JSON.stringify({
    supervision: {
        supervisor_id: current_user_id,
        underling_id: user_id,
      },
  });

  $.ajax(supervision_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { set_button(user_id, resp.data.id); },
  });
}

function unsupervision(user_id, supervision_id) {
  $.ajax(supervision_path + "/" + supervision_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: () => { set_button(user_id, ""); },
  });
}

function supervision_click(ev) {
  let btn = $(ev.target);
  let supervision_id = btn.data('supervision');
  let user_id = btn.data('user-id');

  if (supervision_id != "") {

    unsupervision(user_id, supervision_id);

  }
  else {
    supervision(user_id);
  }
}


function update_work_buttons() {
  $('.work-button').each( (_, bb) => {
    let time_id = $(bb).data('time-id');
    let assignment_id = $(bb).data('assignment-id');
    if (time_id != "") {
      $(bb).text("Stop Work");
    }
    else {
      $(bb).text("Start Work");
    }
  });
}

function set_work_button(assignment_id, value) {
  $('.work-button').each( (_, bb) => {
    if (assignment_id == $(bb).data('assignment-id')) {
      $(bb).data('time-id', value);
    }
  });
  update_work_buttons();
}

function start(assignment_id) {
  let current_time = new Date();
  let text = JSON.stringify({
    timeblock: {
        assignment_id: assignment_id,
        start_time: current_time,
        end_time: current_time,
      },
  });

  $.ajax(timeblock_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { set_work_button(assignment_id, resp.data.id); },
  });
}

function end(assignment_id, timeblock_id) {
  let current_time = new Date();

  let text = JSON.stringify({
    timeblock: {
        end_time: current_time,
    }
  });
  $.ajax(timeblock_path + "/" + timeblock_id, {
    type: "patch",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: () => { set_work_button(assignment_id, "");
                      location.reload(); },
  });
}

function work_click(ev) {
  let btn = $(ev.target);
  let assignment_id = btn.data('assignment-id');
  let time_id = btn.data('time-id');

  if (time_id != "") {

    end(assignment_id, time_id);

  }
  else {
    start(assignment_id);
  }
}

function add_block(ev) {
    let start_date = $(".start-date-input").val();
    let start_time = $(".start-time-input").val();
    let end_date = $(".end-date-input").val();
    let end_time = $(".end-time-input").val();
    let a = new Date(start_date + "T" + start_time);
    let b = new Date(end_date + "T" + end_time);

    console.log(a);
    console.log(b);
    if (a > b) {
        alert("End Date can not before Start Date");
    }
    // else if (end_date >= start_ && start_time >= end_time) {
    //   alert("End Time can not before Start Time")
    // }


    else {
        let assignment_id = $(ev.target).data("assignment-id");

        // console.log(start_time);
        // console.log(stop_time);

        let text = JSON.stringify({
            timeblock: {
                assignment_id: assignment_id,
                start_time: a,
                end_time: b,
            }
        });

        $.ajax(timeblock_path, {
            method: "post",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: text,
            success: () => {location.reload();}
        });
    }
}


function delete_block(ev) {
    if (confirm("Are you sure?")) {
        let btn = $(ev.target);
        let time_id = btn.data("time-id");

        $.ajax(timeblock_path + "/" + time_id, {
            method: "delete",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: "",
            success: () => {location.reload();}
        });
    }
}


function init_supervision() {
  // if (!$('.supervision-button')) {
  //   return;
  // }
  // if (!$('.work-button')) {
  //   return;
  // }

  $(".supervision-button").click(supervision_click);
  $(".work-button").click(work_click);
  $(".add-block").click(add_block);
  $(".delete-block").click(delete_block);
  update_buttons();
  update_work_buttons();
}

$(init_supervision);
