import React, { Component } from "react";
import CanvasJSReact from "./canvasjs.react";
var CanvasJSChart = CanvasJSReact.CanvasJSChart;

class CandlestickChart extends Component {
    constructor(props) {
        super();
    }
    render() {
        const options = {
            theme: "light2", // "light1", "light2", "dark1", "dark2"
            animationEnabled: true,
            exportEnabled: true,
            title: {
                text: "",
            },
            axisX: {
                valueFormatString: "MMM",
            },
            axisY: {
                includeZero: false,
                prefix: "$",
                title: "Price ",
            },
            data: [
                {
                    type: "candlestick",
                    showInLegend: true,
                    name: "",
                    yValueFormatString: "$###0.00",
                    xValueFormatString: "MMMM YY",
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

export default CandlestickChart;
