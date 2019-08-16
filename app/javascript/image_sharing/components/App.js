import React, { Component } from 'react';
import { inject, observer } from 'mobx-react';
import Header from './Header';
import Footer from './Footer';
import FeedbackForm from './FeedbackForm';

@observer
class App extends Component {
  render() {
    return (
      <div>
        <Header title="Tell us what you think" />
        <FeedbackForm store={this.props.stores.feedbackStore} />
        <Footer text="Copyright: Appfolio Inc. Onboarding" />
      </div>
    );
  }
}

export default inject('stores')(App);
