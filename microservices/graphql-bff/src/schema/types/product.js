/**
 * Product type
 */
const graphql = require('graphql');
/** Import object types from GraphQL */
const { GraphQLObjectType, GraphQLString } = graphql;

const ProductType = new GraphQLObjectType({
  name: 'ProductType',
  fields: () => ({
    id: { type: GraphQLString },
    name: { type: GraphQLString }
  })
});

module.exports = ProductType;
