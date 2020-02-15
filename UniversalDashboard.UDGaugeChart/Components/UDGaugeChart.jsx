import React from 'react';
import ReactDOM from "react-dom";
import Chart from "react-google-charts";

const columns = [
  { type: "string", label: "Label" },
  { type: "number", label: "Value" }
];
class UDGaugeChart extends React.Component {
  componentDidMount() {
    setInterval(() => {
      this.setState({ refresh: Date.now() });
    }, 5000);
  }
  render() {
    return (
      <Chart
        width={this.props.width}
        height={this.props.height}
        chartType="Gauge"
        loader={<div>Loading Chart</div>}
        data={[columns, ...this.props.data]}
        options={{
          redFrom: this.props.redFrom,
          redTo: this.props.redTo,
          yellowFrom: this.props.yellowFrom,
          yellowTo: this.props.yellowTo,
          minorTicks: this.props.minorTicks,
        }}
      />
    )
  }
}

export default UDGaugeChart
