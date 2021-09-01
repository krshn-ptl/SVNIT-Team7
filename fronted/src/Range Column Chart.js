import React, { Component } from "react";
import CanvasJSReact from "./canvasjs.react";
var CanvasJSChart = CanvasJSReact.CanvasJSChart;

class RangeColumnChart extends Component {
    constructor() {
        super();
    }
    render() {
        const options = {
            theme: "light2",
            exportEnabled: true,
            animationEnabled: true,
            title: {
                text: "",
            },
            axisX: {
                valueFormatString: "MMM YYYY",
            },
            axisY: {
                includeZero: false,
                title: "Price",
                suffix: "",
            },
            data: [
                {
                    type: "rangeColumn",
                    indexLabel: "",
                    xValueFormatString: "MMM YYYY",
                    toolTipContent: "",
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

export default RangeColumnChart;
