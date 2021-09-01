import React, { Component } from "react";
import CanvasJSReact from "./canvasjs.react";
var CanvasJSChart = CanvasJSReact.CanvasJSChart;

class OhlcChart extends Component {
    constructor(props) {
        super();
    }
    render() {
        const options = {
            animationEnabled: true,
            exportEnabled: true,
            theme: "light2",
            exportFileName: "",
            title: {
                text: "",
            },
            axisX: {
                interval: 1,
                intervalType: "month",
                valueFormatString: "MMM",
            },
            axisY: {
                includeZero: false,
                prefix: "$",
                title: "Price ",
            },
            data: [
                {
                    type: "ohlc",
                    yValueFormatString: "$###0.00",
                    xValueFormatString: "MMM YYYY",
                    dataPoints: this.props.data,
                },
            ],
        };

        return (
            <div>
                <CanvasJSChart
                    options={options}
                    /* onRef={ref => this.chart = ref} */
                />
                {/*You can get reference to the chart instance as shown above using onRef. This allows you to access all chart properties and methods*/}
            </div>
        );
    }
}

export default OhlcChart;
