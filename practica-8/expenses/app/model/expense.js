module.exports = (sequelize, Sequelize) => {
	const Expense = sequelize.define('expense', {
        uuid: {
		    	type: Sequelize.UUID,
			defaultValue: Sequelize.UUIDV1,
			primaryKey: true
	    },
	    detail: {
		  type: Sequelize.STRING
	    },
	    amount: {
		  type: Sequelize.FLOAT
        }
	});
	
	return Expense;
}