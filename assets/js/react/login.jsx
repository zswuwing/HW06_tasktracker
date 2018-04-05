import React from 'react';
import { Button, Form, FormGroup, Label, Input } from 'reactstrap';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import api from './api'

export default function LoginForm(params) {
  return <div style={{padding: "4ex"}}>
    <h2>Log In</h2>
    <Form onSubmit={(e) => {api.submit_login(e);}}>
      <FormGroup>
        <Label htmlFor="email">Email</Label>
        <Input type="email" name="email" id="email" >
      </FormGroup>

      <FormGroup>
        <Label htmlFor="password">Password</Label>
        <Input type="password" name="password" id="password">
      </FormGroup>


      <Button type="submit">Submit</Button>
      <Link to="/newuser" activeclassname="active">Register</Link>
    </Form>
  </div>;
}
