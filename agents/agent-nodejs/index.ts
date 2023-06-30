import type { Schema } from './typings';

import 'dotenv/config';
import { createAgent } from '@forestadmin/agent';
import { createSqlDataSource } from '@forestadmin/datasource-sql';

const dialectOptions: { [name: string]: any } = {};

if (process.env.DATABASE_SSL && JSON.parse(process.env.DATABASE_SSL.toLowerCase())) {
  // Set to false to bypass SSL certificate verification (useful for self-signed certificates).
  const rejectUnauthorized =
    process.env.DATABASE_REJECT_UNAUTHORIZED &&
    JSON.parse(process.env.DATABASE_REJECT_UNAUTHORIZED.toLowerCase());
  dialectOptions.ssl = rejectUnauthorized ? true : { require: true, rejectUnauthorized };
}

const agent = createAgent<Schema>({
  authSecret: process.env.FOREST_AUTH_SECRET!,
  envSecret: process.env.FOREST_ENV_SECRET!,
  forestServerUrl: process.env.FOREST_SERVER_URL!,
  isProduction: process.env.NODE_ENV === 'production',
  // typingsPath: './typings.ts',
  typingsMaxDepth: 5,
});

agent.addDataSource(
  createSqlDataSource({
    uri: process.env.DATABASE_URL,
    schema: process.env.DATABASE_URL.includes('postgres') ? process.env.DATABASE_SCHEMA : undefined,
    dialectOptions,
  }),
);

agent.mountOnStandaloneServer(Number(process.env.APPLICATION_PORT));

// Start the agent.
agent.start().catch(error => {
  console.error('\x1b[31merror:\x1b[0m Forest Admin agent failed to start\n');
  console.error('');
  console.error(error.stack);
  process.exit(1);
});
