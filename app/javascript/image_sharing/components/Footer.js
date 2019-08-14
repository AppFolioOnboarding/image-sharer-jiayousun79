import React, { Component } from 'react';
import { Row, Col } from 'reactstrap';
import PropTypes from 'prop-types';

class Footer extends Component {
  static propTypes = {
    text: PropTypes.string.isRequired
  };

  render() {
    return (
      <div>
        <Row>
          <Col lg={{ size: 4, offset: 4 }}>
            <div className="text-center" style={{ fontSize: `${10}px` }}>
              {this.props.text}
            </div>
          </Col>
        </Row>
      </div>
    );
  }
}

export default Footer;
