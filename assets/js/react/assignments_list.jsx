import React from 'react';
import { Button, Form, FormGroup, Label, Input, Card } from 'reactstrap';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import api from './api'
import LoginForm from './login';
import { connect } from 'react-redux';
import { Redirect } from 'react-router-dom';

function Assignments(props) {
  let current_user_id = props.token.user_id;
  // console.log("id",current_user_id);
  //
  // console.log("props",props.assignments);
  if(props.directornot) {
    return <Redirect to="/" />;
  }

  let all_assignments = _.filter(props.assignments, (s) => {
    // console.log(s);
    return(s.receiver_id == current_user_id) || (s.publisher_id == current_user_id)
  });

  return <Assignments_List assignments={all_assignments} user_id={current_user_id} token={props.token.token}/>;
}


function Assignments_List(props) {


  function Me(props) {
    function Delete(props) {
      if(props.assignment.publisher_id == props.user_id) {
        return (
          <Button onClick={() => {api.delete_assignment(props.assignment)}}>
            Delete
          </Button>
        );
      }
      else {
        return null;
      }
    }

    let all = [];
    let assignments = props.assignments;
    // console.log("ass",assignments)
    _.each(assignments, (assignment) => {
        all.push(
          <tr key={assignment.id.toString()}>
            <td>{assignment.publisher_id}</td>
            <td>{assignment.receiver_id}</td>
            <td>{assignment.headline}</td>
            <td>{assignment.description}</td>
            <td>{assignment.hours}</td>
            <td>{assignment.minutes}</td>
            <td>{assignment.complete+""}</td>
            <td className="text-right">
              <div>
                <Link to="/editassignment" onClick={() => {api.save_cur_assign(assignment)}}>
                  Edit
                </Link>
              </div>

              <Delete assignment={assignment} user_id={props.user_id}/>

            </td>

          </tr>);
    });

    return all;

  }

  let ass = props.assignments;
  return (
    <div>
      <h2>Listing Assignments</h2>

      <table className="table">
        <thead>
          <tr>
            <th>Publisher</th>
            <th>Receiver</th>
            <th>Headline</th>
            <th>Description</th>
            <th>Hours</th>
            <th>Minutes</th>
            <th>Complete</th>

            <th></th>
          </tr>
        </thead>
        <tbody>

        <Me assignments={ass} user_id={props.user_id}/>


        </tbody>
      </table>
   </div>
  )
}
function state2props(state) {
    return {
        token: state.token,
        assignments: state.assignments,
        directornot: state.directornot,
    };
}

export default connect(state2props)(Assignments);
