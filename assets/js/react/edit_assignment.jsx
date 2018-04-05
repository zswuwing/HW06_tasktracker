import React from 'react';
import { Button, Form, FormGroup, Label, Input } from 'reactstrap';
import { Redirect } from 'react-router-dom';
import api from './api'
import { connect } from 'react-redux';


function Editassignment(props) {
  function publisher_submit(ev) {
    api.edit_assignment(props.cur_edit_assignment, props.token.user_id, "publisher", props.token);
  }

  function receiver_submit(ev) {
    api.edit_assignment(props.cur_edit_assignment, props.token.user_id, "receiver", props.token);
  }
  // function update(ev) {
  //   let tgt = $(ev.target);
  //
  //   let data = {};
  //   data[tgt.attr('name')] = tgt.val();
  //   let action = {
  //     type: "EDIT_CUR_ASSIGN",
  //     data: data,
  //   };
  //   console.log(action);
  //   props.dispatch(action);
  // }

  let users = _.map(props.users, (uu) => <option key={uu.id} value={uu.id}>{uu.name}</option>);
  let user_id = props.token.user_id;
  if(props.directornot) {
    return <Redirect to="/" />;
  }
  if(props.cur_edit_assignment.publisher_id == user_id) {
    return (
      <div style={{padding: "4ex"}}>
        <FormGroup>
          <Label for="receiver_id">Receiver</Label>
          <Input type="select" name="receiver_id" defaultValue={props.cur_edit_assignment.receiver_id} id="receiver_id" >
            { users }
          </Input>
        </FormGroup>

        <FormGroup>
          <Label for="headline">Headline</Label>
          <Input type="text" name="headline" id="headline" defaultValue={props.cur_edit_assignment.headline} />
        </FormGroup>

        <FormGroup>
          <Label for="description">Description</Label>
          <Input type="textarea" name="description" id="description" defaultValue={props.cur_edit_assignment.description} />
        </FormGroup>

        <Button onClick={publisher_submit}>Submit</Button> &nbsp;
      </div>
    );


  }
  else {
    return (
      <div style={{padding: "4ex"}}>

        <FormGroup>
          <Label for="hours">Hours</Label>
          <Input type="number" name="hours" id="hours" defaultValue={props.cur_edit_assignment.hours} />
        </FormGroup>
        <FormGroup>
          <Label for="minutes">Minutes</Label>
          <Input type="number" name="minutes" id="minutes" defaultValue={props.cur_edit_assignment.hours} min="0" max="45" step="15" />
        </FormGroup>

        <FormGroup>
          <Label for="complete">Complete</Label>
          <Input type="checkbox" defaultChecked={props.cur_edit_assignment.complete} name="complete" id="complete" defaultValue={props.cur_edit_assignment.complete} />
        </FormGroup>
        <Button onClick={receiver_submit}>Submit</Button> &nbsp;
      </div>
    );

  }
}

function state2props(state) {
  return {
    token: state.token,
    current_user_id: state.token.user_id,
    cur_edit_assignment: state.cur_assignment,
    directornot: state.directornot,
  }

}

export default connect(state2props)(Editassignment);
