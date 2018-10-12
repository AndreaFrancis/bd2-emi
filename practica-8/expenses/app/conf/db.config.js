const env = require('./env');
const Sequelize = require('sequelize');

const sequelize = new Sequelize(env.database, env.username, env.password, {
    host: env.host,
    dialect: env.dialect
  });

const db = {};
 
db.Sequelize = Sequelize;
db.sequelize = sequelize;

db.type = require('../model/type.js')(sequelize, Sequelize);
db.expense = require('../model/expense.js')(sequelize, Sequelize);
 
db.type.hasMany(db.expense, {foreignKey: 'fk_typeid', sourceKey: 'uuid'});
db.expense.belongsTo(db.type, {foreignKey: 'fk_typeid', targetKey: 'uuid'});
 
module.exports = db;
