import store from "./store"

class API {
  new_user(e) {
    e.preventDefault();
    let email = $("#email").val();
    let name = $("#name").val();
    let pass = $("#password").val();


    let data1 = JSON.stringify({
        user: {
            email: email,
            name: name,
            pass_hash: pass,
        }
    });




    $.ajax(user_path, {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: data1,
        success: () => {
	   window.location.replace("https://tasks3.kehu.pw");
            
        }
      });
  }


  submit_login(e) {
    e.preventDefault();
    let email = $("#email").val();
    let pass = $("#password").val();

    let data1 = {
        email: email,
        password: pass,

    };
    let r = JSON.stringify(data1);
    // console.log(data1);
    // console.log(r);

    $.ajax(token_path, {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: r,
      success: (resp) => {

        store.dispatch({
          type: 'SET_TOKEN',
          token: resp,
        });
      },
    });
  }
  //
  get_user() {
       $.ajax(user_path, {
           method: "get",
           success: (resp) => {
               store.dispatch({
                   type: "GET_USER",
                   users: resp.data,
               });
           }
       });
  }

  get_assignments() {
       $.ajax(assignment_path, {
           method: "get",
           dataType: "json",
           success: (resp) => {
               store.dispatch({
                   type: "GET_ASSIGNMENTS",
                   data: resp.data,
               });
           }
       });
  }

  new_assignment(e, publisher_id) {

    let receiver_id = $("#receiver_id").val();
    //let publisher_id = $("#publisher_id").val();
    let title = $("#headline").val();
    let body = $("#description").val();

    let text = {
        assignment: {
          receiver_id: receiver_id,
          publisher_id: publisher_id,
          headline: title,
          description: body,


        }
    };

    $.ajax(assignment_path, {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: JSON.stringify(text),
        success: (resp) => {
          store.dispatch({
            type: "REDIRECT",
          });
          store.dispatch({
            type: "NOREDIRECT",
          });

        }
    });
  }


    delete_assignment(assignment) {

      let ass_id = assignment.id;

      $.ajax(assignment_path+"/" + ass_id, {
          method: "delete",

          success: (resp) => {
            this.get_assignments();
            store.dispatch({
              type: "REDIRECT",
            });
            store.dispatch({
              type: "NOREDIRECT",
            });

          }
      });
    }

  save_cur_assign(assignment) {
    store.dispatch({
      type: "SAVE_CUR_ASSIGN",
      data: assignment,
    })
  }

  edit_assignment(oldone,publisher_id,character,token) {
    // console.log("oldone",oldone);
    // console.log("c",character);
    // console.log("t1",token);
    // console.log("t2",token.token);
    if(character == "publisher") {
      let receiver_id = $("#receiver_id").val();
      let headline = $("#headline").val();
      let description = $("#description").val();
      let text = {
          assignment: {
            receiver_id: receiver_id,
            publisher_id: oldone.publisher_id,
            headline: headline,
            description: description,
            hours: oldone.hours,
            minutes: oldone.minutes,
            complete: oldone.complete,
          }
      };
      $.ajax(assignment_path+"/"+oldone.id, {
          type: "patch",
          dataType: "json",
          contentType: "application/json; charset=UTF-8",
          data: JSON.stringify(text),
          //discussed with Cheng Zeng about how to direct
          success: (resp) => {

            store.dispatch({
              type: "REDIRECT",
            });
            store.dispatch({
              type: "NOREDIRECT",
            });
          }
      });
    }
    else {
      let hours = $("#hours").val();
      let minutes = $("#minutes").val();
      let complete = false;
      if($("#complete").is(":checked")) {
        complete = true;
      }
      // console.log("h",hours);
      // console.log("m",minutes);
      // console.log("c",complete);
      let text = {
          assignment: {
            receiver_id: oldone.receiver_id,
            publisher_id: oldone.publisher_id,
            headline: oldone.headline,
            description: oldone.description,
            hours: hours,
            minutes: minutes,
            complete: complete,
          }
      };
      $.ajax(assignment_path+"/"+oldone.id, {
          type: "patch",
          dataType: "json",
          contentType: "application/json; charset=UTF-8",
          data: JSON.stringify(text),
          //discussed with Cheng Zeng about how to direct
          success: (resp) => {

            store.dispatch({
              type: "REDIRECT",
            });
            store.dispatch({
              type: "NOREDIRECT",
            });
          }
      });

    }

  }
}

export default new API();
