import React from 'react';
import { Button, Form, FormGroup, Label, Input } from 'reactstrap';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import api from './api'
import LoginForm from './login';
import { connect } from 'react-redux';
import Assignments from './assignments_list'

function Login_First(props) {
  return(
    <div>
      <Login_Page token={props.token} />
    </div>
  );
}

function Login_Page(props) {
  if(props.token) {
    return (
      <div>
        <div>
          <Assignments onEnter={api.get_assignments()}/>
        </div>
        <div>
          <Link to="/newassignment" >
            <Button color="blue" >New Assignment</Button>
          </Link>
        </div>
      </div>
    );
  }
  else{
    return (<LoginForm />);

  }
}

function state2props(state) {
  return {
    token: state.token,
    users: state.users,
  }

}

export default connect(state2props)(Login_First);
