import React, {Component} from 'react';
import { Link } from 'react-router';

export default class Intro extends Component {
  render() {
    return (
      <div className="container">
        <div className="jumbotron" style={{marginTop: '50px'}} >
          <div className="container">
            <h1>GoodData</h1>

            <p>Commercialize and Monetize Your Data.</p>

            <p>
              <Link to="/signin" className="btn btn-primary btn-lg" role="button" style={{marginRight: '5px'}}>
                Login &raquo;
              </Link>

              <Link to="/" className="btn btn-default btn-lg" role="button">
                Gallery &raquo;
              </Link>
            </p>
          </div>
        </div>

        <div className="row">
          <div className="col-md-4">
            <h2>Analytics as a Profit Center</h2>

            <p>
              GoodData provides the platform and expertise to transform your business’ data into revenue-generating assets with outward facing analytics.
            </p>

            <p>
              <Link to="/" className="btn btn-default" role="button">
                More &raquo;
              </Link>
            </p>
          </div>

          <div className="col-md-4">
            <h2>Designed for Large Scale Distribution</h2>

            <p>
              We help accelerate your digital transformation by distributing data-driven products to your entire business network - not just internal teams.
            </p>

            <p>
              <Link to="/" className="btn btn-default" role="button">
                More &raquo;
              </Link>
            </p>
          </div>

          <div className="col-md-4">
            <h2>All of the Support, None of the Trade-offs</h2>

            <p>
              Our highly scalable platform and team of experts reduce the risks of technical ownership and seriously accelerate innovation and time to market.
            </p>

            <p>
              <Link to="/" className="btn btn-default" role="button">
                More &raquo;
              </Link>
            </p>
          </div>
        </div>
      </div>
    );
  }
}
