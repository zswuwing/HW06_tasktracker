import React from 'react';
import { Button, assign_form, FormGroup, Label, Input } from 'reactstrap';
import { Redirect } from 'react-router-dom';
import api from './api';
import { connect } from 'react-redux';



function AssignmentForm(props) {
  // console.log("props@assignmentForm",props);
  function update(ev) {
    let tgt = $(ev.target);

    let data = {};
    data[tgt.attr('name')] = tgt.val();
    let action = {
      type: 'UPDATE_FORM',
      data: data,
    };
    //console.log(action);
    props.dispatch(action);
  }

  function submit(ev) {
    api.new_assignment(props.assign_form, props.token.user_id);
    //console.log("submit",props.assign_form);
  }

  function clear(ev) {
    props.dispatch({
      type: 'CLEAR_FORM',
    });
  }

  if(props.directornot) {
    return <Redirect to="/" />;
  }

  let users = _.map(props.users, (uu) => <option key={uu.id} value={uu.id}>{uu.name}</option>);
  return <div style={{padding: "4ex"}}>
    <h2>New Assignment</h2>
      <FormGroup>
        <Label for="receiver_id">Receiver</Label>
        <Input type="select" name="receiver_id" value={props.assign_form.receiver_id} id="receiver_id" onChange={update}>
          { users }
        </Input>
      </FormGroup>
      <FormGroup>
        <Label for="headline">Headline</Label>
        <Input type="text" name="headline" id="headline" value={props.assign_form.headline} onChange={update} />
      </FormGroup>
      <FormGroup>
        <Label for="description">Description</Label>
        <Input type="textarea" name="description" id="description" value={props.assign_form.description} onChange={update}/>
      </FormGroup>
      <Button onClick={submit}>Submit</Button> &nbsp;
      <Button onClick={clear}>Clear</Button>
  </div>;

}



function state2props(state) {
  //console.log("rerender@PostForm", state);
  return {
    token: state.token,
    assign_form: state.assign_form,
    directornot: state.directornot,
    users: state.users,
  };
}

export default connect(state2props)(AssignmentForm);
