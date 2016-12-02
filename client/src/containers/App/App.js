import React, { Component, PropTypes } from 'react';

import Helmet from 'react-helmet';

import { connect } from 'react-redux';
import { push } from 'react-router-redux';

import { IndexLink } from 'react-router';
import { LinkContainer } from 'react-router-bootstrap';

import Nav from 'react-bootstrap/lib/Nav';
import Navbar from 'react-bootstrap/lib/Navbar';
import NavItem from 'react-bootstrap/lib/NavItem';

import config from '../../config';

import * as authActions from '../../redux/modules/auth';

@connect(
  state => ({
    user: state.auth.user
  }),
  {
    pushState: push,
    ...authActions
  }
)
export default class App extends Component {
  static propTypes = {
    children: PropTypes.object.isRequired,

    user: PropTypes.object,

    pushState: PropTypes.func.isRequired,
    signOut: PropTypes.func
  };

  render() {
    const styles = require('./App.scss');

    return (
      <div className={styles.app}>
        <Helmet title="Main" titleTemplate="GoodData | %s"/>

        <Navbar fixedTop>
          <Navbar.Header>
            <Navbar.Brand>
              <IndexLink to="/" activeStyle={{ color: '#33e0ff' }}>
                <span className={styles.brand} />
                <span>{config.app.name}</span>
              </IndexLink>
            </Navbar.Brand>
            <Navbar.Toggle/>
          </Navbar.Header>

          <Navbar.Collapse>
            <Nav navbar>
              {(this.props.user && this.props.user.email) &&
                <NavItem
                  onClick={ () => {
                    window.location.href = '/graphiql';
                  }}
                >GraphQL</NavItem>
              }
            </Nav>

            <Nav navbar pullRight>
              {(!this.props.user || !this.props.user.email) &&
                <LinkContainer to="signin">
                  <NavItem>Sign In</NavItem>
                </LinkContainer>
              }

              {this.props.user &&
                <LinkContainer to="profile">
                  <NavItem>{this.props.user.email}</NavItem>
                </LinkContainer>
              }

              {(this.props.user && this.props.user.email) &&
                <NavItem
                  onClick={ () => {
                    this.props.signOut().then(() => this.props.pushState('/'));
                  }}
                >
                  Sign Out
                </NavItem>
              }
            </Nav>
          </Navbar.Collapse>
        </Navbar>

        <div className={styles.appContent}>
          {this.props.children}
        </div>
      </div>
    );
  }
}

