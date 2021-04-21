const User = require("../models/user");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");

exports.user_admin_get = (req, res, next) => {
  User.find()
    .select("email firstname lastname role")
    .exec()
    .then((docs) => {
      res.status(200).json({
        message: "All Users",
        users: docs,
      });
    })
    .catch((err) => {
      res.status(500).json({
        error: err,
      });
    });
};

exports.user_signup = (req, res, next) => {
  User.find({ email: req.body.email })
    .exec()
    .then((doc) => {
      if (doc.length >= 1) {
        res.status(409).json({
          error: "Email-ID already exists!",
        });
      } else {
        bcrypt
          .hash(req.body.password, 10, (err, hash) => {
            if (err)
              return res.status(500).json({ error: err });
            const user = new User({
              email: req.body.email,
              password: hash,
              firstname: req.body.firstname,
              lastname: req.body.lastname,
              role: req.body.role,
            });
            user
              .save()
              .then((result) => {
                res.status(201).json({
                  message: "Account successfully created!",
                  user: user,
                });
              })
              .catch((err) => {
                res.status(500).json({
                  error: err,
                });
              });
          })
          .catch((err) => {
            res.status(500).json({
              error: err,
            });
          });
      }
    });
};

exports.user_login = (req, res, next) => {
  let userSave;
  User.findOne({ email: req.body.email })
    .then((user) => {
      if (!user) {
        return res.status(404).json({
          error: "Invalid email-id or password",
        });
      }
      userSave = user;
      return bcrypt
        .compare(req.body.password, user.password)
        .then((result) => {
          if (!result) {
            return res.status(404).json({
              error: "Invalid email-id or password",
            });
          }
          const token = jwt.sign(
            {
              email: userSave.email,
              userId: userSave._id,
              role: userSave.role,
            },
            "this_is_a_secret_key_by_@man_Sr1vastava",
            {
              expiresIn: "1h",
            }
          );
          res.status(200).json({
            token: token,
            expiresIn: 1,
            userId: userSave._id,
            role: userSave.role,
          });
        })
        .catch((err) => {
          res.status(500).json({ error: err });
        });
    })
    .catch((err) => {
      res.status(500).json({ error: err });
    });
};

exports.user_delete = (req,res,next)=>{
  User.deleteOne({_id:req.params.id}).then((result)=>{
    if(result.deletedCount==0){
      return res.status(404).json({
        error: "User not found!"
      });
    }
    return res.status(200).json({
      message: "User deleted successfully!"
    });
  }).catch((err)=>{
    res.status(500).json({
      error: err
    });
  })
}
