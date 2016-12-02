import {generateReduxSymbol} from '../helpers/redux';

const PROJECTS_GET = generateReduxSymbol('data/PROJECTS_GET');
const PROJECTS_GET_SUCCESS = generateReduxSymbol('data/PROJECTS_GET_SUCCESS');
const PROJECTS_GET_FAIL = generateReduxSymbol('data/PROJECTS_GET_FAIL');

const initialState = {
  projects: []
};

export default function reducer(state = initialState, action = {}) {
  switch (action.type) {
    case PROJECTS_GET_SUCCESS: {
      return {
        ...state,
        projects: action.result.projects
      };
    }
    default:
      return state;
  }
}

export function projectsGet(url) {
  return {
    types: [PROJECTS_GET, PROJECTS_GET_SUCCESS, PROJECTS_GET_FAIL],
    promise: (client) => client.get(`/api/v1/proxy${url}`)
  };
}
