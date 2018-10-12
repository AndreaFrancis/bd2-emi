module.exports = (sequelize, Sequelize) => {
	const Type = sequelize.define('type', {
	  uuid: {
			type: Sequelize.UUID,
			defaultValue: Sequelize.UUIDV1,
			primaryKey: true
	  },
	  name: {
		  type: Sequelize.STRING
	  },
	  priority: {
			type: Sequelize.INTEGER,
			defaultValue: 0
	  }
	});
	
	return Type;
}