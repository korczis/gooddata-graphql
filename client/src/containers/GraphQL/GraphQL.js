import React, {Component} from 'react';
import Helmet from 'react-helmet';

import GraphiQL from 'graphiql';
import fetch from 'isomorphic-fetch';

export function graphQLFetcher(graphQLParams) {
  return fetch(`${window.location.origin}/graphql`, {
    method: 'post',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(graphQLParams),
  }).then(response => response.json());
}

export default class GraphQL extends Component {
  render() {
    const title = 'GraphQL';
    return (
      <div>
        <Helmet title={title} />
        <GraphiQL fetcher={graphQLFetcher} style={{width: '1024px', height: '768px'}} />
      </div>
    );
  }
}
