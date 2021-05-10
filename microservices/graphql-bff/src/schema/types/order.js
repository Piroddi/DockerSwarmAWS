/**
 * Order type
 */
const graphql = require('graphql');
const axios = require('axios');
/** Import object types from GraphQL */
const { GraphQLObjectType, GraphQLString } = graphql;

const OrderType = new GraphQLObjectType({
  name: 'OrderType',
  fields: () => ({
    id: { type: GraphQLString },
    product: {
      type: require('./product'),
      resolve(parentValue, args) {
        return axios
          .get(
            `${process.env.PRODUCTS_SERVICE_PORT}/v1/products/${parentValue.productId}`
          )
          .then(response => response.data);
      }
    },
    orderFor: { type: GraphQLString },
  })
});

module.exports = OrderType;
