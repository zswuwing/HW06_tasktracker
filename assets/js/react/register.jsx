import React from 'react';
import { Button, Form, FormGroup, Label, Input } from 'reactstrap';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom';
import api from './api'
import { connect } from 'react-redux';

export default function RegisterForm(params) {
  return <div style={{padding: "4ex"}}>
    <h2>New User</h2>
    <Form onSubmit={(e) => {api.new_user(e);}}>
      <FormGroup>
        <Label for="name">Name</Label>
        <Input type="text" name="name"id="name" />
      </FormGroup>
      <FormGroup>
        <Label for="email">Email</Label>
        <Input type="text" name="email" id="email"/>
      </FormGroup>

      <FormGroup>
        <Label for="password">Password</Label>
        <Input type="password" name="password" id="password"/>
      </FormGroup>
      <Button type="submit">Submit</Button>

    </Form>
  </div>;
}
