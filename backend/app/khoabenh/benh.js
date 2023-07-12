const express = require("express");
const app = express();
const session = require("express-session");
const db = require("../../data/data.js");
const mysql = require("mysql2");

app.get("/api/danhsachbenh", (req, res) => {
  db.query("SELECT * FROM tbl_benh", (err, result) => {
    if (err) {
      res.status(422).json("không thực hiện được");
    } else {
      res.status(201).json(result);
    }
  });
});

app.get("/api/khoabenh/:idKhoabenh", (req, res) => {
  db.query(
    "SELECT * FROM tbl_khoabenh WHERE idKhoabenh = ?",
    [req.params.idKhoabenh],
    (err, result) => {
      if (err) {
        res.status(422).json("Không thực hiện được");
      } else {
        res.status(201).json(result);
      }
    }
  );
});

app.get("/api/khoabenh", (req, res) => {
  db.query("SELECT * FROM tbl_khoabenh WHERE id = ?", (err, result) => {
    if (err) {
      res.status(422).json("Không thực hiện được");
    } else {
      res.status(201).json(result);
    }
  });
});

app.get("/api/loaibenh", (req, res) => {
  db.query("SELECT * FROM tbl_loaibenh", (err, result) => {
    if (err) {
      res.status(422).json("không thực hiện được");
    } else {
      res.status(201).json(result);
    }
  });
});

app.get("/api/loaibenh/:idLoaibenh", (req, res) => {
  const { idLoaibenh } = req.params;
  const sql = "SELECT * FROM tbl_loaibenh WHERE idLoaibenh = ?";
  db.query(sql, [idLoaibenh], (err, result) => {
    if (err) {
      console.log(err);
      res.status(422).json("Không thực hiện được");
    } else {
      res.send(result);
    }
  });
});

app.get("/api/benh/:tenbenh", (req, res) => {
  const { tenbenh } = req.params;
  const sql = "SELECT * FROM tbl_benh WHERE tenbenh = ?";
  db.query(sql, [tenbenh], (err, result) => {
    if (err) {
      console.log(err);
      res.status(422).json("Không thực hiện được");
    } else {
      res.send(result);
    }
  });
});

module.exports = app;
