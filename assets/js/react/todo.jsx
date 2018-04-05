import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Route } from 'react-router-dom';

import Nav from './nav';
import AssignmentForm from './new-assignment-form';
import LoginForm from './login';
import RegisterForm from "./register";
import api from "./api";
import { Provider, connect } from 'react-redux';
import Login_First from "./login_and_after";
import Editassignment from "./edit_assignment";

export default function tasktracker_init(store,root) {
  let a = store;
  ReactDOM.render(
    <Provider store={store}>
      <Tasktracker store={store.getState()}/>
    </Provider>, root);
}

class Tasktracker extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      users: [],
    };
    //
    // this.request_posts();
    this.request_users();
  }

  // request_posts() {
  //   $.ajax("/api/v1/posts", {
  //     method: "get",
  //     dataType: "json",
  //     contentType: "application/json; charset=UTF-8",
  //     success: (resp) => {
  //       this.setState(_.extend(this.state, { posts: resp.data }));
  //     },
  //   });
  // }

  request_users() {
    $.ajax("/api/v1/users", {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      success: (resp) => {
        this.setState(_.extend(this.state, { users: resp.data }));
      },
    });
  }

  render() {
    return (
      <Router>
        <div>
          <Nav />
          <Route path="/" exact={true} render={() =>
            <div>
              <Login_First />
            </div>
          } />
          <Route path="/newuser" exact={true} render={() =>
            <div>
              <RegisterForm />
            </div>
          } />
        <Route path="/editassignment" exact={true} render={() =>
            <div>
              <Editassignment onEnter={api.get_user()} users={this.state.users}/>
            </div>
          } />
        <Route path="/newassignment" exact={true} render={() =>
            <div>
              <AssignmentForm onEnter={api.get_user()}/>
            </div>
          } />
        </div>
      </Router>
    );
  }
}
