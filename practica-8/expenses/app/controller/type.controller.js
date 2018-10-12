const db = require('../conf/db.config.js');
const Type = db.type;
const Expense = db.expense;
 
// Init data: Types and expenses
exports.init = (req, res) => {	
	// Food
	Type.create({ 
		name: 'Food', 
		expenses: [
			// Breakfast
			{
                detail: "Breakfast " + new Date(),
                amount: 20
			}
		]
	}, {
		include: [ Expense ]
	}).then(() => {
		res.send("Done!");
	})
};

// Fetch all Types including Expenses
exports.findAll = (req, res) => {
	Type.findAll({
		attributes: ['uuid', 'name', 'priority'],
		include: [{
			model: Expense
			/*,
			where: { fk_typeid: db.Sequelize.col('type.uuid') },
			attributes: ['uuid', 'detail', 'amount']*/
		}]
	}).then(types => {
	   res.send(types);
	});
};
