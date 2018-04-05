import { createStore, combineReducers } from 'redux';
import deepFreeze from 'deep-freeze';

/*
 *  state layout:
 *  {
 *   posts: [... Posts ...],
 *   users: [... Users ...],
 *   form: {
 *     user_id: null,
 *     body: "",
 *   }
 * }
 *
 * */

function assignments(state=[],action) {
  switch (action.type) {
  case "GET_ASSIGNMENTS":
    return action.data;
  default:
    return state;
  }

}

function users(state = [], action) {
  switch (action.type) {
  case 'USERS_LIST':
    return action.users;
  default:
    return state;
  }
}

let empty_form = {
  receiver_id: "",
  publisher_id: "",
  headline: "",
  description: "",
};

function assign_form(state = empty_form, action) {
  switch (action.type) {
    case 'UPDATE_FORM':
      return Object.assign({}, state, action.data);
    case 'CLEAR_FORM':
      return empty_form;
    default:
      return state;
  }
}

function token(state = null, action) {
  switch (action.type) {
    case 'SET_TOKEN':
      return action.token;
    case 'CLEAR_TOKEN':
      return null;
    default:
      return state;
  }
}


function directornot(state = false, action) {
  switch (action.type) {
    case "REDIRECT":
      return true;
    case "NOREDIRECT":
      return false;
    default:
      return state;
  }
}

let empty_login = {
  name: "",
  pass: "",
};

function login(state = empty_login, action) {
  switch (action.type) {
    case 'UPDATE_LOGIN_FORM':
      return Object.assign({}, state, action.data);
    default:
      return state;
  }
}

function cur_assignment(state = null, action) {
  switch (action.type) {
    case "SAVE_CUR_ASSIGN":
      return Object.assign({}, state, action.data);
    default:
      return state;
  }
}

// function edit_to_assignment(state = null, action) {
//   switch (action.type) {
//     case "EDIT_CUR_ASSIGN":
//       return Object.assign({}, state, action.data);
//     default:
//       return state;
//   }
// }

function root_reducer(state0, action) {
  // console.log("reducer", action);
  // {posts, users, form} is ES6 shorthand for
  // {posts: posts, users: users, form: form}
  let reducer = combineReducers({assign_form, token, assignments, cur_assignment, users, directornot});
  let state1 = reducer(state0, action);
  // console.log("state1", state1);
  return deepFreeze(state1);
};

let store = createStore(root_reducer);
export default store;
