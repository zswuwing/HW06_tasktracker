import React from 'react';
import { NavLink } from 'react-router-dom';
import { NavItem } from 'reactstrap';
import { connect } from 'react-redux';



function Nav(props) {
  let email = "";
  if(props.token) {
    email = props.token.email;

  }
  else {
    email = "user@host";
  }
  return (
    <nav className="navbar navbar-dark bg-dark navbar-expand">
      <span className="navbar-brand">
        Tasktracker
      </span>
      <ul className="navbar-nav mr-auto">
        <NavItem>
          <NavLink to="/" exact={true} activeClassName="active" className="nav-link">Home</NavLink>
        </NavItem>
      </ul>
      <span className="navbar-text">
        {email}
      </span>
    </nav>
  );
}

function state2props(state) {
  return {
    token: state.token,
  }

}

export default connect(state2props)(Nav);
