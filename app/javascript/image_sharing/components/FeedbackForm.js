import React from 'react';
import { Form, FormGroup, Label, Input, Button } from 'reactstrap';
import { observer } from 'mobx-react';

@observer
class FeedbackForm extends React.Component {
  render() {
    return (
      <Form className="offset-md-3 col-md-6" style={{ width: `${50}%` }}>
        <FormGroup>
          <Label>Your name:</Label>
          <Input type="text" value={this.props.store.feedback_name} onChange={event => this.props.store.setName(event.target.value)} />
        </FormGroup>
        <FormGroup>
          <Label>Comments</Label>
          <Input type="textarea" rows="10" value={this.props.store.feedback_text} onChange={event => this.props.store.setText(event.target.value)} />
        </FormGroup>
        <Button value="Submit" color="primary">Submit</Button>
      </Form>
    );
  }
}

export default FeedbackForm;
