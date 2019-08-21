import React from 'react';
import { Form, FormGroup, Label, Input, Button } from 'reactstrap';
import { observer } from 'mobx-react';
import postFeedbackService from '../services/PostFeedbackService';

@observer
class FeedbackForm extends React.Component {
  submitFeedback(formData) {
    const pFS = new postFeedbackService();
    return pFS.postFeedback(formData);
  }
  render() {
    return (
      <Form className="offset-md-3 col-md-6" style={{ width: `${50}%` }}>
        <FormGroup>
          <Label>Your name:</Label>
          <Input type="text" value={this.props.store.feedbackName} onChange={event => this.props.store.setName(event.target.value)} />
        </FormGroup>
        <FormGroup>
          <Label>Comments</Label>
          <Input type="textarea" rows="10" value={this.props.store.feedbackText} onChange={event => this.props.store.setText(event.target.value)} />
        </FormGroup>
        <Button value="Submit" color="primary" onClick={() => this.submitFeedback({ feedbackName: this.props.store.feedbackName, feedbackText: this.props.store.feedbackText })} >Submit</Button>
      </Form>
    );
  }
}

export default FeedbackForm;
