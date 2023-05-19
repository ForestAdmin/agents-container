const { Sequelize } = require('sequelize');


async function waitForDb(sequelize) {
    let retries = 5;
    while (retries) {
        try {
            await sequelize.authenticate();
            console.log('Connection has been established successfully.');
            break;
        } catch (error) {
            console.log(`Retrying in 3 seconds... (${retries} retries left)`);
            retries--;
            await new Promise((res) => setTimeout(res, 3000));
        }
    }
}

(async () => {
    console.log(`Waiting for database...`);
    const sequelize = new Sequelize(process.env.DATABASE_URL);
    await waitForDb(sequelize);
    console.log(`Your database is ready!`);
})();
