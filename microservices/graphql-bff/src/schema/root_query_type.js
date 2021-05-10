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
          .get(`${process.env.ORDERS_SERVICE_PORT}/v1/orders`)
          .then(response => response.data);
      }
    },
    products: {
      type: new GraphQLList(ProductType),
      resolve(parentValue, args) {
        return axios
          .get(`${process.env.PRODUCTS_SERVICE_PORT}/v1/products`)
          .then(response => response.data);
      }
    }
  })
});

module.exports = RootQuery;
