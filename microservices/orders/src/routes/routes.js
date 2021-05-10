const OrdersController = require('../controllers/orders_controller');

const routes = app => {
  // @route    GET api
  // @desc     Get orders
  // @access   Private
  app.get('/v1/orders', OrdersController.get);
};

module.exports = routes;
