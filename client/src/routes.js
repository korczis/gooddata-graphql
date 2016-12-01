import React from 'react';
import {IndexRoute, Route} from 'react-router';

import App from './containers/App';
import Intro from './containers/Intro';
import NotFound from './containers/NotFound';
import Profile from './containers/Profile';
import SignIn from './containers/SignIn';

export default (/* store */) => {
  /**
   * Please keep routes in alphabetical order
   */
  return (
    <Route path="/" component={App}>
      <IndexRoute component={Intro}/>

      <Route path="intro" component={Intro}/>
      <Route path="profile" component={Profile}/>
      <Route path="signin" component={SignIn}/>

      { /* Catch all route */ }
      <Route path="*" component={NotFound} status={404} />
    </Route>
  );
};
