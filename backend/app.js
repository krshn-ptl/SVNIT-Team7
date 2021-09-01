const express = require("express");
// const path = require("path");
const data = require("./Stock List.json");
const cors = require("cors");
const app = express();
const func = require("./functions/dataclean");
app.use(cors());
app.get("/getdata", (req, res) => {
    res.setHeader("Content-Type", "application/json");
    // console.log(req.query);
    if (
        req.query.symbol !== "" &&
        req.query.inidate !== "" &&
        req.query.fidate !== ""
    ) {
        let newdata = func.cleanDataByDateRange(
            func.cleanDataBySymbol(func.cleanData(data), req.query.symbol),
            req.query.inidate,
            req.query.fidate
        );
        // console.log(newdata);
        res.send({ data: newdata });
    } else if (req.query.symbol !== "") {
        let newdata = func.cleanDataBySymbol(
            func.cleanData(data),
            req.query.symbol
        );
        // console.log(newdata[0]);
        res.send({ data: newdata });
    } else if (req.query.inidate !== "" && req.query.fidate !== "") {
        let newdata = func.cleanDataByDateRange(
            func.cleanData(data),
            req.query.inidate,
            req.query.fidate
        );
        // console.log(newdata);
        res.send({ data: newdata });
    } else {
        // console.log("here");
        let newdata = func.cleanData(data);
        // console.log(newdata);
        res.send({ data: newdata });
    }
});

app.get("/symbols", (req, res) => {
    let data = func.getSymbols();
    // console.log(data);
    res.send({ data });
    // console.log("data sent");
});

app.listen(5000, () => {
    console.log("App Starting");
});
