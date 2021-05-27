const graphql = require('graphql');
const axios = require('axios');

const { GraphQLObjectType, GraphQLList } = graphql;

/** Model Types */
const OrderType = require('./types/order');
const ProductType = require('./types/product');

const RootQuery = new GraphQLObjectType({
  name: 'RootQueryType',
  fields: () => ({
    orders: {
      type: new GraphQLList(OrderType),
      resolve(parentValue, args) {
        return axios
          .get(`http://orders-api:3003/v1/orders`)
          .then(response => response.data);
      }
    },
    products: {
      type: new GraphQLList(ProductType),
      resolve(parentValue, args) {
        return axios
          .get(`http://products-api:3004/v1/products`)
          .then(response => response.data);
      }
    }
  })
});

module.exports = RootQuery;
