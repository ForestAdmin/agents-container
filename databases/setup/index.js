const buildAllSchemas = require('./schema');

async function seedData(sequelizeInstances) {
    for (const db of sequelizeInstances) {
        await db.sync({ force: true });
    }
}

(async () => {
    console.log(`Beginning seed...`);
    const instances = buildAllSchemas([process.env.DATABASE_URL]);
    await seedData(instances);
    console.log(`Your database(s) have been seeded!`);
})();
