const express = require('express');
const expressGraphQL = require('express-graphql');
const bodyParser = require('body-parser');
const expressPlayground = require('graphql-playground-middleware-express')
  .default;

const schema = require('./schema/schema');

const app = express();

app.get('/v1/test', (req, res, next) => {
  try {
    res.status(200);
    res.json({ message: 'Synur Ecommerce Platform GraphQL API works' });
  } catch (err) {
    res.status(500);
    res.json({
      error: {
        message: err.message
      }
    });
  }
});

app.get('/playground', expressPlayground({ endpoint: '/v1/graphql' }));

app.use(bodyParser.json());
app.use(
  '/v1/graphql',
  expressGraphQL({
    schema,
    graphiql: true
  })
);

module.exports = app;
