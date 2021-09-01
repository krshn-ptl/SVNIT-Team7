import React, { useEffect, useState } from "react";
import { Route } from "react-router-dom";
import "./Body.css";
import CandlestickChart from "./Candlestick Chart";
import OhlcChart from "./OHLC Chart";
import RangeColumnChart from "./Range Column Chart";
import axios from "axios";

const Body = () => {
    const [inidate, setInidate] = useState("");
    const [fidate, setFidate] = useState("");
    const [symbol, setSymbol] = useState("");
    const [allsymbols, setAllsymbols] = useState([]);
    const [alldata, setAlldata] = useState([]);

    useEffect(() => {
        async function getSymbols() {
            const res = await axios.get("http://localhost:5000/symbols");
            setAllsymbols(res.data.data);
        }

        getSymbols();
        async function getdatabysymbol() {
            const res = await axios.get(
                `http://localhost:5000/getdata?symbol=${symbol}&inidate=${inidate}&fidate=${fidate}`
            );
            setAlldata(res.data.data);
            console.log(alldata);
            // console.log(res.data);
        }
        getdatabysymbol();
    }, []);

    let newdata = [];
    alldata.forEach((ele) => {
        let newele = {};
        newele.x = new Date(ele.date);
        newele.y = [ele.open, ele.high, ele.low, ele.close];
        newdata.push(newele);
    });

    // console.log(newdata);
    useEffect(() => {
        async function getdatabysymbol() {
            const res = await axios.get(
                `http://localhost:5000/getdata?symbol=${symbol}&inidate=${inidate}&fidate=${fidate}`
            );
            setAlldata(res.data.data);
            console.log(alldata);
            // console.log(res.data);
        }
        getdatabysymbol();
    }, [symbol, inidate, fidate]);

    return (
        <div className="body">
            <div className="chart">
                <div className="chart_plot">
                    <Route path="/" exact>
                        <OhlcChart data={newdata} />
                    </Route>
                    <Route path="/candlestick" exact>
                        <CandlestickChart data={newdata} />
                    </Route>
                    <Route path="/rangedcolumn" exact>
                        <RangeColumnChart data={newdata} />
                    </Route>
                </div>
            </div>

            <div className="query">
                <div className="query_daterange">
                    <p>Initial date:</p>
                    <input
                        type="date"
                        name="initialdate"
                        id="initialdate"
                        onChange={(e) => {
                            setInidate(e.target.value);
                        }}
                    />
                    <p>Final date:</p>
                    <input
                        type="date"
                        name="finaldate"
                        id="finaldate"
                        onChange={(e) => {
                            setFidate(e.target.value);
                        }}
                    />
                </div>

                <div className="query_symbol">
                    <p>Select symbol:</p>
                    <select
                        onChange={(e) => {
                            setSymbol(e.target.value);
                        }}
                    >
                        <option val="not selected">---Select---</option>
                        {allsymbols.map((ele) => (
                            <option value={ele}>{ele}</option>
                        ))}
                    </select>
                </div>
            </div>
        </div>
    );
};

export default Body;
