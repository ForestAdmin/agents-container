const {DataTypes, Sequelize} = require('sequelize');

function buildSchema(sequelize) {
    sequelize.define(
        'user',
        {
            id: {
                type: DataTypes.INTEGER,
                primaryKey: true,
                autoIncrement: true,
                allowNull: false,
            },
            firstName: {
                type: DataTypes.STRING,
                allowNull: false,
            },
            lastName: {
                type: DataTypes.STRING,
                allowNull: false,
            },
        },
        {
            tableName: 'user',
            underscored: true,
            timestamps: false,
        },
    );

    return sequelize;
}

module.exports = function buildAllSchemas(connectionsString) {
    return connectionsString.map((connectionString) => {
        if (!connectionString) {
            throw new Error(`Invalid connection string: ${connectionString} in ${connectionsString}`);
        }
        return buildSchema(new Sequelize(connectionString))
    });
}
